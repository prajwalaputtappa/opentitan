// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

use anyhow::{bail, Result};

use safe_ftdi as ftdi;
use std::cell::RefCell;
use std::rc::Rc;

use crate::io::gpio::Gpio;
use crate::io::spi::Target;
use crate::io::uart::Uart;
use crate::transport::{Capabilities, Capability, Transport};

pub mod gpio;
pub mod mpsse;
pub mod spi;
pub mod uart;

#[derive(Default)]
pub struct Ultradebug {
    pub usb_vid: Option<u16>,
    pub usb_pid: Option<u16>,
    pub usb_serial: Option<String>,
    internal: RefCell<Internal>,
}

#[derive(Default)]
struct Internal {
    // A ref-counted pointer to an MPSSE context for FTDI interface B.  This is needed because
    // interface B contains both the SPI and GPIO functions on ultradebug.
    pub mpsse_b: Option<Rc<RefCell<mpsse::Context>>>,
}

impl Ultradebug {
    pub const VID_GOOGLE: u16 = 0x18d1;
    pub const PID_ULTRADEBUG: u16 = 0x0304;

    /// Create a new `Ultradebug` struct, optionally specifying the USB vid/pid/serial number.
    pub fn new(usb_vid: Option<u16>, usb_pid: Option<u16>, usb_serial: Option<String>) -> Self {
        Ultradebug {
            usb_vid,
            usb_pid,
            usb_serial,
            ..Default::default()
        }
    }

    /// Construct an `ftdi::Device` for the specified `interface` on the Ultradebug device.
    pub fn from_interface(&self, interface: ftdi::Interface) -> Result<ftdi::Device> {
        Ok(ftdi::Device::from_description_serial(
            interface,
            self.usb_vid.unwrap_or(Ultradebug::VID_GOOGLE),
            self.usb_pid.unwrap_or(Ultradebug::PID_ULTRADEBUG),
            None,
            self.usb_serial.clone(),
        )?)
    }

    // Create an instance of an MPSSE context bound to Ultradebug interface B.
    // This is both the SPI and GPIO block on ultradebug.
    fn mpsse_interface_b(&self) -> Result<Rc<RefCell<mpsse::Context>>> {
        let mut internal = self.internal.borrow_mut();
        if internal.mpsse_b.is_none() {
            let device = self.from_interface(ftdi::Interface::B)?;
            // Read and write timeouts:
            device.set_timeouts(5000, 5000);

            // Create a new MPSSE context and configure it
            let mut mpdev = mpsse::Context::new(device)?;
            mpdev.gpio_direction.insert(
                mpsse::GpioDirection::OUT_0 |   // Clock out
                mpsse::GpioDirection::OUT_1 |   // Master out
                                                // Pin 2 is Master In
                mpsse::GpioDirection::OUT_3 |   // Chip select
                mpsse::GpioDirection::OUT_4 |   // SPI_ZB
                mpsse::GpioDirection::OUT_5 |   // RESET_B
                mpsse::GpioDirection::OUT_6 |   // BOOTSTRAP
                mpsse::GpioDirection::OUT_7, // TGT_RESET
            );

            let _ = mpdev.gpio_get()?;
            // Clear the low 3 bits as they are mapped to the SPI pins.
            // The SPI chip select is managed like a normal GPIO.
            // We don't need to change the GPIOs immediately; it is sufficient
            // to cache the value before the next GPIO operation.
            mpdev.gpio_value &= 0xF8;
            internal.mpsse_b = Some(Rc::new(RefCell::new(mpdev)));
        }
        Ok(Rc::clone(internal.mpsse_b.as_ref().unwrap()))
    }

    /// Construct an `mpsse::Context` for the requested interface.
    pub fn mpsse(&self, interface: ftdi::Interface) -> Result<Rc<RefCell<mpsse::Context>>> {
        match interface {
            // Note: we may want to be able to create an MPSSE for interface A in the future.
            // There are enough IOs for a second SPI bus or for JTAG or I2C busses.
            // For now, only interface B is supported.
            ftdi::Interface::B => self.mpsse_interface_b(),
            _ => {
                bail!(
                    "I don't know how to create an MPSSE context for interface {:?}",
                    interface
                );
            }
        }
    }
}

impl Transport for Ultradebug {
    fn capabilities(&self) -> Capabilities {
        Capabilities::new(Capability::UART | Capability::GPIO | Capability::SPI)
    }

    fn uart(&self) -> Result<Box<dyn Uart>> {
        Ok(Box::new(uart::UltradebugUart::open(self)?))
    }

    fn gpio(&self) -> Result<Box<dyn Gpio>> {
        Ok(Box::new(gpio::UltradebugGpio::open(self)?))
    }

    fn spi(&self) -> Result<Box<dyn Target>> {
        Ok(Box::new(spi::UltradebugSpi::open(self)?))
    }
}

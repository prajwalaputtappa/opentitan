// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#ifndef OPENTITAN_SW_DEVICE_LIB_DIF_DIF_UART_H_
#define OPENTITAN_SW_DEVICE_LIB_DIF_DIF_UART_H_

/**
 * @file
 * @brief <a href="/hw/ip/uart/doc/">UART</a> Device Interface Functions
 */

#include <stdint.h>

#include "sw/device/lib/base/mmio.h"

#include "sw/device/lib/dif/autogen/dif_uart_autogen.inc"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

/**
 * A parity state: odd, or even.
 */
typedef enum dif_uart_parity {
  /**
   * Indicates the "odd" parity.
   */
  kDifUartParityOdd = 0,
  /**
   * Indicates the "even" parity.
   */
  kDifUartParityEven,
} dif_uart_parity_t;

/**
 * Runtime configuration for UART.
 *
 * This struct describes runtime information for one-time configuration of the
 * hardware.
 */
typedef struct dif_uart_config {
  /**
   * The UART baudrate.
   */
  uint32_t baudrate;
  /**
   * The frequency of the clock driving the UART.
   */
  uint32_t clk_freq_hz;
  /**
   * Whether to enable parity checking.
   */
  dif_toggle_t parity_enable;
  /**
   * The parity to set.
   */
  dif_uart_parity_t parity;
} dif_uart_config_t;

/**
 * The result of a UART operation.
 */
typedef enum dif_uart_config_result {
  /**
   * Indicates that the operation succeeded.
   */
  kDifUartConfigOk = kDifOk,
  /**
   * Indicates some unspecified failure.
   */
  kDifUartConfigError = kDifError,
  /**
   * Indicates that some parameter passed into a function failed a
   * precondition.
   *
   * When this value is returned, no hardware operations occurred.
   */
  kDifUartConfigBadArg = kDifBadArg,
  /**
   * Indicates that the given configuration parameters are not valid.
   */
  kDifUartConfigBadConfig,
  /**
   * Indicates that the calculated NCO value was not valid.
   */
  kDifUartConfigBadNco,
} dif_uart_config_result_t;

/**
 * A UART FIFO watermark depth configuration.
 */
typedef enum dif_uart_watermark {
  /**
   * Indicates a one-byte watermark.
   */
  kDifUartWatermarkByte1 = 0,
  /**
   * Indicates a four-byte watermark.
   */
  kDifUartWatermarkByte4,
  /**
   * Indicates an eight-byte watermark.
   */
  kDifUartWatermarkByte8,
  /**
   * Indicates a sixteen-byte watermark.
   */
  kDifUartWatermarkByte16,
  /**
   * Indicates a thirty-byte watermark.
   */
  kDifUartWatermarkByte30,
} dif_uart_watermark_t;

/**
 * A UART FIFO reset selection.
 */
typedef enum dif_uart_fifo_reset {
  /**
   * Indicates that the RX FIFO should be reset.
   */
  kDifUartFifoResetRx = 0,
  /**
   * Indicates that the TX FIFO should be reset.
   */
  kDifUartFifoResetTx,
  /**
   * Indicates that both FIFOs should be reset.
   */
  kDifUartFifoResetAll,
} dif_uart_fifo_reset_t;

/**
 * A UART system/line loopback configuration.
 */
typedef enum dif_uart_loopback {
  /**
   * Indicates that outgoing TX bits should be recieved through RX.
   */
  kDifUartLoopbackSystem = 0,
  /**
   * Indicates that incoming RX bits should be forwarded to TX.
   */
  kDifUartLoopbackLine,
} dif_uart_loopback_t;

/**
 * The size of the UART TX and RX FIFOs, in bytes.
 */
extern const uint32_t kDifUartFifoSizeBytes;

/**
 * Creates a new handle for UART.
 *
 * This function does not actuate the hardware.
 *
 * @param base_addr Base address of the UART peripheral.
 * @param[out] uart Out param for the initialized handle.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_init(mmio_region_t base_addr, dif_uart_t *uart);

/**
 * Configures UART with runtime information.
 *
 * This function should need to be called once for the lifetime of `handle`.
 *
 * @param uart A UART handle.
 * @param config Runtime configuration parameters.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_uart_config_result_t dif_uart_configure(const dif_uart_t *uart,
                                            dif_uart_config_t config);

/**
 * Sets the RX FIFO watermark.
 *
 * This function is only useful when the corresponding interrupt is enabled.
 * When the queued RX FIFO number of bytes rises to or above this
 * level, the RX watermark interrupt is raised.
 *
 * @param uart A UART handle.
 * @param watermark RX FIFO watermark.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_watermark_rx_set(const dif_uart_t *uart,
                                       dif_uart_watermark_t watermark);

/**
 * Sets the TX FIFO watermark.
 *
 * This function is only useful when the corresponding interrupt is enabled.
 * When the queued RX FIFO number of bytes rises to or above this
 * level, the RX watermark interrupt is raised.
 *
 * @param uart A UART handle.
 * @param watermark TX FIFO watermark.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_watermark_tx_set(const dif_uart_t *uart,
                                       dif_uart_watermark_t watermark);

/**
 * Sends bytes over UART.
 *
 * Can be used from inside an UART ISR.
 *
 * This function attempts to write `bytes_requested` number of bytes to the
 * UART TX FIFO from `bytes_requested`, and passes `bytes_written` back to
 * the caller. `bytes_written` is optional, NULL should be passed in if the
 * value is not needed.
 *
 * @param uart A UART handle.
 * @param data Data to be written.
 * @param bytes_requested Number of bytes requested to be written by the caller.
 * @param[out] bytes_written Number of bytes written (optional).
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_bytes_send(const dif_uart_t *uart, const uint8_t *data,
                                 size_t bytes_requested, size_t *bytes_written);

/**
 * Recieves bytes over UART.
 *
 * Can be used from inside an UART ISR.
 *
 * This function attempts to read `bytes_requested` number of bytes from the
 * UART RX FIFO into `data`, and passes `bytes_read` back to the caller.
 * `bytes_read` is optional, NULL should be passed in if the value is not
 * needed.
 *
 * @param uart A UART handle.
 * @param bytes_requested Number of bytes requested to be read by the caller.
 * @param[out] data Buffer for up to `bytes_requested` bytes of read data.
 * @param[out] bytes_read Number of bytes read (optional).
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_bytes_receive(const dif_uart_t *uart,
                                    size_t bytes_requested, uint8_t *data,
                                    size_t *bytes_read);

/**
 * Transmits a single UART byte (polled).
 *
 * This operation is polled, and will busy wait until a byte has been sent.
 *
 * Must not be used inside an ISR.
 *
 * @param uart A UART handle.
 * @param byte Byte to be transmitted.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_byte_send_polled(const dif_uart_t *uart, uint8_t byte);

/**
 * Receives a single UART byte (polled).
 *
 * This operation is polled, and will busy wait until a byte has been read.
 *
 * Must not be used inside an ISR.
 *
 * @param uart A UART handle.
 * @param[out] byte Received byte.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_byte_receive_polled(const dif_uart_t *uart,
                                          uint8_t *byte);

/**
 * Gets the number of bytes available to be read from the UART RX FIFO.
 *
 * This function can be used to check FIFO full and empty conditions.
 *
 * @param uart A UART handle.
 * @param[out] num_bytes Number of bytes available to be read.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_rx_bytes_available(const dif_uart_t *uart,
                                         size_t *num_bytes);

/**
 * Gets the number of bytes available to be written from the UART TX FIFO.
 *
 * This function can be used to check FIFO full and empty conditions.
 *
 * @param uart A UART handle.
 * @param[out] num_bytes Number of bytes available to be written.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_tx_bytes_available(const dif_uart_t *uart,
                                         size_t *num_bytes);

/**
 * UART TX reset RX/TX FIFO.
 *
 * Resets one or both FIFOs. If the byte is in transit, this function will
 * not abort the operation.
 *
 * @param uart A UART handle.
 * @param reset FIFO to reset (RX, TX or both).
 * @return The result of the operation.
 */
dif_result_t dif_uart_fifo_reset(const dif_uart_t *uart,
                                 dif_uart_fifo_reset_t reset);

/**
 * Enables or disables a transmit/receive loopback.
 *
 * This API can be used for testing, such as to validate transmit and receive
 * routines.
 *
 * Loopback should only be enabled when device is in the IDLE state to prevent
 * data loss/coruption. Behaviour depends on the `loopback` parameter:
 *    - `kDifUartLoopbackSystem`:
 *      Receives the data that is being transmitted. No external data can be
 *      received (from the RX line). When enabled the TX line goes high.
 *    - `kDifUartLoopbackLine`:
 *      Transmits the data that is being received. No internal data can be
 *      sent out (from the TX FIFO). When enabled the RX line goes high.
 *
 * @param uart A UART handle.
 * @param loopback Loopback type (transmit/receive).
 * @param enable Enable/disable control flag.
 * @return The result of the operation.
 */
dif_result_t dif_uart_loopback_set(const dif_uart_t *uart,
                                   dif_uart_loopback_t loopback,
                                   dif_toggle_t enable);

/**
 * Enables the RX timeout with the given duration.
 *
 * @param uart A UART handle.
 * @param duration_ticks RX timeout value in UART bit times (using the baud rate
 * clock as reference) in the range [0,0xffffff].
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_enable_rx_timeout(const dif_uart_t *uart,
                                        uint32_t duration_ticks);

/**
 * Disables the RX timeout.
 *
 * In addition to disabling the RX timeout the timeout duration is reset to 0
 * ticks.
 *
 * @param uart A UART handle.
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_disable_rx_timeout(const dif_uart_t *uart);

/**
 * Gets the current status of the RX timeout control.
 *
 * @param uart A UART handle.
 * @param[out] status The status of the RX timeout control (enabled or
 * disabled).
 * @param[out] duration_ticks RX timeout value in UART bit times (using the baud
 * rate clock as reference) in the range [0,0xffffff] (optional).
 * @return The result of the operation.
 */
OT_WARN_UNUSED_RESULT
dif_result_t dif_uart_get_rx_timeout(const dif_uart_t *uart,
                                     dif_toggle_t *status,
                                     uint32_t *duration_ticks);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // OPENTITAN_SW_DEVICE_LIB_DIF_DIF_UART_H_

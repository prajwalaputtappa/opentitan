# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

from enum import IntEnum


class Cmd(IntEnum):
    '''Permitted values of the CMD register.'''
    EXECUTE = 0x01
    SEC_WIPE_DMEM = 0x02
    SEC_WIPE_IMEM = 0x03


class Status(IntEnum):
    '''Permitted values of the STATUS register.'''
    IDLE = 0x00
    BUSY_EXECUTE = 0x01
    BUSY_SEC_WIPE_DMEM = 0x02
    BUSY_SEC_WIPE_IMEM = 0x03


class ErrBits(IntEnum):
    '''A copy of the list of bits in the ERR_BITS register.'''
    BAD_DATA_ADDR = 1 << 0
    BAD_INSN_ADDR = 1 << 1
    CALL_STACK = 1 << 2
    ILLEGAL_INSN = 1 << 3
    LOOP = 1 << 4
    IMEM_INTG_VIOLATION = 1 << 5
    DMEM_INTG_VIOLATION = 1 << 6
    REG_INTG_VIOLATION = 1 << 7
    ILLEGAL_BUS_ACCESS = 1 << 8
    LIFECYCLE_ESCALATION = 1 << 9

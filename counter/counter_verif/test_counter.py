### THIS CODE WILL NOT WORK

# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import os
import random
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from model_counter import *

@cocotb.test()
async def test_mac(dut):
    """Test to mac " 

    clock = Clock(dut.CLK, 10, units="us")  # Create a 10us period clock on port clk
    # Start the clock. Start it low to avoid issues on the first RisingEdge
    cocotb.start_soon(clock.start(start_high=False))

    # reset; adjust clocks accordingly
    dut.RST_N.value = 0
    for in in range(1, 10):
        await RisingEdge(dut.CLK)
    dut.RST_N.value = 1

    # drive inputs
    dut.EN_increment.value = 1
    dut.increment_di.value = 10

    # call the model
    expected_output = model_mac(openrand)

    if (dut.RDY_module_output.value != 1):
        await RisingEdge(dut.CLK)     
    
    assert int(expected_output) == int(dut.module_output.value), f'Counter Output Mismatch, Expected = {counter_out} DUT = {int(dut.read.value)}'



    

    ini = int(dut.read.value)
    

    

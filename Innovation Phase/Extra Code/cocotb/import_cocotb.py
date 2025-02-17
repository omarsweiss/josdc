import cocotb
from cocotb.triggers import RisingEdge, ClockCycles, Timer
from cocotb.clock import Clock


async def generate_clock(dut):

    Testing = True #make false when done test
    for cycle in range(10):
        dut.clk.value = 0
        await Timer(50, units="ns")
        dut.clk.value = 1
        await Timer(50, units="ns")


@cocotb.test()
async def test_dut(dut):
    await cocotb.start(generate_clock(dut))  # run the clock "in the background"

    await Timer(5, units="ns")  # wait a bit
    await FallingEdge(dut.clk)  # wait for falling edge/"negedge"

    dut._log.info("my_signal_1 is %s", dut.PC.value)

    pass
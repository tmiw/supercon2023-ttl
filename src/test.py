import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_my_design(dut):
    dut._log.info("start")

    clock = Clock(dut.clk, 50, units="ns")
    cocotb.start_soon(clock.start())

    dut.ui_in.value = 192
    dut.rst_n.value = 0 # low to reset
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1 # take out of reset

    for i in range(0, 4000):
        await ClockCycles(dut.clk, 1)
        #dut._log.info(f"{dut.uio_out.value}")
    assert str(dut.uio_oe.value) == "11111111"
    assert str(dut.uio_out.value) == "01000101"

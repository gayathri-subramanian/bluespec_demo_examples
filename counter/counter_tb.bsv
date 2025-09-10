import counter::*;

module mkCounterTestbench();

    Counter_Ifc counter <- mkCounter();

    // Register to track test state
    Reg#(int) state <- mkReg(0);

    rule increment_then_wait (state == 0);
        counter.increment(2);
        $display("Cycle %0d: Incremented by 2", 0);
        state <= 1;
    endrule


    rule read_after_wait (state == 1);
        int val = counter.read();
        $display("Cycle %0d: Read value = %0d (should be 2)", 2, val);
        state <= 3;
        $finish(); // End simulation after reading
    endrule

endmodule

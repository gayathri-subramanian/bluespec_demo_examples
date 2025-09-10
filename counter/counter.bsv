package counter;

interface Counter_Ifc;
method int read(); // Read the counter’s value
method Action increment (int di); // Step the counter up by di
method Action decrement (int dd); // Step the counter down by dd
endinterface: Counter_Ifc


// Version 1 of the counter

(* synthesize *)

module mkCounter (Counter_Ifc);

Reg#(int) value1 <- mkReg(0); // holding the counter’s value

method int read();
return value1;
endmethod

method Action increment (int di);
value1 <= value1 + di;
endmethod

method Action decrement (int dd);
value1 <= value1 - dd;
endmethod

endmodule: mkCounter

endpackage

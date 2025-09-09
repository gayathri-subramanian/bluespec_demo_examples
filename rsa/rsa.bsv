package rsa;

interface RSA_Ifc;
    method Action start(Bit#(32) base, Bit#(32) exponent, Bit#(32) modulus);
    method Bool busy();
    method Bit#(32) result();
    method Bool done();
    method Bool ready();
endinterface

typedef enum {IDLE, RUNNING} State deriving (Bits, Eq);

module mkRSA(RSA_Ifc);

    Reg#(Bit#(32)) base_reg   <- mkReg(0);
    Reg#(Bit#(32)) exp_reg    <- mkReg(0);
    Reg#(Bit#(32)) mod_reg    <- mkReg(1); // avoid div0
    Reg#(Bit#(32)) res_reg    <- mkReg(1);
    Reg#(Bit#(6))  bitpos_reg <- mkReg(0); // up to 32 bits

    Reg#(State) state <- mkReg(IDLE);

    rule step (state == RUNNING);
        res_reg  <= ((exp_reg[0] == 1) ? (res_reg * base_reg) % mod_reg : res_reg);
        base_reg <= (base_reg * base_reg) % mod_reg;
        exp_reg  <= exp_reg >> 1;
        bitpos_reg <= bitpos_reg + 1;

        // When fully shifted out, move to IDLE immediately
        if (exp_reg == 0)
            state <= IDLE;
    endrule

    method Action start(Bit#(32) base, Bit#(32) exponent, Bit#(32) modulus);
        if (state == IDLE) begin
            mod_reg   <= (modulus == 0) ? 1 : modulus;
            base_reg  <= (modulus == 0) ? base : base % modulus;
            exp_reg   <= exponent;
            res_reg   <= 1;
            bitpos_reg <= 0;
            state     <= RUNNING;
        end else
            $display("Already busy");
    endmethod

    method Bool busy();
        return (state == RUNNING);
    endmethod

    method Bit#(32) result();
        return res_reg;
    endmethod

    method Bool done();
        // Done when RSA is idle and exponent fully consumed
        return (state == IDLE && exp_reg == 0 && bitpos_reg != 0);
    endmethod

    method Bool ready();
        return (state == IDLE);
    endmethod

endmodule

endpackage

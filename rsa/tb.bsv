package tb;

import rsa::*;

module mkTestbench();

    RSA_ExpIfc rsa <- mkRSA_Exp();

    Reg#(Bit#(3)) state <- mkReg(0);

    Reg#(Bit#(32)) ciphertext <- mkReg(0);


    rule start_encrypt (state == 0 && rsa.ready());
        rsa.start(65, 17, 3233); // plaintext, public exponent, modulus
        state <= 1;
    endrule

    rule wait_encrypt_done (state == 1 && rsa.done());
        ciphertext <= rsa.result();
        $display("Ciphertext: %0d", rsa.result());  // print encrypted value
        state <= 2;
    endrule


    rule start_decrypt (state == 2 && rsa.ready());
        rsa.start(ciphertext, 2753, 3233); // ciphertext, private exponent, modulus
        state <= 3;
    endrule

    rule wait_decrypt_done (state == 3 && rsa.done());
        Bit#(32) decrypted = rsa.result();
        $display("Decrypted: %0d", decrypted);
        $finish;
    endrule

endmodule

endpackage

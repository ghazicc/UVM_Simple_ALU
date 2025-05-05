module ALU (
  input logic reset,            // Reset input
  input logic clk,              // Clock input
  input logic [7:0] A, B,       // 8-bit input operands
  input logic [3:0] selection,  // 4-bit selection input for ALU operation
  output logic [7:0] result,    // 8-bit output result of operation
  output logic carry_out        // Carry output
);

always_ff @(posedge clk or posedge reset) begin
  if (reset) begin
    result     <= 8'b0;
    carry_out  <= 1'b0;
  end else begin
    unique case (selection)
      4'b0000: {carry_out, result} <= A + B;
      4'b0001: {carry_out, result} <= A - B;
      4'b0010: begin
        result     <= A & B;
        carry_out  <= 1'b0;
      end
      4'b0011: begin
        result     <= A | B;
        carry_out  <= 1'b0;
      end
      4'b0100: begin
        result     <= A ^ B;
        carry_out  <= 1'b0;
      end
      4'b0101: begin
        if (B != 0) begin
          result     <= A / B;
          carry_out  <= 1'b0;
        end else begin
          result     <= 8'b0;
          carry_out  <= 1'b1;
        end
      end
      4'b0110: begin
        result     <= A << B[2:0];
        carry_out  <= A[7 - B[2:0]]; 
      end
      4'b0111: begin
        result     <= A >> B[2:0];
        carry_out  <= A[B[2:0] - 1]; 
      end
      4'b1000: begin
        result     <= ~(A & B); 
        carry_out  <= 1'b0;
      end
      default: begin
        result     <= 8'b0;
      end
    endcase
  end
end

endmodule
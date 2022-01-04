module alu_control (
  input           [1:0] alu_op,    // ALUOp có độ dài 2 bit
  input                 instr_30, // Instruction[30]
  input           [2:0] instr_14_12,  // Instruction[14-12]
  output  logic   [3:0] alu_control  // alu_control 4 bit
  
);
localparam  ADD = 4'b0010, // 
            SUB = 4'b0110,
            AND = 4'b0000,
            OR  = 4'b0001;

localparam  LW_SW  = 2'b00,
            BEQ    = 2'b01,
            R_TYPE = 2'b10;

always_comb begin : proc_alu_control
  case (alu_op)
    LW_SW : alu_control = ADD;  //Nếu alu_op = LW_SW thì alu_control = ADD
    BEQ   : alu_control = SUB;  //Nếu alu_op = BEQ thì alu_control = SUB
    R_TYPE: case({instr_30, instr_14_12})  // Nếu alu_control = R_TYPE thì t có 4 trường hợp xảy ra
              4'b0000: alu_control = ADD;  //Nếu instr30, instr14_12 = 0000 thì alu_control = ADD
              4'b1000: alu_control = SUB;
              4'b0111: alu_control = AND;
              4'b0110: alu_control = OR;
                default: alu_control = 4'b1111;
    endcase // {instr_30, instr_14_12}
    default: alu_control = 4'b1111;
  endcase // alu_op
end

endmodule : alu_control
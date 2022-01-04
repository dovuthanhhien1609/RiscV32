`timescale 10ns/100ps
module tb_riscv_pipeline_top ();
logic clk;
logic reset_n;

riscv_pipeline_top riscv_pipeline_top(
  .clk    (clk    ),
  .reset_n(reset_n)
  );

always #5 clk = ~clk;

initial begin
  clk = 0;
  reset_n = 1;
  repeat(1) @(negedge clk);
  reset_n = 0;
  repeat(1) @(negedge clk);
  reset_n = 1;
  repeat(32) @(posedge clk);
  $finish;
end

endmodule : tb_riscv_pipeline_top
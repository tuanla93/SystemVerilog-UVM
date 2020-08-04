// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "test.sv"

module tb_top();
  bit clk;
  bit resetn;
  
  // Clock generation
  always #5 clk = ~clk;
  
  // Reset generation
  initial begin
    resetn = 1'b0;
    #6 resetn = 1'b1;
  end
  
  // Dump waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top);
  end
  
  // Instantiate Interface
  intf i_intf(.clk(clk), .resetn(resetn));
  
  test t1(i_intf);
  
  comp_32bs DUT(
    .clk(i_intf.clk),
    .resetn(i_intf.resetn),
    .sign(i_intf.sign),
    .op1(i_intf.op1),
    .op2(i_intf.op2),
    .eq(i_intf.eq),
    .neq(i_intf.neq),
    .grt(i_intf.grt),
    .lss(i_intf.lss)
  );
  
endmodule

// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "rand_test.sv"
`include "checker.sv"

module tb_top;
  //import "DPI-C" function int comp_32bs_cmodel(int sign, int arg_op1, int arg_op2);
  bit clk;
  bit resetn;
  
  // Clock generator
  always #5 clk = ~clk;
  
  // Reset generator
  initial begin
    //$display(comp_32bs_cmodel(0, 1, 2));
    resetn = 1'b0;
    #11 resetn = 1'b1;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top.DUT);
  end
  
  // Interface
  intf i_intf(clk, resetn);
  
  // Test
  test i_test(i_intf);
  
  // Checker
  //checker_module checker_0(
  //  .clk(i_intf.clk),
  //  .resetn(i_intf.resetn),
  //  .eq(i_intf.eq),
  //  .neq(i_intf.neq),
  //  .grt(i_intf.grt),
  //  .lss(i_intf.lss)
  //);
  
  // Normal connection
  //checker_mod checker_0(i_intf);
  
  // Connect using binding method
  bind tb_top.DUT   checker_mod   U_assert_ip (.i_intf(tb_top.i_intf), .less(tb_top.DUT.less), .equal(tb_top.DUT.equal));
  //bind tb_top.DUT   checker_mod   U_assert_ip (.i_intf(tb_top.i_intf));
  
  //// Assertion Sequence
  //sequence rst_seq_eq;
  //  (i_intf.eq == 1'b0); /// WHYYY
  //endsequence
  //sequence rst_seq_neq;
  //  (i_intf.neq == 1'b0);
  //endsequence
  //sequence rst_seq_grt;
  //  (i_intf.grt == 1'b0);
  //endsequence
  //sequence rst_seq_lss;
  //  (i_intf.lss == 1'b0);
  //endsequence
  //
  //property rst_prop;
  //  //@(posedge i_intf.clk) (i_intf.resetn == 1'b0) |=> rst_seq_eq |-> rst_seq_neq |-> rst_seq_grt |-> rst_seq_lss;
  //  @(posedge i_intf.clk) (i_intf.resetn == 1'b0) |=> rst_seq_eq;
  //  //@(posedge i_intf.clk) rst_seq_eq |-> rst_seq_neq;
  //  //@(posedge i_intf.clk) rst_seq_neq |-> rst_seq_grt;
  //  //@(posedge i_intf.clk) rst_seq_grt |-> rst_seq_lss;
  //endproperty
  
  
  //calling assert property
  //assert_1: assert property(rst_prop) $info("ASSERTION PASSED"); else $info("ASSERTION FAILED!");
  //assert_1: assert property(rst_prop) $info("ASSERTION PASSED");
  
  // Test Reset:
  initial begin
    #126 resetn = 1'b0;
    #10  resetn = 1'b1;
  end
    
  
  // DUT
  comp_32bs DUT(
    .clk(i_intf.clk),
    .resetn(i_intf.resetn),
    
    // Input
    .sign(i_intf.sign),
    .op1(i_intf.op1),
    .op2(i_intf.op2),
    
    // Output
    .eq(i_intf.eq),
    .neq(i_intf.neq),
    .grt(i_intf.grt),
    .lss(i_intf.lss)
  );
endmodule


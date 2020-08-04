interface intf(
  input clk,
  input resetn
);
  
  logic sign;
  logic [31:0] op1, op2;
  logic eq, neq, grt, lss;
  
  //// Comparator interface
  //modport checker_mod(
  //  output sign, op1, op2, eq, neq, grt, lss,
  //  input clk, resetn//
  //);
  //modport master(
  //  output sign, op1, op2,
  //  input  clk, resetn, eq, neq, grt, lss
  //);
  //modport slave(
  //  input  clk, resetn, sign, op1, op2,
  //  output eq, neq, grt, lss
  //);
  
endinterface

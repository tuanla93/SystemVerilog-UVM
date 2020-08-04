interface intf(
  input clk,
  input resetn
);
  
  logic sign;
  logic [31:0] op1;
  logic [31:0] op2;
  logic eq;
  logic neq;
  logic grt;
  logic lss;
  
endinterface

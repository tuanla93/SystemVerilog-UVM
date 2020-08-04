class transaction;
  
  rand bit sign;
  rand bit [31:0] op1;
  rand bit [31:0] op2;
  bit eq;
  bit neq;
  bit grt;
  bit lss;
  
  function void display(string name);
    $display("--- [ %s ] ---", name);
    $display("- [%d] %d ??? %d :", sign, op1, op2);
    $display("- Equal: %d", eq);
    $display("- Not Equal: %d", neq);
    $display("- Greater: %d", grt);
    $display("- Less: %d", lss);
    $display("--------------");
  endfunction
  
endclass

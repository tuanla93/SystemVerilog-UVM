class transaction;
  rand bit sign;
  rand bit [31:0] op1;
  rand bit [31:0] op2;
  bit eq;
  bit neq;
  bit grt;
  bit lss;
  
  function void display(string name);
    $display("---- %s ----", name);
    $display("- Sign = %d", sign);
    $display("- Operand 1 = %X (%d)", op1, op1[31]);
    $display("- Operand 2 = %X (%d)", op2, op2[31]);
    $display("- Equal = %d; NotEqual = %d", eq, neq);
    $display("- Grt   = %d; Less     = %d", grt, lss);
    $display("--------------------");
  endfunction
endclass

`include "environment.sv"

program test(intf intf);
  
  environment env;
  int testcase = 10;
  
  initial begin
    env = new(testcase, intf);
    env.run();
  end
  
endprogram

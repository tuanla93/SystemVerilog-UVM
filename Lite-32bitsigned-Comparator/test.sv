`include "environment.sv"

program test(intf p_intf);
  
  // Environment declare
  environment env;
  
  initial begin
    // Call Constructor
    env = new(p_intf);
    
    // Config no of test case
    env.gen.testcase = 2;
    
    // Run
    env.run();
  end
  
endprogram

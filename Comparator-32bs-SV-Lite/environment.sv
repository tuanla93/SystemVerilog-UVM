`include "transaction.sv" // For generator and driver
`include "generator.sv"
`include "driver.sv"

class environment;
  
  mailbox gen2drv;
  generator gen;
  driver    drv;
  
  virtual intf vif;
  
  function new (virtual intf vif);
    this.vif = vif;
    
    gen2drv = new();
    gen = new(gen2drv);
    drv = new(vif, gen2drv);
  endfunction
  
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    fork
      gen.main();
      drv.main();
    join_any
  endtask
  
  task post_test();
    wait(gen.ended.triggered);
    wait(gen.testcase == drv.no_trans);
    $display("PostTest Mailbox Num = %d", gen2drv.num());
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
    repeat(2) @(posedge vif.clk);
    $finish;
  endtask
  
endclass

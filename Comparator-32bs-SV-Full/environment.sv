`include "transaction.sv"
`include "driver.sv"
`include "generator.sv"
`include "scoreboard.sv"
`include "monitor.sv"


class environment;
  // Mailbox for gen2drv and mon2scb
  mailbox gen2drv;
  mailbox mon2scb;
  
  int testcase;
  
  driver drv;
  generator gen;
  scoreboard scb;
  monitor mon;
  
  virtual intf vif;
  
  function new (int testcase, virtual intf vif);
    this.vif = vif;
    this.testcase = testcase;
    
    gen2drv = new();
    mon2scb = new();
    
    gen = new(testcase, gen2drv);
    drv = new(gen2drv, vif);
    
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction
  
  
  // Test RUN
  task pre_test;
    // reset inital value for tb
    drv.reset();
  endtask
  
  task test;
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join_any
  endtask
  
  task post_test;
    wait(gen.ended.triggered);
    wait(testcase == drv.no_trans);
    wait(testcase == mon.no_trans);
    wait(testcase == scb.no_trans);
  endtask
    
  
  task run;
    pre_test();
    $display ("ENV TestCase = %d", testcase);
    test();
    post_test();
    repeat(5) @(posedge vif.clk);
    #10 $finish;
  endtask
  
  
  
endclass

class generator;
  int testcase;
  mailbox gen2drv;
  transaction trans;
  
  function new(int testcase, mailbox gen2drv);
    this.testcase = testcase;
    this.gen2drv  = gen2drv;
  endfunction
  
  event ended;
  task main;
    $display ("GEN %d", testcase);
    repeat(testcase) begin
      //$display ("GENERATOR %d", testcase);
      trans = new();
      if(!trans.randomize()) $fatal("GENERATOR: Cannot gen transaction package!");
      //trans.display(" [Generator] ");
      gen2drv.put(trans);
    end
    -> ended;
  endtask
  
endclass

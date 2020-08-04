class generator;
  int testcase;
  
  transaction trans; // Not really need to declare it as rand
  mailbox 	  gen2drv;
  
  event ended;
  
  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  task main();
    // TODO: questionable trans = new();
    // ANSWER: new() in repeat because it will allocates 2 independent locations ~ 2 packages. If put it here, only 1 package will be sent!
    //trans = new();
    repeat(testcase) begin
      trans = new();
      if(!trans.randomize()) $fatal("GENERATOR: Cannot rand trans!");
      gen2drv.put(trans);
      $display("Gen Mailbox Num = %d", gen2drv.num());
      trans.display("[ Generation ]");
    end
    -> ended;
  endtask
    
endclass

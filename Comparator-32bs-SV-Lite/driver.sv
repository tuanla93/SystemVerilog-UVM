class driver;
  int no_trans;
  
  transaction trans;
  virtual intf vif;
  mailbox gen2drv;
  
  function new(virtual intf vif, mailbox gen2drv);
    this.vif   	 = vif;
    this.gen2drv = gen2drv;
  endfunction
  
  // This task does not generate reset but it generates initial input stimulus for reset.
  // In other words, it generates reset data input
  task reset();
    wait(!vif.resetn);
    $display("Resetn Started!");
    vif.sign <= 1'b0;
    vif.op1  <= 32'b0;
    vif.op2  <= 32'b0;
    wait(vif.resetn);
    $display("Reset Ended!");
  endtask
  
  // This task get() data put() from generators (through mailbox) and drives the input's stimulus
  task main();
    forever begin
      //transaction trans;
      gen2drv.get(trans);
      $display("Drv Mailbox Num = %d", gen2drv.num());
      
      @(posedge vif.clk);
      #1
      vif.sign <= trans.sign;
      vif.op1  <= trans.op1;
      vif.op2  <= trans.op2;
      trans.eq  <= vif.eq;
      trans.neq <= vif.neq;
      trans.grt <= vif.grt;
      trans.lss <= vif.lss;
      
      trans.display("[ Driver ]");

      no_trans++;
    end
  endtask
  
endclass

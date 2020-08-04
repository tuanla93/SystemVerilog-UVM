class driver;
  
  // Number of test should be generated
  int no_trans;
  
  mailbox gen2drv;
  virtual intf vif;
  
  function new(mailbox gen2drv, virtual intf vif);
    this.gen2drv = gen2drv;
    this.vif = vif;
  endfunction
  
  task reset;
    wait(!vif.resetn);
    $display("Reset Started!");
    vif.sign <= 1'b0;
    vif.eq   <= 1'b0;
    vif.op1  <= 32'b0;
    vif.op2  <= 32'b0;
    wait(vif.resetn);
    $display("Reset Ended!");
  endtask
  
  transaction trans;
  task main;
    forever begin
      //$display ("DRV %d", no_trans);
      gen2drv.get(trans);
      @(posedge vif.clk);
      $display("Time 1s %t", $time);
      #1
      vif.sign <= trans.sign;
      vif.op1  <= trans.op1;
      vif.op2  <= trans.op2;
      //trans.eq      <= vif.eq;
      //trans.neq     <= vif.neq;
      //trans.grt     <= vif.grt;
      //trans.lss     <= vif.lss;
      no_trans++;
      $display("Time 1e %t", $time);
    end
  endtask
endclass

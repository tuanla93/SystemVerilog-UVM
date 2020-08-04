class monitor;
  int no_trans;
  
  virtual intf vif;
  mailbox mon2scb;
  
  function new (virtual intf vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  transaction trans;
  task main;
    forever begin
      $display ("MON %d", no_trans);
      trans = new();
      
      @(posedge vif.clk)
      // Get data from previous transaction 
      //$display("Time 1s %t", $time);
      trans.sign <= vif.sign;
      trans.op1  <= vif.op1;
      trans.op2  <= vif.op2;
      //$display("Time 1e %t", $time);
      // Get result of previous data
      // At #1, data is forwared to input and also pump out. So That #2 will make sure that output data is stable
      #2
      //$display("Time 2s %t", $time);
      trans.eq   <= vif.eq;
      trans.neq  <= vif.neq;
      trans.grt  <= vif.grt;
      trans.lss  <= vif.lss;
      //$display("Time 2e %t", $time);
      #1
      //trans.display(" [Monitor] ");
      mon2scb.put(trans);
      no_trans++;
    end
  endtask
  
endclass

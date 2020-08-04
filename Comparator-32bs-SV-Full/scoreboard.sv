import "DPI-C" function int comp_32bs_cmodel(int sign, int arg_op1, int arg_op2);

class scoreboard;
  int cmodel_result;
  
  int no_trans;
  mailbox mon2scb;
  
  function new (mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  // This one is for use without Cmodel
  //transaction trans;
  //task main;
  //  bit eq  = 1'b0;
  //  bit neq = 1'b0;
  //  bit lss = 1'b0;
  //  bit grt = 1'b0;
  //  
  //  
  //  forever begin
  //    $display ("SCB %d", no_trans);
  //    mon2scb.get(trans);
  //    trans.display(" [Score board] ");
  //    
  //    if (trans.op1 == trans.op2)		eq = 1'b1;
  //    else eq = 1'b0;
  //    neq = ~eq;
  //    
  //    if ((trans.op1 > trans.op2)) grt = 1'b1;
  //    else grt = 1'b0;
  //    
  //    if ((trans.op1 < trans.op2)) lss = 1'b1;
  //    else lss = 1'b0;
  //    
  //    
  //    if (trans.eq != eq) $error("Expected Eq = %d; Actual Eq = %d", eq, trans.eq);
  //    else if (trans.neq != neq) $error("Expected Neq = %d; Actual Neq = %d", neq, trans.neq);
  //    else if (trans.grt != grt) $error("Expected Grt = %d; Actual Grt = %d", grt, trans.grt);
  //    else if (trans.lss != lss) $error("Expected Lss = %d; Actual Lss = %d", lss, trans.lss);
  //    else $display ("Scoreboard: All 4 outputs are GOOD!");
  //    
  //    no_trans++;
  //  end
  //endtask
  
  // This one is for checking with cmodel
  transaction trans;
  task main;
    bit eq  = 1'b0;
    bit neq = 1'b0;
    bit lss = 1'b0;
    bit grt = 1'b0;
    
    forever begin
      $display ("SCB %d", no_trans);
      mon2scb.get(trans);
      trans.display(" [Score board] ");
      
      // Cmodel execution
      cmodel_result = comp_32bs_cmodel(trans.sign, trans.op1, trans.op2);
      eq  = (cmodel_result >> 3) & 1'b1;
      neq = (cmodel_result >> 2) & 1'b1;
      grt = (cmodel_result >> 1) & 1'b1;
      lss = (cmodel_result >> 0) & 1'b1;
      
      // Cmodel comparison
      if      (trans.eq  != eq)  $error("FAIL: Equal: rtl = %d ; cmodel = %d", trans.eq, eq);
      else if (trans.neq != neq) $error("FAIL: Not Equal: rtl = %d ; cmodel = %d", trans.neq, neq);
      else if (trans.grt != grt) $error("FAIL: Greater: rtl = %d ; cmodel = %d", trans.grt, grt);
      else if (trans.lss != lss) $error("FAIL: //Less: rtl = %d ; cmodel = %d", trans.lss, lss);
      else $display("PASS! RTL == CMODEL");
      
      no_trans++;
      
    end
  endtask
  
  
endclass

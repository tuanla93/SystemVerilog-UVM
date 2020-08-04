module checker_mod(intf i_intf, input less, input equal);
//module checker_mod(intf i_intf);
  
 // Assertion Sequence
  sequence rst_seq_eq;
    (i_intf.eq == 1'b0);
  endsequence
  sequence rst_seq_neq;
    (i_intf.neq == 1'b0);
  endsequence
  sequence rst_seq_grt;
    (i_intf.grt == 1'b0);
  endsequence
  sequence rst_seq_lss;
    (i_intf.lss == 1'b0);
  endsequence  
  
  // Sequences should not be nested in one property...
  property rst_prop_eq;
    //@(posedge i_intf.clk) (i_intf.resetn == 1'b0) |=> rst_seq_eq |-> rst_seq_neq |-> rst_seq_grt |-> rst_seq_lss;
    @(posedge i_intf.clk) (i_intf.resetn == 1'b0) |=> rst_seq_eq;
    //@(posedge i_intf.clk) rst_seq_eq |-> rst_seq_neq;
    //@(posedge i_intf.clk) rst_seq_neq |-> rst_seq_grt;
    //@(posedge i_intf.clk) rst_seq_grt |-> rst_seq_lss;
  endproperty
  
  property rst_prop_neq;
    @(posedge i_intf.clk) (i_intf.resetn == 1'b0) |=> rst_seq_neq;
  endproperty
  property rst_prop_grt;
    @(posedge i_intf.clk) (i_intf.resetn == 1'b0) |=> rst_seq_grt;
  endproperty
  property rst_prop_lss;
    @(posedge i_intf.clk) (i_intf.resetn == 1'b0) |=> rst_seq_lss;
  endproperty
  
  sequence less_seq;
    (less == 1'b1);
  endsequence
  sequence equal_seq;
    (equal == 1'b1);
  endsequence
  
  property less_prop;
    @(posedge i_intf.clk) less_seq;
  endproperty
  property equal_prop;
    @(posedge i_intf.clk) equal_seq;
  endproperty
  
  assert_less: assert property(less_prop) $info("ASSERTION LESS PASSED"); else $info("ASSERTION LESS FAILED!");
    assert_equal: assert property(equal_prop) $info("ASSERTION EQUAL PASSED"); else $info("ASSERTION EQUAL FAILED!");
  
  //calling assert property
  assert_rst_eq: assert property(rst_prop_eq) $info("ASSERTION EQ PASSED"); else $info("ASSERTION EQ FAILED!");
    assert_rst_neq: assert property(rst_prop_neq) $info("ASSERTION NEQ PASSED"); else $info("ASSERTION NEQ FAILED!");
      assert_rst_grt: assert property(rst_prop_grt) $info("ASSERTION GRT PASSED"); else $info("ASSERTION GRT FAILED!");
        assert_rst_lss: assert property(rst_prop_lss) $info("ASSERTION LSS PASSED"); else $info("ASSERTION LSS FAILED!");
  
endmodule

// Code your design here
module comp_32bs(
    input clk,
    input resetn,
    input sign,     // Signed: 1'b1
    input [31:0] op1,
    input [31:0] op2,
    output reg eq,
    output reg neq,
    output reg grt,
    output reg lss
    );    
    wire signed [32:0] op1_signed;
    wire signed [32:0] op2_signed;
    
    assign op1_signed = sign ? {op1[31],op1} : {1'b0,op1};
    assign op2_signed = sign ? {op2[31],op2} : {1'b0,op2};
    
    wire less;
    wire equal;
    wire greater;
    
    assign equal    = (op1==op2) ? 1'b1 : 1'b0;
    assign less     = (op1_signed < op2_signed) ? 1'b1 : 1'b0;
    
    always @(posedge clk) begin
        if (resetn == 1'b0) begin
            eq  <= #1 1'b0;
            neq <= #1 1'b0;
            grt <= #1 1'b0;
            lss <= #1 1'b0;
        end else begin
            eq  <= #1 equal;
            neq <= #1 ~equal;
            lss <= #1 less;
            grt <= #1 equal ~^ less;
        end
    end
    
endmodule

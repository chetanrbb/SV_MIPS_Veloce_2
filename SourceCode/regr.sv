`timescale 1ns / 10ps
/*
 * NAME
 *
 * regr - register of data that can be held or cleared
 *
 * DESCRIPTION
 *
 * The regr (register) module can be used to store data in the current
 * cylcle so it will be output on the next cycle.  Signals are also
 * provided to hold the data or clear it.  The hold and clear signals
 * are both synchronous with the clock.
 *
 * The first example creates a 8-bit register.  The clear and hold
 * signals are taken from elsewhere.
 *
 *   wire [7:0] data_s1;
 *   wire [7:0] data_s2;
 *
 *   regr #(.N(8)) r1(.clk(clk), .clear(clear), .hold(hold),
 *                      .in(data_s1), .out(data_s2))
 *
 * Multiple signals can be grouped together using array notation.
 *
 *   regr #(.N(8)) r1(.clk(clk), .clear(clear), .hold(hold),
 *                      .in({x1, x2}), .out({y1, y2}))
 */

`ifndef _regr
`define _regr

module regr #(parameter N = 1)
(
	input logic  clk,
	input logic  clear,
	input logic  hold,
	input logic  [N-1:0] in,
	output logic [N-1:0] out);	

	
	always_ff @(posedge clk) 
	begin
		if (clear)				// clear the array 
			out <= {N{1'b0}};
		else if (hold)			// store the data for one clock cycle 
			out <= out;
		else	
			out <= in;			// read the data in the memory 
	end
endmodule

`endif

module Queue_21_5stage (
	clock,
	reset,
	io_enq_ready,
	io_enq_valid,
	io_enq_bits_data,
	io_deq_ready,
	io_deq_valid,
	io_deq_bits_data
);
	// Trace: core/Queue_21_5stage.v:2:3
	input clock;
	// Trace: core/Queue_21_5stage.v:3:3
	input reset;
	// Trace: core/Queue_21_5stage.v:4:3
	output wire io_enq_ready;
	// Trace: core/Queue_21_5stage.v:5:3
	input io_enq_valid;
	// Trace: core/Queue_21_5stage.v:6:3
	input [31:0] io_enq_bits_data;
	// Trace: core/Queue_21_5stage.v:7:3
	input io_deq_ready;
	// Trace: core/Queue_21_5stage.v:8:3
	output wire io_deq_valid;
	// Trace: core/Queue_21_5stage.v:9:3
	output wire [31:0] io_deq_bits_data;
	// Trace: core/Queue_21_5stage.v:17:3
	reg [31:0] ram_data [0:0];
	// Trace: core/Queue_21_5stage.v:18:3
	wire ram_data_io_deq_bits_MPORT_en;
	// Trace: core/Queue_21_5stage.v:19:3
	wire ram_data_io_deq_bits_MPORT_addr;
	// Trace: core/Queue_21_5stage.v:20:3
	wire [31:0] ram_data_io_deq_bits_MPORT_data;
	// Trace: core/Queue_21_5stage.v:21:3
	wire [31:0] ram_data_MPORT_data;
	// Trace: core/Queue_21_5stage.v:22:3
	wire ram_data_MPORT_addr;
	// Trace: core/Queue_21_5stage.v:23:3
	wire ram_data_MPORT_mask;
	// Trace: core/Queue_21_5stage.v:24:3
	wire ram_data_MPORT_en;
	// Trace: core/Queue_21_5stage.v:25:3
	reg maybe_full;
	// Trace: core/Queue_21_5stage.v:26:3
	wire empty = ~maybe_full;
	// Trace: core/Queue_21_5stage.v:27:3
	wire _do_enq_T = io_enq_ready & io_enq_valid;
	// Trace: core/Queue_21_5stage.v:28:3
	wire _do_deq_T = io_deq_ready & io_deq_valid;
	// Trace: core/Queue_21_5stage.v:29:3
	wire _GEN_9 = (io_deq_ready ? 1'h0 : _do_enq_T);
	// Trace: core/Queue_21_5stage.v:30:3
	wire do_enq = (empty ? _GEN_9 : _do_enq_T);
	// Trace: core/Queue_21_5stage.v:31:3
	wire do_deq = (empty ? 1'h0 : _do_deq_T);
	// Trace: core/Queue_21_5stage.v:32:3
	assign ram_data_io_deq_bits_MPORT_en = 1'h1;
	// Trace: core/Queue_21_5stage.v:33:3
	assign ram_data_io_deq_bits_MPORT_addr = 1'h0;
	// Trace: core/Queue_21_5stage.v:34:3
	assign ram_data_io_deq_bits_MPORT_data = ram_data[ram_data_io_deq_bits_MPORT_addr];
	// Trace: core/Queue_21_5stage.v:35:3
	assign ram_data_MPORT_data = io_enq_bits_data;
	// Trace: core/Queue_21_5stage.v:36:3
	assign ram_data_MPORT_addr = 1'h0;
	// Trace: core/Queue_21_5stage.v:37:3
	assign ram_data_MPORT_mask = 1'h1;
	// Trace: core/Queue_21_5stage.v:38:3
	assign ram_data_MPORT_en = (empty ? _GEN_9 : _do_enq_T);
	// Trace: core/Queue_21_5stage.v:39:3
	assign io_enq_ready = ~maybe_full;
	// Trace: core/Queue_21_5stage.v:40:3
	assign io_deq_valid = io_enq_valid | ~empty;
	// Trace: core/Queue_21_5stage.v:41:3
	assign io_deq_bits_data = (empty ? io_enq_bits_data : ram_data_io_deq_bits_MPORT_data);
	// Trace: core/Queue_21_5stage.v:42:3
	always @(posedge clock) begin
		// Trace: core/Queue_21_5stage.v:43:5
		if (ram_data_MPORT_en & ram_data_MPORT_mask)
			// Trace: core/Queue_21_5stage.v:44:7
			ram_data[ram_data_MPORT_addr] <= ram_data_MPORT_data;
		if (reset)
			// Trace: core/Queue_21_5stage.v:47:7
			maybe_full <= 1'h0;
		else if (do_enq != do_deq) begin
			begin
				// Trace: core/Queue_21_5stage.v:49:7
				if (empty) begin
					begin
						// Trace: core/Queue_21_5stage.v:50:9
						if (io_deq_ready)
							// Trace: core/Queue_21_5stage.v:51:11
							maybe_full <= 1'h0;
						else
							// Trace: core/Queue_21_5stage.v:53:11
							maybe_full <= _do_enq_T;
					end
				end
				else
					// Trace: core/Queue_21_5stage.v:56:9
					maybe_full <= _do_enq_T;
			end
		end
	end
endmodule

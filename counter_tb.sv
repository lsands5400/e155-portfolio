// Lindsey Sands
// lsands@g.hmc.edu
// 9/7/2026
// This is the testbench for the counter module.
`timescale 1 ns/1 ns

module counter_tb();
    logic           clk;    // system clock
    logic           reset;  // active high reset
    logic           en;     // enable
    logic           led;    // output LED
    logic [24:0]    counter; // counter
    logic           max;    // max count

    counterLED dut(
        .reset(reset),
        .en(en),
        .led(led)
    );

    // generate clock
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    // apply stimuli and check outputs
    initial begin

        // verify reset (Reset is active low)
        reset = 0;
        #22 reset = 1;            
        en = 1;
        #100;                        // wait required time
        assert (counter != 0)       // check outputs
        else 
            $error("Reset test 1 failed.");
		reset = 0;			
		assert (counter == 0)       // check outputs
        else 
            $error("Reset test 2 failed.");
            
        // verify enable
        reset = 0;
        #22 reset = 1;              
        en = 1;
        #50;
        assert (counter == 0)
        else 
            $error("Enable test 1 failed.");
		en = 0;
		#10;
		assert (counter != 0)
        else 
            $error("Enable test 1 failed."); 
        
        // verify max count
        reset = 0;
        #22 reset = 1;          
        en = 1;
        #10;
        assert (counter == 0)
        else 
            $error("Max count test 1 failed."); 
        en = 0;
        #10;
        assert (counter > 0)
        else 
            $error("Max count test 2 failed."); 
      
        #100 $stop;
    end
endmodule
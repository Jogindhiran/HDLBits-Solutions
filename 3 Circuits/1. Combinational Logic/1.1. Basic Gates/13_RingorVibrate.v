module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    //ringer or motor should turn on only when phone gets a call (ring = 1)
    assign ringer = ring & ~vibrate_mode;
    assign motor =  ring & vibrate_mode;
endmodule

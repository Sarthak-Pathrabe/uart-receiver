#!/bin/bash

# Step 1: Clean previous build
rm -rf obj_dir

# Step 2: Compile RTL and Testbench using Verilator
echo "Compiling UART Receiver..."

verilator --binary \
    -j 0 \
    -Wall \
    --Wno-fatal \
    --top-module uart_receiver_tb \
    --timing \
    --trace \
    uart_receiver.v \
    uart_receiver_tb.v

if [ $? -ne 0 ]; then
    echo "Error: Verilator compilation failed"
    exit 1
fi

# Step 3: Run simulation
echo "Running simulation..."

./obj_dir/Vuart_receiver_tb

if [ $? -ne 0 ]; then
    echo "Error: Simulation failed"
    exit 1
fi

# Step 4: Open waveform
echo "Simulation completed successfully."

if [ -f uart_receiver_tb.vcd ]; then
    gtkwave uart_receiver_tb.vcd
else
    echo "Warning: uart_receiver_tb.vcd not found"
fi
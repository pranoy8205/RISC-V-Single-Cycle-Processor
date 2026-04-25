# 32-bit Single Cycle RISC-V Processor in Verilog

A hardware implementation of a 32-bit Single Cycle RISC-V Processor designed using Verilog HDL. The processor executes basic RISC-V instructions in a single clock cycle and was verified through simulation.

## Overview

This project demonstrates the design and simulation of a RISC-V CPU datapath and control unit. It includes instruction fetch, decode, execute, memory access, and write-back stages combined in a single-cycle architecture.

## Features

* 32-bit RISC-V architecture
* Single-cycle processor design
* Arithmetic and logical operations
* Register file implementation
* ALU control logic
* Immediate generation unit
* Program Counter (PC)
* Instruction memory support
* Data memory support
* Verified through waveform simulation

## Modules Included

* Program Counter
* Instruction Memory
* Register File
* ALU
* Control Unit
* Immediate Generator
* Data Memory
* Top Module
* Testbench

## Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave

## Folder Structure

* .v/ → Design source and testbench files
* .mem/ → Memory initialization files
* .vcd/ → Simulation outputs

## How to Run

1. Compile all Verilog files
2. Update the program.mem file with the hexcode of your instructions
3. Run simulation using Icarus Verilog
4. Open waveform using GTKWave

## Results

The processor successfully executed supported instructions and generated correct simulation waveforms.

## Author

Pranoyjit Bose
B.Tech Electronics Engineering
Specialization: VLSI Design and Technology

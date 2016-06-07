MIPS Pipeline
=============

An implementation of the MIPS Pipeline in verilog, meant to be synthesized
and implemented using Xilinx Vivado on a zynq-7000 clg400 FPGA.

Dependencies
------------
PIPELINE.v is the top level module for this project.

You must ensure that you have imem.bin and dmem.hex
set up as Memory Initialization Files, otherwise
the memory will not be properly initialized.
These files may be filled with whatever values you wish
to initialize memory with.

Features
--------
* Basic implementation of MIPS pipeline
  * _Does not remediate control, structural, or data hazards!_
* Written so that it may be directly synthesized on a FPGA

![](http://i.imgur.com/mQzCauG.png "Block diagram of synthesized design")
![](http://i.imgur.com/yxjWQet.png "Photograph of implemented design with power summary")
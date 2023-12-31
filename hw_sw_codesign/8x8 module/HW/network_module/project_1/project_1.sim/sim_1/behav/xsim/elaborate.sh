#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Mon Sep 25 19:49:52 KST 2023
# SW Build 3118627 on Tue Feb  9 05:13:49 MST 2021
#
# Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto a3603050ac404a57b07649a86ceb419a --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_network_behav xil_defaultlib.tb_network xil_defaultlib.glbl -log elaborate.log"
xelab -wto a3603050ac404a57b07649a86ceb419a --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_network_behav xil_defaultlib.tb_network xil_defaultlib.glbl -log elaborate.log


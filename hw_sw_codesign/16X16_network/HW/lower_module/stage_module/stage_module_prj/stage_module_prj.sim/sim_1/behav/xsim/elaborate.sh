#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Sep 26 18:02:42 KST 2023
# SW Build 3118627 on Tue Feb  9 05:13:49 MST 2021
#
# Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 825357f1edde46fab136745dcf403a15 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_stage_behav xil_defaultlib.tb_stage xil_defaultlib.glbl -log elaborate.log"
xelab -wto 825357f1edde46fab136745dcf403a15 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_stage_behav xil_defaultlib.tb_stage xil_defaultlib.glbl -log elaborate.log


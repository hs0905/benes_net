#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Wed Oct 04 20:09:33 KST 2023
# SW Build 3118627 on Tue Feb  9 05:13:49 MST 2021
#
# Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim tb_network_behav -key {Behavioral:sim_1:Functional:tb_network} -tclbatch tb_network.tcl -log simulate.log"
xsim tb_network_behav -key {Behavioral:sim_1:Functional:tb_network} -tclbatch tb_network.tcl -log simulate.log


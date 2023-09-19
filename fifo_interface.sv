import uvm_pkg::*;
`include "uvm_macros.svh"
`timescale 1ns/10ps

interface fifo_interface(input clk, rstn);
  bit i_wren;
  bit i_rden;
  bit [127:0] i_wrdata;
  bit o_full;
  bit o_empty;
  bit o_alm_full;
  bit o_alm_empty;
  bit [127:0] o_rddata;
  
  clocking dri_cb @(posedge clk);
    default input #1 output #1;
    output i_wren;
    output i_rden;
    output i_wrdata;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #1 output #1;
    input o_full;
    input o_empty;
     input o_alm_full;
  input o_alm_empty;
    input o_rddata;
    input i_wren;
    input i_rden;
    input i_wrdata;
  endclocking

  modport dri_mp (input clk, rstn, clocking dri_cb);
  
      modport mon_mp (input clk, rstn, clocking mon_cb);
    
endinterface

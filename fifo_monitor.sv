class fifo_monitor extends uvm_monitor;
  virtual fifo_interface vif;
  fifo_seq_item item_got;
  uvm_analysis_port#(fifo_seq_item) item_got_port;
  `uvm_component_utils(fifo_monitor)
  
  function new(string name = "fifo_monitor", uvm_component parent);
    super.new(name, parent);
    item_got_port = new("item_got_port", this);
  endfunction
  

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_got = fifo_seq_item::type_id::create("item_got");
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.mon_mp.clk)
      if((vif.mon_mp.mon_cb.i_wren == 1)&&(vif.mon_mp.mon_cb.i_rden == 0))
        begin
          $display("\nWrite enable is high and read enable is low");
        item_got.i_wrdata = vif.mon_mp.mon_cb.i_wrdata;
        item_got.i_wren = 'b1;
        item_got.i_rden = 'b0;
        item_got.o_full = vif.mon_mp.mon_cb.o_full;
          item_got.o_empty = vif.mon_mp.mon_cb.o_empty;
        item_got.o_alm_full = vif.mon_mp.mon_cb.o_alm_full;
           item_got.o_alm_empty = vif.mon_mp.mon_cb.o_alm_empty;
        item_got_port.write(item_got);
      end
      if((vif.mon_mp.mon_cb.i_rden == 1)&&(vif.mon_mp.mon_cb.i_wren == 0))
       begin
        
         $display("\nRead enable is high and write enable is low");
        item_got.o_rddata = vif.mon_mp.mon_cb.o_rddata;
        item_got.i_rden = 'b1;
        item_got.i_wren = 'b0;
         item_got.o_full = vif.mon_mp.mon_cb.o_full;
        item_got.o_empty = vif.mon_mp.mon_cb.o_empty;
        item_got.o_alm_full = vif.mon_mp.mon_cb.o_alm_full;
        item_got.o_alm_empty = vif.mon_mp.mon_cb.o_alm_empty;
        item_got_port.write(item_got);
      end
      if((vif.mon_mp.mon_cb.i_rden == 1)&&(vif.mon_mp.mon_cb.i_wren == 1))
       begin
      
         $display("\nRead enable and write enable is high");
          item_got.i_wrdata = vif.mon_mp.mon_cb.i_wrdata;
        item_got.o_rddata = vif.mon_mp.mon_cb.o_rddata;
        item_got.i_rden = 'b1;
        item_got.i_wren = 'b1;
        item_got_port.write(item_got);
      end
      if((vif.mon_mp.mon_cb.i_rden == 0)&&(vif.mon_mp.mon_cb.i_wren == 0))
       begin
         $display("\nRead enable and write enable is low");
        item_got.i_rden = 'b0;
        item_got.i_wren = 'b0;
        item_got_port.write(item_got);
      end
    end
  endtask
endclass

    

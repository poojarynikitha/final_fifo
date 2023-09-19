class fifo_sequence extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_sequence)
  
  function new(string name = "fifo_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Write REQs ********"), UVM_LOW)
    repeat(1024) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_wren == 1 ; i_rden==0;});
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Read REQs ********"), UVM_LOW)
    repeat(1024) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden == 1 ; i_wren==0;});
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 25 Random REQs ********"), UVM_LOW)
    repeat(25) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Read,Write REQs ********"), UVM_LOW)
    repeat(1024) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_wren == 1 ; i_rden==1;});
      finish_item(req);
    end
     `uvm_info(get_type_name(), $sformatf("******** Generate no Read,Write REQs ********"), UVM_LOW)
    repeat(1024) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden == 0 ; i_wren==0;});
      finish_item(req);
    end
     `uvm_info(get_type_name(), $sformatf("******** Generate 10 Alternative Read & Write REQs ********"), UVM_LOW)
    repeat(1024) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden == 0 ; i_wren==1;});
      finish_item(req);
       req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden == 1 ; i_wren==0;});
      finish_item(req);
    end
  endtask
  
endclass
  
  

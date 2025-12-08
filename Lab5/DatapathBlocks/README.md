All blocks are made in accordance to the new DRC rules using the "tapeout_SCN6M_DEEP.09.tech27" file
## Building Blocks
Basic circuits which are used throughout the following designs
- inv.mag: An inverter
- NAND2.mag: A two input Nand gate
- XOR2.mag: A two input Xor gate. Uses NAND2.mag. Has two inputs "a" and "b" and produces an output "o"
## DWT Function Blocks
### Arithmetic
Circuits used in the computation of the DWT
- Add2.mag: a 1-bit add and sub unit. Made from NAND2.mag and XOR.mag
- add_sub8.mag: an 8-bit add and subtract unit. Uses Add2.mag
- add_sub16.mag: a 16 bit add and subtract unit. Uses add_sub8.mag.
- addDiv.mag: a 16 bit add and subtract unit with a shift down by 2 function at the output. Uses add_sub16.mag

### Latches
- Latch.mag: a 1 bit latch 
- latch16.mag: a 16-bit latch

### Register
- trans.mag: A transmission gate
- stat.mag: A statusizer. Has an input and 2 control signals that allow you to set the state of the input. The control signals must be compliments of eachother and are labelled "w" and "not_w". 
- reg.mag: A basic 1 bit register. Uses inv.mag, trans.mag, stat.mag. 
- reg1.mag: A 1-bit register that is pitch matched to the add sub unit. 


### 12/8 Update: 
- datapath.mag: The full datapath with all connections. Contains inputs in0...in15, set_in, set_0, store_out, read_out w_x0, r_x0. 
The datapath uses m3 as connections between blocks, m4 as GND and m5 as Vdd. 
- datapath.irsim: The test script for the datapath, contains the DWT algorithm as encoded by the state machine
- NOR2: A added gate used in the datapath design 
- OR2: A gate used in datapath made from NOR2 and inv. It is primarily used in the control signal for latch staticizers
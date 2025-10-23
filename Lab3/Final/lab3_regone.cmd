# IRSIM test file for 1-bit register
# ~~~~~~~~~~~~~~~~~~~~~~~~

# Load sim file
reg_one.sim

# Define logic vectors
vector in in
vector w w
vector r r
vector out out

# Visualize as waveforms
ana in w r out

# Set time scale
stepsize 50ns

# Initialize signals
h Vdd
l GND
l w
l r
l in

# Test sequence
# ~~~~~~~~~~~~~~~~~~~~~~~~

# Test case 1: Write = 1, Read disabled (store input value = 1)
# read = FALSE
l r               
# write = TRUE
h w  
# input = 1            
h in
# sim for 5 ts              
s 5 
# expected X              
w out	         

# write = FALSE
l w
# input = 0; tests whether w control signal disables overwriting of data               
l in 
# sim for 5 ts             
s 5
# expected X              
w out          

# Test case 2: Read enabled, see if output held, and then disabled
# read = TRUE
h r
# sim 5 ts	       
s 5
# expected 1	       
w out         

# read =  FALSE
l r
# sim 5 ts 	       
s 5
# expected X	       
w out         

# Test case 3: Write in 0, reading disabled and then enabled; input changes while write is disabled and then enabled
# write = TRUE 
h w
# input = 0	       
l in
# sim 5 ts	       
s 5
# expected X	       
w out	       

# write = FALSE
l w
# read = TRUE	       
h r
# input = 1	       
h in	
# sim 5 ts       
s 5
# expected 0	       
w out	       

# Test case 4: check hold
# whether stored value changes even when w and r = 0
l r 
h w
# write in 1
h in 	       
s 5
# expected X
w out	       

# write = FALSE
l w	
# sim 10 ts       
s 10 	       

# read = TRUE
h r 
# expected 1	       
w out	       

# End test
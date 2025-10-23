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
l r                 # read = FALSE
h w              # write = TRUE
h in              # input = 1
s 5               # sim for 5 ts
w out	         # expected X

l w               # write = FALSE
l in              # input = 0; tests whether w control signal disables overwriting of data
s 5              # sim for 5 ts
w out          # expected X

# Test case 2: Read enabled, see if output held, and then disabled
h r	       # read = TRUE
s 5	       # sim 5 ts
w out         # expected 1

l r 	       # read =  FALSE
s 5	       # sim 5 ts
w out         # expected X

# Test case 3: Write in 0, reading disabled and then enabled; input changes while write is disabled and then enabled
h w	       # write = TRUE 
l in	       # input = 0
s 5	       # sim 5 ts
w out	       # expected X

l w	       # write = FALSE
h r	       # read = TRUE
h in	       # input = 1
s 5	       # sim 5 ts
w out	       # expected 0

# Test case 4: check hold
# whether stored value changes even when w and r = 0
l r 
h w
h in 	       # write in 1
s 5
w out	       # expected X

l w	       # write = FALSE
s 10 	       # sim 10 ts

h r 	       # read = TRUE
w out	       # expected 1

# End test
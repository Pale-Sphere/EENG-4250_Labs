# IRSIM test file for a datapath
# ~~~~~~~~~~~~~~~~~~~~~~~~

# Load sim file
datapath.sim

# initialize (if not already)
# w/r (write/read or clock control for each level)
vector clk_ld 
vector clk_fb
vector clk_rfb
vector clk_os 
vector clk_ros
vector clk_as 
vector clk_ras
vector w_reg0
vector r_reg0
vector w_reg1
vector r_reg1
vector r_rd 

# Set time scale
stepsize 50ns

# Initialize signals 
h Vdd
l GND
l in
l clk_ld clk_fb clk_rfb clk_os clk_ros clk_as clk_ras 
l w_reg0 w_reg1 r_reg0 r_reg1 r_rd

# automatically prints outputs for "watched" signals
watch in ld_out fb_out rfb_out os_out ros_out as_out ras_out reg0_out reg1_out rd_out out

# Firstly...setting the output
#==============================
# Write 1 into ld
h in

# in -> ld
h clk_ld
s 2
l clk_ld
s 2

# ld -> fb latch
h clk_fb
s 2
l clk_fb
s 2

# fb -> rfb 
h clk_rfb
s 2
l clk_rfb
s 2

# rbf -> os
h clk_os
s 2
l clk_os
s 2

# os -> ros
h clk_ros
s 2
l clk_ros
s 2

# ros -> as
h clk_as
s 2
l clk_as
s 2

# as -> ras
h clk_ras
s 2
l clk_ras
s 2

# ras -> reg0
h w_reg0
s 2
l w_reg0
s 2
h r_reg0
s 2

# reg 0 -> reg1 
h w_reg1
s 2
l w_reg1
s 2

# enable read for rd latch
h r_rd
s 2
w out

# load latch
h clk_ld
s 2
l clk_ld
s 2

# fb latch
h clk_fb
s 2
l clk_fb
s 2

# rfb latch
h clk_rfb
s 2
l clk_rfb
s 2

# os latch
h clk_os
s 2
l clk_os
s 2

# ros latch
h clk_ros
s 2
l clk_ros
s 2

# as latch
h clk_as
s 2
l clk_as
s 2

# ras latch
h clk_ras
s 2
l clk_ras
s 2

# reg0 write
h w_reg0
s 2
l w_reg0
s 2
h r_reg0 
s 2

# reg1 write
h w_reg1
s 2
l w_reg1
s 2

l r_reg0 
h r_reg1

# enable read for rd latch
h r_rd
s 2
w out
l r_rd

# testing ability to hold
# ----------------------------

# input changes while latches are holding internal val
# same input as before
h in
l clk_ld clk_fb clk_rfb clk_os clk_ros clk_as clk_ras
l w_reg0 w_reg1
l r_rd
s 5
# input changes
l in
s 5
# expect output to stay constant
w out
s 2
 
h r_rd 
w out

# matching inputs to outputs
# ----------------------------
# Change input and toggle clocks one by one to see signal movement

# input = 1 again
h in

# load latch only
h clk_ld
s 2
l clk_ld
s 2
# expected 1
w ld_out

# fb latch next
h clk_fb
s 2
l clk_fb
s 2
# expected 1
w fb_out

# rfb latch
h clk_rfb
s 2
l clk_rfb
s 2
# expected 1
w rfb_out

# etc...
h clk_os
s 2
l clk_os
s 2
# expected 1
w os_out

h clk_ros
s 2
l clk_ros
s 2
# expected 1
w ros_out

h clk_as
s 2
l clk_as
s 2
# expected 1
w as_out

h clk_ras
s 2
l clk_ras
s 2
# expected 1
w ras_out

# finally, move into reg0 -> reg1 -> rd
h w_reg0
s 2
l w_reg0
s 2
h r_reg0

h w_reg1
s 2
l w_reg1
s 2

l r_reg0
h r_reg1

# reg1 -> rd
h r_rd
s 2
w out
l r_rd


# IRSIM test file for a datapath
# ~~~~~~~~~~~~~~~~~~~~~~~~

# Load sim file
datapath.sim

# initialize (if not already)
# w/r (write/read control for each level)
vector w_ld w_ld
vector r_ld r_ld
vector w_fb w_fb
vector r_fb r_fb
vector w_rfb w_rfb
vector r_rfb r_rfb
vector w_os w_os
vector r_os r_os
vector w_ros w_ros
vector r_ros r_ros
vector w_as w_as
vector r_as r_as
vector w_ras w_ras
vector r_ras r_ras
vector w_reg0 w_reg0
vector r_reg0 r_reg0
vector w_reg1 w_reg1
vector r_reg1 r_reg1
vector r_rd r_rd

# Set time scale
stepsize 50ns

# Initialize signals 
h Vdd
l GND
l in
l w_ld w_fb w_rfb w_os w_ros w_as w_ras w_reg0 w_reg1
l r_ld r_fb r_rfb r_os r_ros r_as r_ras r_reg0 r_reg1 r_rd

# automatically prints outputs for "watched" signals
watch in ld_out fb_out rfb_out os_out ros_out as_out ras_out reg0_out reg1_out rd_out out

# Write 1 into ld
h in
# Read = FALSE
l r_ld
# Write = TRUE 
h w_ld
# sim 5 ts   
s 5
l w_ld   
s 2

# Transfer ld to fd
# read = FALSE
l r_fb
# wrote = TRUE
h w_fb
# fb input connected automatically to ld; delay to allow value change
s 5

# write = FALSE
l w_fb
s 2

# Transfer fb-> rfb
# read = FALSE 
l r_rfb
# write = TRUE 
h w_rfb
s 5
# write = FALSE
l w_rfb
s 2

# Transfer rfb to os
# read = FALSE
l r_os
# write = TRUE
h w_os
# allow value to set
s 5
# write= FALSE
l w_os
s 2

# Transfer os -> ros
# read = FALSE
l r_ros
# write = TRUE
h w_ros
s 5
# write = FALSE
l w_ros
s 2

# Transfer ros -> as
# read = FALSE
l r_as
# write = TRUE
h w_as
s 5
# write = FLSE
l w_as
s 2

# Transfer as -> ras
# read = FALSE
l r_ras
# write = TRUE 
h w_ras
s 5
# write = FALSE
l w_ras
s 2

# Transfer ras -> reg0 
# read = FALSE
l r_reg0
# write = TRUE 
h w_reg0
s 5
# write = FALSE
l w_reg0
s 2

# reg0 -> reg 1
#read = FALSE
l r_reg1
# write = TRUE 
h w_reg1
s 5
# write = FALSE
l w_reg1
s 2

# read output via RD latch
# read = TRUE
h r_rd
s 5
# expected 1
w out

# hold case 1: input is changed, write = 0 
# input = 1
h in 
# set all write signals to 0              
l w_ld w_fb w_rfb w_os w_ros w_as w_ras w_reg0 w_reg1
# read output = FALSE
l r_rd 
# delay
s 5
# change input = 0
l in               
s 5
# expected 1
w out         

# hold case 2: write = 1, but read = 0 (even though write is enabled, the next gates cannot read in and store those val) 
# write = TRUE
h w_ld
# read = FALSE
l r_rd
# change input to 0 
h in
s 5
# expected X or 1
w out 
# write = FALSE
l w_ld
s 5

# hold case 3: both read and write disabled 
l w_ld w_fb w_rfb w_os w_ros w_as w_ras w_reg0 w_reg1
l r_ld r_fb r_rfb r_os r_ros r_as r_ras r_reg0 r_reg1 r_rd
# input = 1 
h in
s 10
# show output
w out  

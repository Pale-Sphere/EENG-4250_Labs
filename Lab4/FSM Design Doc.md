## Strategy:

In order to develop the FSM, each step within each process was broken down hierarchically, further and further until they could not be broken up farther 
(summary of steps can be found at the bottom of this section). Each of these steps had what control signals necesary written within them. Then each one 
of those steps were assigned a clock cycle, first by what steps needed to be on a certain cycle from the axioms within the assignment, and then arbitrarily 
through what would be both efficient and reduce "clobbering".

Then each step represented as a node then were given state assignments. Each two nodes that only had the state assignments of orthogonal clocks were then
merged, as being able to AND the c-signals with the clock phase meant that they could simply be one in the same node. 

The two input signals, iter and load, that are irrelevant are inputted into a 4 input AND gate. This allows us to enusre that iter and load only determine
the state on S = {000} without making the logic slow and large.

On Phi0 the Read ports of the state flip flops are outputted to the rest of the circuit, allowing the c-signals and next state to be calulated. Then on
Phi1 if the IDLE condition is not met, the write port of the flip flop is open and the next state is written to memory.

## Text Description

#### 000

The IDLE stage, ready is set to one, and the write signal for the state flip flops is drawn low unless an input is driven high

#### 001

The first stage of iter

On Phi0 ready is driven low, r00, u, and s is driven high to calculate <<x

On Phi1 the shift latch (Ls) is opened and w0 is enabled, allowing the datapath to write <<x to wz and and x

#### 010

The first stage of load

On phi0 g1&g2 are driven low, and both r00 and r11 are opened to calculate 0

Then on phi1 Lf and w0 is turned on to write 0 to all of wz and x

#### 011

The second stage of load

r00 is written to high, and x is written to rx then out through opening the output latch (Lo)

On phi1 Lin and w1 are turned on to write the input to wz, then written to y

#### 100

The first stage of reset

On phi0 g1&g2 are driven low, and both r00 and r11 are opened to calculate 0

On phi1 Lf, w0, and w1 are all turned on to allow everything to be written at 0

#### 101

The second stage of reset

r00 is written to high, and x is written to rx then out through opening the output latch (Lo)


#### 110

The second stage of iter

On phi0 r00 and Lo is turned on again to output x to out



#### 111

The third stage of iter

r00 is written to high, and x is written to rx then out through opening the output latch (Lo)

## FSM (Drawn)

After this whole process we were left with the following FSM:

![[FSM.png]]

Then with the diagram we were able to produce a state transistion table

### State Transition Table

![[FSM_Table.png]]

Using this table we were able to use K-maps and simiplification to find the following production rules for each state index (please note load = load&!S1&!S2&!S3 and
iter = iter&!S1&!S2&!S3):

↑S1 <- reset | load | S1&!S3 | !S1&!S2&S3
↓S1 <- !reset & ( iter | !S1&S2 | S1S3 )

↑S2 <- !reset & ( S2&!S3 | !S1&!S2&S3 )
↓S2 <- reset | !S2&!S3 | S3 & (S1 | S2)

↑S3 <- !reset & ( load | iter ) | !S3 & (S1 & (!S2 | S2)
↓S3 <- reset | S3

Then with the prod rules we tried to find the best CMOS networks for the next state:

##### S1'

![[S1.png]]

##### S2'

![[S2.png]]

##### S3'

![[S3.png]]

To best handle the IDLE Condition (ready == 1 & there's no inputs), a precharge logic circuit was used to control the write signal of the state flip flops.

![[IDLE.png]]

## Combinational Logic

The combinational logic for the control signals were almost equivalent to the state assignments, as control signals were defined by which state the 
machine existed within. This made the process fairly straightforward.

ready = !S1&!S2&&!S3

r00 = S1 | S2 | S3

r11 = !S1 & (S2 | S3)

w0 = !S1 & (S2 | S3) | !(!S1 | S2 | S3)

w1 = !(S1 | S2 | !S3) | !(!S1 | S2 | !S3) | (!S1 | !S2 | S3)
 
g1&g2 = !(S1 | !S2 | !S3)

u&s = !(!S1 | S2 | S3)

Ls = !(!S1 | S2 | S3)

Lo = !(!S1 | !S2)

Lin = !S1 & S2 & S3

g0 and g4 are shorted with ground, as they're always zero, and g1 and g2 are identical, same with u and s

## Overall Architecture

![[Arch.png]]






## Strategy:

In order to develop the FSM, each step within each process was broken down hierarchically, further and further until they could not be broken up farther 
(summary of steps can be found at the bottom of this section). Each of these steps had what control signals necesary written within them. Then each one 
of those steps were assigned a clock cycle, first by what steps needed to be on a certain cycle from the axioms within the assignment, and then arbitrarily 
through what would be both efficient and reduce "clobbering".

Then each step represented as a node then were given state assignments. Each two nodes that only had the state assignments of orthogonal clocks were then
merged, as being able to AND the c-signals with the clock phase meant that they could simply be one in the same node. 

The two input signals, iter and load, that are irrelevant are inputted into a 4 input AND gate. This allows us to enusre that iter and load only determine
the state on S = {000} without making the logic slow and large.

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

Then with the prod rules we tried to find the best CMOS networks for the next state

To best handle the IDLE Condition (ready == 1 & there's no inputs), a precharge logic circuit was used to control the write signal of the state flip flops.

![[IDLE.png]]

## Combinational Logic

The combinational logic for the control signals were almost equivalent to the state assignments, as control signals were defined by which state the 
machine existed within. This made the process fairly straightforward. For conditions where an 8-bit bus was needed to be verified to equal 0, a precharge
OR gate with an additional not gate was used in order to limit a very large use of in-series pmos transistors. 

![[Comb_Logic.png]]

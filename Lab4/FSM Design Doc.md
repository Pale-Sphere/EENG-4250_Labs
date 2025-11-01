## Strategy:

In order to develop the FSM, each step within each process was broken down hierarchically, further and further until they could not be broken up farther 
(summary of steps can be found at the bottom of this section). Each of these steps had what control signals necesary written within them. Then each one 
of those steps were assigned a clock cycle, first by what steps needed to be on a certain cycle from the axioms within the assignment, and then arbitrarily 
through what would be both efficient and reduce "clobbering".

Then each step represented as a node then were given state assignments. Each two nodes that only had the state assignments of orthogonal clocks were then
merged, as being able to AND the c-signals with the clock phase meant that they could simply be one in the same node. 

## FSM (Drawn)

After this whole process we were left with the following FSM:

![[FSM.png]]

## Combinational Logic

The combinational logic for the control signals were almost equivalent to the state assignments, as control signals were defined by which state the 
machine existed within. This made the process fairly straightforward. For conditions where an 8-bit bus was needed to be verified to equal 0, a precharge
OR gate with an additional not gate was used in order to limit a very large use of in-series pmos transistors. 

![[Comb_Logic.png]]

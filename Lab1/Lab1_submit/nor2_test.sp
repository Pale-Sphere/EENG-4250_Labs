* 
* Xyce simulation example
*
*
* Default supply nodes 
*
.global vdd *, VDD!
.global gnd *, GND!

*
* Set Vdd to 1.8V, GND to 0V
*
vpwr0 vdd 0 dc 1.8v
vpwr1 gnd 0 dc 0.0v
* vpwr2 Vdd! 0 dc 1.8v
* vpwr3 GND! 0 dc 0.0v

*
* include nfet and pfet models
*
.inc /usr/local/cad/conf/g180/models.sp

*
* include circuit model
*
.inc nor2.spice

*
* set the voltage of "in" to be a piecewise linear  (PWL)
* curve. The rest of the parameters are (time,voltage) pairs. 
*
va A 0 PWL 0n 0 10n 0 20n 1.8 30n 1.8 40n 0 50n 0
vb B 0 PWL 0n 0 10n 0 20n 0 30n 1.8 40n 1.8  50n 0

*
* Save the output in "gnuplot" friendly format
* Print out the voltages for in and out
* You can also say v(*) for all the voltages
*
.print tran file=nor2.plot format=gnuplot v(A) v(B) v(OUT)

*
* Run a transient simulation with 1ps timestep
* for 40 nanoseconds
*
.tran 1p 60n

.end


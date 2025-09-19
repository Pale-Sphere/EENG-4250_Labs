* 
* Xyce simulation example
*
*
* Default supply nodes 
*
.global vdd
.global gnd

*
* Set Vdd to 1.8V, GND to 0V
*
vpwr0 vdd 0 dc 1.8v
vpwr1 gnd 0 dc 0.0v

*
* include nfet and pfet models
*
.inc /usr/local/cad/conf/g180/models.sp

*
* include circuit model
*
.inc inv.spice

*
* set the voltage of "in" to be a piecewise linear  (PWL)
* curve. The rest of the parameters are (time,voltage) pairs. 
*
vtst in 0 PWL 0 0 1.5n 0 2n 1.8 4.5n 1.8 5n 0 8.5n 0 9n 1.8 10.5n 1.8 11n 0

*
* Save the output in "gnuplot" friendly format
* Print out the voltages for in and out
* You can also say v(*) for all the voltages
*
.print tran file=test.plot format=gnuplot v(in) v(out)

*
* Run a transient simulation with 1ps timestep
* for 25 nanoseconds
*
.tran 1p 25n

.end

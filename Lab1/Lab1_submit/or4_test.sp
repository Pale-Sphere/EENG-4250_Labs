.global Vdd
.global GND


vpwr0 vdd 0 dc 1.8v
vpwr1 gnd 0 dc 0.0v
vpwr2 VDD! 0 dc 1.8v
vpwr3 GND! 0 dc 0.0v

.inc /usr/local/cad/conf/g180/models.sp


.inc or4.spice

vA a 0 PWL 0 0 1.5n 1.8 3n 0 4.5n 0 6n 0 7.5n 0 9n 0 10.5n 0 12n 0 13.5n 0
vB b 0 PWL 0 0 1.5n 0 3n 1.8 4.5n 0 6n 0 7.5n 0 9n 0 10.5n 0 12n 0 13.5n 0
vC c 0 PWL 0 0 1.5n 0 3n 0 4.5n 1.8 6n 0 7.5n 0 9n 0 10.5n 0 12n 0 13.5n 0
vD d 0 PWL 0 0 1.5n 0 3n 0 4.5n 0 6n 1.8 7.5n 0 9n 0 10.5n 0 12n 0 13.5n 0


.print tran file=or4.plot format=gnuplot v(a) v(b) v(c) v(d) v(out4)


.tran 1p 15n

.end

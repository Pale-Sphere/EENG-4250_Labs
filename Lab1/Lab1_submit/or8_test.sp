.global Vdd
.global GND


vpwr0 vdd 0 dc 1.8v
vpwr1 gnd 0 dc 0.0v
vpwr2 Vdd! 0 dc 1.8v
vpwr3 GND! 0 dc 0.0v

.inc /usr/local/cad/conf/g180/models.sp


.inc or8.spice

vA A 0 PWL 0 0 1.5n 1.8 3n 0 4.5n 0 6n 0 7.5n 0 9n 0 10.5n 0 12n 0 13.5n 0
vB B 0 PWL 0 0 1.5n 0 3n 1.8 4.5n 0 6n 0 7.5n 0 9n 0 10.5n 0 12n 0 13.5n 0
vC C 0 PWL 0 0 1.5n 0 3n 0 4.5n 1.8 6n 0 7.5n 0 9n 0 10.5n 0 12n 0 13.5n 0
vD D 0 PWL 0 0 1.5n 0 3n 0 4.5n 0 6n 1.8 7.5n 0 9n 0 10.5n 0 12n 0 13.5n 0
vE E 0 PWL 0 0 1.5n 0 3n 0 4.5n 0 6n 0 7.5n 1.8 9n 0 10.5n 0 12n 0 13.5n 0
vF F 0 PWL 0 0 1.5n 0 3n 0 4.5n 0 6n 0 7.5n 0 9n 1.8 10.5n 0 12n 0 13.5n 0
vG G 0 PWL 0 0 1.5n 0 3n 0 4.5n 0 6n 0 7.5n 0 9n 0 10.5n 1.8 12n 0 13.5n 0
vH H 0 PWL 0 0 1.5n 0 3n 0 4.5n 0 6n 0 7.5n 0 9n 0 10.5n 0 12n 1.8 13.5n 0

.print tran file=or8.plot format=gnuplot v(A) v(B) v(C) v(D) v(E) v(F) v(G) v(H) v(out8)


.tran 1p 25n

.end

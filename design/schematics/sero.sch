v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 450 -220 560 -220 {lab=#net1}
N 800 -220 920 -220 {lab=#net2}
N 1160 -220 1260 -220 {lab=#net3}
N 1500 -220 1580 -220 {lab=#net4}
N 1820 -220 2020 -220 {lab=osc_out}
N 140 -220 210 -220 {lab=osc_out}
N 140 -220 140 70 {lab=osc_out}
N 2020 -220 2020 70 {lab=osc_out}
N 2020 -220 2140 -220 {lab=osc_out}
N 300 -390 300 -290 {lab=vdd}
N 1670 -390 1670 -290 {lab=vdd}
N 1350 -390 1670 -390 {lab=vdd}
N 1350 -390 1350 -290 {lab=vdd}
N 1240 -390 1350 -390 {lab=vdd}
N 1010 -390 1010 -290 {lab=vdd}
N 650 -390 1010 -390 {lab=vdd}
N 650 -390 650 -290 {lab=vdd}
N 300 -390 650 -390 {lab=vdd}
N 300 -150 300 -100 {lab=gnd}
N 1670 -150 1670 -100 {lab=gnd}
N 1350 -100 1670 -100 {lab=gnd}
N 1350 -150 1350 -100 {lab=gnd}
N 1240 -100 1350 -100 {lab=gnd}
N 1010 -150 1010 -100 {lab=gnd}
N 650 -100 1010 -100 {lab=gnd}
N 650 -150 650 -100 {lab=gnd}
N 300 -100 650 -100 {lab=gnd}
N 1010 -390 1240 -390 {lab=vdd}
N 1240 -100 1240 -40 {lab=gnd}
N 1010 -100 1240 -100 {lab=gnd}
N 1240 -610 1240 -390 {lab=vdd}
N 140 70 2020 70 {lab=osc_out}
C {opin.sym} 2140 -220 0 0 {name=p1 lab=osc_out}
C {iopin.sym} 1240 -610 3 0 {name=p2 lab=vdd}
C {iopin.sym} 1240 -40 1 0 {name=p3 lab=gnd}
C {/foss/designs/sero/design/symbol/inverter.sym} 310 -220 0 0 {name=x6}
C {/foss/designs/sero/design/symbol/inverter.sym} 660 -220 0 0 {name=x1}
C {/foss/designs/sero/design/symbol/inverter.sym} 1020 -220 0 0 {name=x2}
C {/foss/designs/sero/design/symbol/inverter.sym} 1360 -220 0 0 {name=x3}
C {/foss/designs/sero/design/symbol/inverter.sym} 1680 -220 0 0 {name=x4}

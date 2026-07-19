v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 210 -220 210 -170 {lab=vout}
N 120 -290 170 -290 {lab=vin}
N 120 -220 120 -140 {lab=vin}
N 120 -140 170 -140 {lab=vin}
N 210 -220 320 -220 {lab=vout}
N 210 -260 210 -220 {lab=vout}
N 40 -220 120 -220 {lab=vin}
N 120 -290 120 -220 {lab=vin}
N 210 -370 210 -320 {lab=vdd}
N 210 -90 210 -40 {lab=gnd}
N 210 -290 250 -290 {lab=vdd}
N 250 -320 250 -290 {lab=vdd}
N 210 -320 250 -320 {lab=vdd}
N 210 -140 250 -140 {lab=gnd}
N 250 -140 250 -90 {lab=gnd}
N 210 -90 250 -90 {lab=gnd}
N 210 -110 210 -90 {lab=gnd}
C {sg13g2_pr/sg13_lv_nmos.sym} 190 -140 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 190 -290 0 0 {name=M1
l=0.13u
w=0.25u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 210 -370 3 0 {name=p1 lab=vdd}
C {iopin.sym} 210 -40 1 0 {name=p2 lab=gnd}
C {ipin.sym} 40 -220 0 0 {name=p3 lab=vin}
C {opin.sym} 320 -220 0 0 {name=p4 lab=vout}

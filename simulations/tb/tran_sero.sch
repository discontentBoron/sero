v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 0 0 800 400 {flags=graph
y1=-0.11
y2=1.4
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x2=4.2320543e-09
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
node=osc_out
color=4
dataset=-1
unitx=1
logx=0
logy=0
x1=3.1583125e-09
}
N 180 -290 180 -260 {lab=VDD}
N 180 -100 180 -70 {lab=0}
N 260 -180 320 -180 {lab=osc_out}
N 40 -270 40 -220 {lab=VDD}
N 40 -160 40 -90 {lab=0}
C {/foss/designs/sero/design/symbol/sero.sym} 180 -180 0 0 {name=x1
schematic=../schematic/sero.sch
}
C {vdd.sym} 180 -290 0 0 {name=l1 lab=VDD}
C {gnd.sym} 180 -70 0 0 {name=l2 lab=0}
C {opin.sym} 320 -180 0 0 {name=p1 lab=osc_out}
C {vsource.sym} 40 -190 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 40 -90 0 0 {name=l3 lab=0}
C {vdd.sym} 40 -270 0 0 {name=l4 lab=VDD}
C {devices/code_shown.sym} -420 30 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
"}
C {launcher.sym} -360 100 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults
puts $sim(spice,1,cmd) 

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,1,cmd) \{ngspice  \\"$N\\" -a\}

# change the simulator to be used (Xyce)
set sim(spice,default) 0

# Create FET and BIP .save file
file mkdir $netlist_dir
write_data [save_params] $netlist_dir/[file rootname [file tail [xschem get current_name]]].save

# run netlist and simulation
xschem netlist
simulate
"}
C {devices/launcher.sym} -360 160 0 0 {name=h3
descr="Load waves" 
tclcommand="
 xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran
xschem setprop rect 2 0 fullxzoom
"
}
C {code.sym} -430 -130 0 0 {name=Transient only_toplevel=true 
value="
.param length=150n
.param temp=27
.control
  save all 
  tran 2p 10n
  
  meas tran t1 when v(osc_out)=0.6 rise=3
  meas tran t2 when v(osc_out)=0.6 rise=4
  let freq = 1 / (t2 - t1)
  
  echo \\"========================================================================\\"
  echo \\"                SINGLE RUN TRANSIENT PERFORMANCE METRICS                \\"
  echo \\"========================================================================\\"
  print freq
  echo \\"========================================================================\\"
  
  write tran_sero.raw
.endc
"}

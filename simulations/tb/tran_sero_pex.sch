v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 230 -520 1030 -120 {flags=graph
y1=-0.057
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=3.8494046e-09
x2=5.2098555e-09
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/tran_sero_pex.raw
color=6
node=osc_out
hilight_wave=0}
N 270 -790 270 -740 {lab=VDD}
N 270 -680 270 -610 {lab=0}
N 410 -810 410 -780 {lab=VDD}
N 490 -700 550 -700 {lab=osc_out}
N 410 -620 410 -590 {lab=0}
C {vdd.sym} 410 -810 0 0 {name=l1 lab=VDD}
C {gnd.sym} 410 -590 0 0 {name=l2 lab=0}
C {opin.sym} 550 -700 0 0 {name=p1 lab=osc_out}
C {vsource.sym} 270 -710 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 270 -610 0 0 {name=l3 lab=0}
C {vdd.sym} 270 -790 0 0 {name=l4 lab=VDD}
C {devices/code_shown.sym} 750 -670 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_ss
"}
C {launcher.sym} 810 -600 0 0 {name=h4
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
C {devices/launcher.sym} 810 -540 0 0 {name=h3
descr="Load waves" 
tclcommand="
 xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran
xschem setprop rect 2 0 fullxzoom
"
}
C {code.sym} 860 -860 0 0 {name=Transient only_toplevel=true 
value="
.param temp=27
.control
  save all 
  tran 2p 15n
  
  display
  
  meas tran t1 when v(osc_out)=0.6 rise=3
  meas tran t2 when v(osc_out)=0.6 rise=4
  let freq = 1 / (t2 - t1)
  
  echo \\"========================================================================\\"
  echo \\"                SINGLE RUN TRANSIENT PERFORMANCE METRICS                \\"
  echo \\"========================================================================\\"
  print freq
  echo \\"========================================================================\\"
  
  write tran_sero_pex.raw
.endc
"}
C {/foss/designs/sero/design/symbol/sero.sym} 410 -700 0 0 {name=x1
schematic=sero_pex
spice_sym_def=".include /foss/designs/sero/simulations/pex/sero_lyt.pex.spice"}

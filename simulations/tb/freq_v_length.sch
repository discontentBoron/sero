v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 150 -410 950 -10 {flags=graph
y1=1.1e+09
y2=6.1e+09
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.3e-07
x2=4e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
node=freqs
color=4
dataset=-1
unitx=1
logx=0
logy=0
sweep=lengths
rawfile=$netlist_dir/freq_v_length.raw}
N 680 -780 680 -750 {lab=VDD}
N 680 -590 680 -560 {lab=0}
N 760 -670 820 -670 {lab=osc_out}
N 520 -750 520 -690 {lab=VDD}
N 520 -630 520 -570 {lab=0}
C {devices/code_shown.sym} 140 -490 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_ss
"}
C {launcher.sym} 200 -620 0 0 {name=h4
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
C {devices/launcher.sym} 200 -560 0 0 {name=h3
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw
xschem setprop rect 2 0 fullxzoom
"
}
C {/foss/designs/sero/design/symbol/sero.sym} 680 -670 0 0 {name=x1}
C {vdd.sym} 680 -780 0 0 {name=l1 lab=VDD}
C {gnd.sym} 680 -560 0 0 {name=l2 lab=0}
C {opin.sym} 820 -670 0 0 {name=p1 lab=osc_out}
C {vsource.sym} 520 -660 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 520 -570 0 0 {name=l3 lab=0}
C {vdd.sym} 520 -750 0 0 {name=l4 lab=VDD}
C {code.sym} 130 -790 0 0 {name=LengthSweep only_toplevel=true 
value="
.param length=0.13u
.control
  save all
  let l_start = 0.13e-6
  let l_stop  = 0.40e-6
  let l_step  = 0.03e-6
  let n_pts   = 10
  let lengths = vector(n_pts)
  let freqs   = vector(n_pts)
  let idx = 0

  while idx < n_pts
    let l_curr = l_start + idx * l_step
    alterparam length = $&l_curr
    reset

    let tstop_val = 8e-9 * (l_curr / 0.13e-6)
    tran 1p $&tstop_val uic

    meas tran t1 when v(osc_out)=0.6 rise=4
    meas tran t2 when v(osc_out)=0.6 rise=5

    let freqs[idx]   = 1 / (t2 - t1)
    let lengths[idx] = l_curr

    let idx = idx + 1
  end

  set curplot = control
  write freq_v_length.raw freqs lengths
.endc
"}

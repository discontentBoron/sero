v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 470 -830 1270 -430 {flags=graph
y1=0
y2=3e+09
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.96
x2=1.44
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
sweep=vdds
rawfile=$netlist_dir/vdd_v_freq_pex.raw
hilight_wave=0}
B 2 470 -410 1270 -10 {flags=graph
y1=1.1e-05
y2=6.9e-05
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.96
x2=1.44
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
node=powers
color=5
dataset=-1
unitx=1
logx=0
logy=0
sweep=vdds
rawfile=$netlist_dir/vdd_v_freq_pex.raw}
N 200 -640 200 -610 {lab=VDD}
N 200 -450 200 -420 {lab=0}
N 280 -530 340 -530 {lab=osc_out}
N 40 -610 40 -550 {lab=VDD}
N 40 -490 40 -430 {lab=0}
C {devices/code_shown.sym} 0 -50 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_ss
"}
C {launcher.sym} 60 -180 0 0 {name=h4
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
C {devices/launcher.sym} 60 -120 0 0 {name=h3
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw
xschem setprop rect 2 0 fullxzoom
"
}
C {/foss/designs/sero/design/symbol/sero.sym} 200 -530 0 0 {name=x1
schematic=sero_pex
spice_sym_def=".include /foss/designs/sero/simulations/pex/sero_lyt.pex.spice"}
C {vdd.sym} 200 -640 0 0 {name=l1 lab=VDD}
C {gnd.sym} 200 -420 0 0 {name=l2 lab=0}
C {opin.sym} 340 -530 0 0 {name=p1 lab=osc_out}
C {vsource.sym} 40 -520 0 0 {name=V1 value=\{vdd_val\} savecurrent=false}
C {gnd.sym} 40 -430 0 0 {name=l3 lab=0}
C {vdd.sym} 40 -610 0 0 {name=l4 lab=VDD}
C {code.sym} -10 -350 0 0 {name=VDDSweep only_toplevel=true 
value="
.param vdd_val=1.2
.ic v(osc_out) 0
.control
  save all
  let v_start = 0.96
  let v_stop  = 1.44
  let v_step  = 0.06
  let n_pts   = 9
  let vdds  = vector(n_pts)
  let freqs = vector(n_pts)
  let powers = vector(n_pts)
  let idx = 0

  while idx < n_pts
    let v_curr = v_start + idx * v_step
    alterparam vdd_val = $&v_curr
    reset

    * --- Pilot run: rough period estimate ---
    tran 5p 14n
    meas tran tp1 when v(osc_out)=0.5*v_curr rise=2 td=7n
    meas tran tp2 when v(osc_out)=0.5*v_curr rise=3 td=7n
    let period_est = tp2 - tp1
    let tstop_v     = 15 * period_est + 8n
    let ifrom_v     = period_est * 8
    let ito_v       = period_est * 12

    * --- capture as plain control-level scalars BEFORE any further reset ---
    set tstop_s = $&tstop_v
    set ifrom_s = $&ifrom_v
    set ito_s   = $&ito_v

    * --- Re-run sized for settled oscillation ---
    reset
    alterparam vdd_val = $&v_curr
    reset
    tran 2p $tstop_s

    meas tran t1 when v(osc_out)=0.5*v_curr rise=9  td=5n
    meas tran t2 when v(osc_out)=0.5*v_curr rise=10 td=5n
    meas tran iavg avg i(v1) from=$ifrom_s to=$ito_s

    let freqs[idx]  = 1 / (t2 - t1)
    let powers[idx] = -iavg * v_curr
    let vdds[idx]   = v_curr
    let idx = idx + 1
  end

  set curplot = control
  write vdd_v_freq_pex.raw freqs vdds powers
.endc"}

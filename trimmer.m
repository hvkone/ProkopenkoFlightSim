%% Trimmer

%% Variables
global V_cmd;
global FPA_cmd;
global W;
global h_ft;
global r_rps;
global p_rps;
global q_rps;
global q_dps;
global theta_dot_dps;
global stab_deg;
global qdot_rpss
global stab_trim_gain;
global udot_fpss;
global wdot_fpss;
global fpa_deg;
global V;
global ub;
global wb;
global delta_t;
global V_trim_gain;
global alpha_trim_gain;
global pitch_deg;
global FPA_trim_gain;
global TLA_pos;
global TLA_trim_gain;
global udot;
global qdot_tol_rpss;


global	trim_initial	;
global	trim_default	;
global	trim_auto_test	;	

global	tc1	;		
	

%% Code
if (trim_default)
    V_cmd = 600;
    FPA_cmd = 0.0;
    W = 636636.0;
    h_ft = 40000;
end

r_rps = 0;
p_rps = 0;
q_rps = 0;
q_dps = 0;
theta_dot_dps = 0;

% trim stab to 0 pitch ace
stab_deg = stab_deg + qdot_rpss * stab_trim_gain;

% adjust wb to get alpha needed to zero  w dot
if (wb > 0.2 * V)
    wb = 0.2 * V; 
end
wb = wb + wdot_fpss * alpha_trim_gain;

% adjust ub to get desired airspeed
ub = ub + (V_cmd - V) * V_trim_gain;

% adjust pitch angle to get desired path angle
pitch_deg = pitch_deg + (FPA_cmd - fpa_deg) * FPA_trim_gain;

% adjust throttle to zero out udot
TLA_pos = TLA_pos + udot_fpss * TLA_trim_gain;
if (qdot_rpss > - qdot_tol_rpss && qdot_rpss < qdot_tol_rpss)
    tc1 = tc1 + 1;
    if (tc1 > 60)
        tc1 = 60;
    end
else
    tc1 = 0;
end
if (wdot_fpss > - 0.01 && wdot_fpss < 0.01)
    tc1 = tc1 + 1;
    if (tc1 > 60)
        tc1 = 60;
    end
else
    tc1 = 0; 
end
if (udot_fpss > -0.01 && udot_fpss < 0.01)
    tc1 = tc1 + 1;
    if (tc1 > 60)
        tc1 = 60;
    end
else
    tc1 = 0;
end

if (tc1 > 59)
    trim_auto_test = false;
    trim_initial = false;
    trim_default = false;
    tc1 = 0;
end

show = [qdot_rpss ; wdot_fpss ; udot_fpss ; tc1];
display(show);

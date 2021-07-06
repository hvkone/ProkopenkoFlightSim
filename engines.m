%% ENGINES 
%% Variables
global T_SL_MAX;	
global tsfc;	
global tau;	
global TLA_pos;
global thrust1;
global Fxb_engines;
global Fzb_engines;
%% Code
T_SL_MAX = 180000.0/4;

tsfc = 0.6;
T_SL = TLA_pos * T_SL_MAX;

thrust1_ss = T_SL *sigma* 870/V;

tau = 1.0;
tau_inv = 1/tau;
if (trim)
    thrust1 = thrust1_ss;
else
    thrust1 = thrust1_ss + (thrust1-thrust1_ss) * (1-tau_inv*delta_t);
end
thrust2 = thrust1;
thrust3 = thrust1;
thrust4 = thrust1;

thrust = thrust1 + thrust2 + thrust3 + thrust4;

fuel_flow_pph = thrust * tsfc;

Fxb_engines = thrust;
Fzb_engines = 0.0;

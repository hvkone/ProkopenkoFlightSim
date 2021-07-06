%% EQUATIONS OF MOTION
%% Variables
global Fxb_aero;
global Fzb_aero;
global Fxb_engines;
global Fzb_engines;
global W;
global sine_pitch;
global cosine_pitch;
global udot_fpss;
global wdot_fpss;
global alpha_WDP_deg;
global fpa_deg;
global V;
global ub;
global vb;
global wb;
global delta_t;
%% Code

%%BODY FORCES%%

Fxb_star = Fxb_engines + Fxb_aero;
Fzb_star = Fzb_engines + Fzb_aero;

Fxb = Fxb_star - W*sine_pitch;
Fzb = Fzb_star + W*cosine_pitch;    %%Forces including weight.

%%LOAD FACTOR%%
nz = Fzb_star / W;

%%ACCELERATIONS%%

Ax = Fxb/W;
Az = Fzb/W;

ax_fpss = Ax*g;
az_fpss = Az*g;

udot_fpss = ax_fpss + vb*r_rps - wb*q_rps;
wdot_fpss = az_fpss + ub*q_rps - vb*p_rps;

qdot_rpss = MB/Iyy;
qdot_dpss = qdot_rpss * 57.3;

%%VELOCITIES%%

if (~trim)
    ub = ub + udot_fpss * delta_t;
    wb = wb + wdot_fpss * delta_t;
end
we = -ub * sine_pitch + wb * cosine_pitch;

V = sqrt( ub^2 + wb^2);

% if(V>1000)
%     V=1000;
% elseif(V<100)
%     v = 100;
% end

q_bar_psf = 1/2 * rho * V^2;
M = V/a;
if(~trim)
    q_dps = q_dps +qdot_dpss * delta_t;
    q_rps = q_dps/57.3;
    theta_dot_dps = q_dps;
end

%%%ANGLES%%%

alpha_FRL_rad = atan2(wb, ub);
alpha_FRL_deg = alpha_FRL_rad * 57.3;

if(~trim)
    pitch_deg = pitch_deg + theta_dot_dps * delta_t;   %numeric integration: 
end
pitch_rad = pitch_deg/57.3;
sine_pitch = sin(pitch_rad);
cosine_pitch = cos(pitch_rad);

fpa_deg = pitch_deg - alpha_FRL_deg;
alpha_WDP_deg = alpha_FRL_deg + wing_incidence_deg;
alpha_WDP_rad = alpha_WDP_deg / 57.3;

sine_alpha_FRL = sin(alpha_FRL_rad);
cosine_alpha_FRL = cos(alpha_FRL_rad);

if(~trim)
    h_ft = h_ft + (-we) * delta_t;
end

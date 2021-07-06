%% AERODYNAMICS FORCES AND MOMENTS
%% Variables
global	c_bar	;
global	Cm_alpha_rad	;	
global	Cm0	;		
global	Cmq	;		% per radias						
global	CD_zero	;		
global	K	;		
global S;
%% Code

c_bar = 27.31;
S = 5500.0; % Surface area of wing
Cm_d_e_h = [0.0, 20000.0 40000.0 60000.0];
Cm_d_e = [-1.4 -1.3 -1.2 -1.2];
Cm_alpha_rad = -1.60;
Cm0 = 0.0067;
Cmq = -25.5;   %per radian

%alpha WDP breakpoints
alpha_WDP_deg_bps = [-3.02 0.0 2.4 12.4 15.0 16.0 17.0 18.0 19.0 20.0 25.];
CL_bps = [0.0 0.29 0.52 1.48 1.6 1.65 1.7 1.7 1.65 1.6 1];

CD_zero = 0.017;
K = 0.042;

%Dynamic calculations

CL = interp1(alpha_WDP_deg_bps , CL_bps , alpha_WDP_deg , 'linear' , 'extrap');

CD = CD_zero + K * CL^2;

Cm_delta_elev_rad = interp1(Cm_d_e_h , Cm_d_e , h_ft, 'linear' , 'extrap');
Cm_delta_stab_rad = Cm_delta_elev_rad * 4.0;

Cm = Cm0 + Cm_alpha_rad * alpha_WDP_rad + Cm_delta_elev_rad * elev_rad + Cm_delta_stab_rad * stab_rad + Cmq * ((q_rps * c_bar)/(2*V));

Lift = CL * q_bar_psf * S;
Drag = CD * q_bar_psf * S;

Fxb_aero = Lift * sine_alpha_FRL - Drag * cosine_alpha_FRL;
Fzb_aero = -Lift * cosine_alpha_FRL - Drag * sine_alpha_FRL;

MB = Cm * q_bar_psf * S * c_bar;



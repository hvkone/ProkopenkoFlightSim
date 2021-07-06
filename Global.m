%% Global Variables for Longitudinal Simulation
%% Static Data
global	delta_t	    ;	%delta_t	    =	0.016666667	  ;                    % 60 Hz
global	stab_deg	;	stab_deg	=	-0.25	      ;                    % degrees from -12 to +3
global	stab_rad	;	stab_rad	=	stab_deg/57.3 ;	
global	elev_deg	;	elev_deg	=	0	          ;	
global	elev_rad	;	elev_rad	=	elev_deg/57.3 ;	
global	pitch_deg	;	pitch_deg	=	0	          ;	
global	pitch_rad	;	pitch_rad	=	pitch_deg/57.3;
global	TLA_norm	;	TLA_norm	=	0.2	          ;	
global	g	        ;	g	        =	32.2	      ;	
global	throttle_on	;	throttle_on	=	0	          ;	
%% Initial Conditions
global	alpha_FRL_deg	    ;   alpha_FRL_deg	    =	0	              ;
global	FPA_cmd	            ;	FPA_cmd            	=	0	              ;
global	wing_incidence_deg	;	wing_incidence_deg	=	2.4	              ;
global	W	                ;	W	                =	636636	          ;
global	V	                ;	V	                =	871	              ;% true airspeed
global	V_cmd	            ;	V_cmd	            =	871	              ;
global	h_ft	            ;	h_ft	            =	40000	          ;
global	alpha_WDP_deg	    ;	alpha_WDP_deg	    =	2	              ;
global	alpha_WDP_rad	    ;	alpha_WDP_rad	    =	alpha_WDP_deg /57.3;
% global	q_dps	            ;	q_dps	            =	0	              ;
% global	q_rps	            ;	q_rps	            =	0	              ;
% global	r_rps	            ;	r_rps	            =	0	              ;
% global	p_rps	            ;	p_rps	            =	0	              ;
global	cosine_alpha_FRL	;	cosine_alpha_FRL    =   cos(alpha_WDP_rad);
global	sine_alpha_FRL	    ;	sine_alpha_FRL	    =   sin(alpha_WDP_rad);
global	q_bar_psf           ;	q_bar_psf	        =	(1/2)*0.000588*V^2;
global	we                  ;	we	                =	0	              ;	
global	ub                  ;	ub	                =	871	              ;% longitudinal speed of body
global	wb                  ;	wb	                =	0	              ;
global	vb                  ;	vb	                =	0	              ;
global	udot_fpss           ;	udot_fpss	        =	0	              ;% longitudinal body axis time rate of change of velocity
global	qdot_rpss           ;	qdot_rpss	        =	0	              ;
global	fuel_flow_pph       ;	fuel_flow_pph	    =	100	              ;
global	cosine_pitch        ;	cosine_pitch	    =	1	              ;
global	sine_pitch          ;	sine_pitch	        =	0                 ;
global  plot_counter        ;   plot_counter        =   0                 ;% clear the plot counter
%% Trim Variables
global	trim	        ;	trim	        =	false	;	
global	trim_initial	;	trim_initial	=	false	;	
global	trim_default	;	trim_default	=	false	;	
global	trim_auto_test	;	trim_auto_test	=	false	;	

% Trim Tolerances
global	qdot_tol_rpss	;	qdot_tol_rpss	=	0.01	;


% Trim Gains
global	stab_trim_gain	;	stab_trim_gain	=   0.5 	    ;	%.6               % 0.00
global	alpha_trim_gain	;	alpha_trim_gain	=	0.25    ;	               % -0.0
global	FPA_trim_gain	;	FPA_trim_gain	=	 .1; % 0.005 ; %.1
global	TLA_trim_gain	;	TLA_trim_gain	=	-0.005   ; % TLA_trim_gain=-0.1; -0.45; -0.15
global	V_trim_gain	    ;	V_trim_gain	    =	.1;%0.333	    ;

%% Monitor
global	monitor	;	monitor	=	1	;	
%% Phu
global	Phu_stick_ramp_rate	;	Phu_stick_ramp_rate	=	1	;              % 1 degree per second
global	Phu_stick	;	Phu_stick	=	1	;                               % absolute value of Phugoid stick input limit
global	Phu_free_response_time	;	Phu_free_response_time	=	240	;       %240.0; % 4 minutes
global	V_Phu_drop	;	V_Phu_drop	=	34	;                               % 34 fps = 20 knots
%% F Body's Engines
global	Fxb_aero	;	% Fxb_aero	=		;	
global	Fxb_engines	;	Fxb_engines	=	0	;	
global	Fzb_aero	;	% Fzb_aero	=		;	
global	Fzb_engines	;	Fzb_engines	=	0	;
%% No Name
global	a   	;	% a   	=		;                                      % Speed of sound	
global	auto_test_stick_pos	;	 auto_test_stick_pos	=	1	;	
global	auto_test    	;	 auto_test    	=	false	;                      % when true, AutoTest module is called
global	auto_plot  	;	 auto_plot  	=	false	;                              % when true, AutoPlot module is called
global	AT_case	;	 AT_case	=		1;	
global	AT_phase	;	 AT_phase	=	1	;	
global	display_menu	;	 display_menu	=	1	;	
global	no_joystick	;	no_joystick	=	0	;	
global	Az	;	% Az	=		;                                               % acceleration in z-axis
global	Cm	;	% Cm	=		;	
global	fpa_deg	;	% fpa_deg	=		;	
	

global	Lift	;	% Lift	=		;	
global	nz	;	% nz	=		;	
global	MB	;	% MB	=		;	
global	rho	;	% rho	=		;	
global	sigma	;	% sigma	=		;	
global	thrust1	;	thrust1	=	1000	;	
global	thrust1_ss	;	% thrust1_ss	=		;	
global	TLA_pos	;	TLA_pos	=	0.5;	
global	TLA_pos_rate	;	TLA_pos_rate	=	0.1	;	
global	wdot_fpss	;	% wdot_fpss	=		;	
global	tc1	;	tc1	=	0	;	
global	tc2	;	tc2	=	0	;	
%% Aero
global	c_bar	;	c_bar 	=	27.31	;	% cord
global	S	;	S 	=	5500	;	 % Surface area of wing
global	Cm_alpha_rad	;	Cm_alpha_rad	=	-1.6	;	
global	Cm0	;	Cm0	=	0.0067	;	
global	Cmq	;	Cmq	=	-25.5	;	% per radian
							
global	CD_zero	;	CD_zero	=	0.017	;	
global	K	;	K	=	0.042	;	
%% Atmos
global	dT	;	dT	=	0	;	
global	rho_SL_ISA	;	rho_SL_ISA	=	0.0023769	;	%Slug/foot^3
%% Engines
global	T_SL_MAX	;	T_SL_MAX	=	45000	;
global	tsfc	;	tsfc	=	0.6	;
global	tau	;	tau	=	1	;
%% EOM
global	Iyy	; Iyy = 33100000.0;	
%% PFC
%% STDATMO
global	R	;	R	=	287.05287	;	% N-m/kg-K; value from ESDU 77022	% R=287.0531;   %N-m/kg-K; value used by matlab aerospace toolbox ATMOSISA
global	gamma	;	gamma	=	1.4	;		
global	g0	;	g0	=	9.80665	;	% m/sec^2	
global	RE	;	RE	=	6356766	;	% Radius of the Earth, m	
global	Bs	;	Bs	=	1.46E-06	;	% N-s/m2 K1/2	
% global	S	;	S	=	110.4	;	% degrees Kelvin
%% View


%% WCGI
%% Trimmer
global r_rps; r_rps = 0;
global p_rps; p_rps = 0;
global q_rps; q_rps = 0;
global q_dps; q_dps = 0;
global theta_dot_dps; theta_dot_dps = 0;
%% AutoTest
global SP_free_response_time; SP_free_response_time = 20;
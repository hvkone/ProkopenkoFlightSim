%% Atmosphere
%% Variables 
global dT;
global h_ft;
global rho_SL_ISA;
%% Code

dT = 0.0;
rho_SL_ISA = 0.0023769; %Slug/foot^3

[rho,a,T,P]=stdatmo(h_ft,dT,'US');
sigma = rho/rho_SL_ISA;
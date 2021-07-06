%% Weight and CG and Inertia
%% Variables
global Iyy;
global delta_t;
global fuel_flow_pph;
global W;
global trim;
%% Code
if (trim)
    W = W - (fuel_flow_pph / 3600.0) * delta_t;
end
%% Primary flight controls
%% Variables
global TLA_pos;
global TLA_norm;
global elev_deg;
global elev_rad;
global	stab_deg	;	                   
global	stab_rad	;		
global	TLA_pos_rate;	
global	delta_t	    ;
%% Code
%Inputs adquisition

if (no_joystick)
    pos = [0. , 0., 0.];     %temporary for when no actual joystick is connected
    but = zeros(15);     %temporary for when no actual joystick is connected
    TLA_pos = TLA_norm;  %temporary for when no actual joystick is connected
else
    [pos, but] = h.joystick(1);                 %read input from joystick from -1 (fwd) to +1 (aft)
end
    
%Surfaces control deflection due to joystick.


if auto_test 
    stick_pos = auto_test_stick_pos;
else
    stick_pos = (pos(2)) * (20);        %Longitudinal position of stick + conversion for stick gange: range +/- 20 degrees
end
elev_deg = -stick_pos;                      %elevator position positive TE down
elev_rad = elev_deg/57.3;                   %Deflection on radians


% [pos, but] = h.joystick(1);
% %pos = (pos(1:2)+1)/2;
% TLA_pos = 0.5+((pos(3))/2);
% stick_pos = (pos(2)-0.5) * (20/0.5);
% elev_deg = stick_pos * (-1);
% elev_rad = elev_deg/57.3;
%                        

%THRUSTMASTER
%slew actual TLA with buttons 7 (increase) and 9 (decrease)
if but(3)
    TLA_pos = TLA_pos + TLA_pos_rate*delta_t;
    if TLA_pos > 1; TLA_pos = 1; end
elseif but(5)
    TLA_pos = TLA_pos - TLA_pos_rate*delta_t;
    if TLA_pos < 0; TLA_pos = 0; end
end

% TLA_pos = abs((0.5+(pos(3))/2)-1);
%Trim control surfaces reading joystick trim switches.

if but(4)
   stab_deg = stab_deg + delta_t;   %Trim horizontal stabilizer by ading increments to it initial deflection
    if stab_deg > 3; stab_deg = 3; end
elseif but(6)
   stab_deg = stab_deg - delta_t;
   if stab_deg < -12; stab_deg = -12; end
end


if (stab_deg > 3)
    stab_deg = 3;
elseif (stab_deg <-12)               %Stop at maximun trim deflection
    stab_deg = -12;
end

stab_rad = stab_deg/57.3;
%% Flight Simulation Joystick
%  Willie Evans
%{
change joystick position into velocity
add deadband region
joystick position = deflection
FWD = [0,-1,-1] | [0.5,0] AFT = [0, 1, 1] | [0.5,1] RGT = [1, 0, 1] | [1,0.5] LFT = [-1,0, 1] | [0,0.5]
joystick position
star rate
star position
old star position
%}
%% Code 
%  You need a joystick attached to the computer for this example
function JoystickSample
tic
%% Joystick Handle
monitor = 1;                                            % The first monitor
h = actxserver('Prokopenko.Screen');                    % Start the server
h.images(monitor,{'face.bmp','star.bmp'});              % Load images for drawing
%% Initial Position
joystick_pos_x = 0;
joystick_pos_y = 0;
joystick_pos_z = 0;
while 1
    dt = toc;
    tic
%% Deadband Variable
deadband = 0.05;
%% Position to Velocity with Deadband inputs   
	[joystick_pos , but] = h.joystick(1);                     % Query joystick position and button state
%   display(joystick_pos)
    joystick_vel_x = joystick_pos(1);
    joystick_vel_y = joystick_pos(2);
    joystick_vel_z = joystick_pos(3); 
% Joystick correction to equal 0 in x y z
     if abs(joystick_vel_x) <= deadband  
         joystick_vel_x = 0;
     elseif joystick_vel_x > deadband
         joystick_vel_x = joystick_vel_x - deadband;
     elseif joystick_vel_x < 0
         joystick_vel_x = joystick_vel_x + deadband;
     end
   
     if abs(joystick_vel_y) <= deadband  
         joystick_vel_y = 0;
     elseif joystick_vel_y > deadband
         joystick_vel_y = joystick_vel_y - deadband;
     elseif joystick_vel_y < 0
         joystick_vel_y = joystick_vel_y + deadband;
     end

   if abs(joystick_vel_z) <= deadband  
       joystick_vel_z = 0;
   elseif joystick_vel_z > deadband
       joystick_vel_z = joystick_vel_z - deadband;
   elseif joystick_vel_z < 0
       joystick_vel_z = joystick_vel_z + deadband;
   end
     
% Change in position     
     joystick_vel_x = joystick_vel_x * dt;
     joystick_vel_y = joystick_vel_y * dt;
%    joystick_vel_z = joystick_vel_z * dt;

% Save old position
    joystick_old_x = joystick_pos_x;
    joystick_old_y = joystick_pos_y;
    joystick_old_z = joystick_pos_z;  

% New position    
     joystick_pos_x = joystick_pos_x + joystick_vel_x;
     joystick_pos_y = joystick_pos_y + joystick_vel_y;
     joystick_pos_z = joystick_pos_z + joystick_vel_z;
%% Screen Limits    
    if abs(joystick_pos_x) > 1
        joystick_pos_x = joystick_old_x;
    end
    
    if abs(joystick_pos_y) > 1
        joystick_pos_y = joystick_old_y;
    end
    
    if abs(joystick_pos_z) > 1
        joystick_pos_z = joystick_old_z;
    end
%% Screen Information
    joystick_pos = [joystick_pos_x,joystick_pos_y,joystick_pos_z];
    monitor_position = (joystick_pos(1:2)+1)/2;         % Rescaling position from joystick [-1,1] to screen [0,1] coordinates
    h.clear(monitor,[1 1 1]);                           % Clear screen with blue color [0 0 1]

%% Buttons   
    if any(but)                                         % If any button of the joystick is pressed
            h.image(monitor,1,monitor_position);            % then draw image 1
    else
            h.image(monitor,2,monitor_position);			% else draw image 2
    end
        h.draw(monitor);                                    % Actual output to the screen
        h.sleep(0.01);                                      % Just a delay of 10 ms to release unnecessary CPU time
        if h.key(27)                                    % If Esc key is pressed then exit
		break
        end
end
toc
return

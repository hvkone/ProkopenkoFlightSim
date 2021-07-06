%% Flight Sim
%% Clean House 
clc; close all; format long;
%% Variables
Global;
global	delta_t;
global monitor;
time = 0;
%% Main code
h = actxserver('Prokopenko.Screen');	% Start the server
h.images(monitor,{'face.bmp','sky2.bmp'});	% Load images for drawing
tic;

while 1
    if auto_test 
        autotest;
    end
    if auto_plot
        autoplot;
    end
    atmos; % atomosphere
    wcgi; % weight CG and intertia
    pfc; % primary flight controls
    aero; % aero forces and moments
    eom; % equations of motion
    engines; % engine forces and moments
    view; % out the window
    menu_v2;
    trim = trim_initial | trim_default | trim_auto_test;
         if (trim)
            trimmer;
         end

    %time = time + delta_t;
    delta_t = toc;
    tic;
        
%  	h.sleep(0.01);						% Just a delay of 10 ms to release unnecessary CPU time
    if h.key(27) % && display_menu      % If Esc key is pressed 
        break
    end
    
end 
% replay = input('Would you like to continue with your simulation? Please answer with (Yes) or (Noo) : ','s');
%     if replay == 'Yes'
%     elseif replay == 'Noo'
%         disp('Your session has been terminated.');
%         break
%     end

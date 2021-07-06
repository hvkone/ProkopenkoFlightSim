%% Menu   
[pos,but] = h.joystick(1); % read input from joystick from -1 (fwd) to +1 (aft)
    if (but (8) || display_menu) % If menu button is pressed or display menu commanded due to previous Auto Test completion
        display_menu = false; % get mode selection user input  OK we're displaying the menu - turn off the command
        mode_select = menu('Select a flight mode','Auto Test','Fly Free','Trim','Quit the Simulation');
        switch mode_select
            case 1 % auto test mode
                AT_case = menu('Run!!', 'Phugoid', 'Short Period', 'Fly Free', 'Quit');
                switch AT_case
                    case 1
                        disp('Phugoid Selected')
                        auto_test = true;
                    case 2
                        disp('Short Period Selected')
                        auto_test = true;
                    case 3
                        disp('Fly Free')
                    case 4
                        disp ('Quit selected - exiting have a nice day')
                        quit = true;
                end

            case 2 % Fly free
                disp('Fly Free')
                
            case 3 % Trim to current conditions
                disp('Trim to Current Conditions')
                V_cmd = V;
                FPA_cmd = 0.0;
                trim_initial = true;

            case 4 % QUIT
                disp ('Simulation Complete. Have a nice day.')
                break
                quit = true;
               
        end
    end

%% Auto Test

switch AT_case
    case 1 %Phugoid
        switch AT_phase
            case 1 % initialize - do this oncee
                disp('initialize Phugoid test')
                disp('begin trim')
                trim_auto_test = true;
                trim = true;
                W = 540000.0;
                h_ft = 30000;
                V_cmd = 696.3946; % feet per second- from ISA Mach=0.7
                FPA_cmd = 0.0;
                AT_free_response_time = 0.0;
                AT_phase = 2; % advance to next phase
            
            case 2 % trim
            if trim_auto_test % stay in trim phase
            else
                AT_phase = 3; % advance to next phase
                disp('run test maneuver first pass')
                initial_stick_pos = stick_pos; % save off initial stick position
                auto_test_stick_pos = initial_stick_pos;
                auto_plot = true; % when true, AutoPlot module is called
                auto_plot_phase = 1; % tell auto plot to initialize
                AT_fly_free_time = 0.0;
            end
            
            case 3 % run test maneuver - fly free for 5 secs
            if AT_fly_free_time > 5.0
                disp('run test maneuver fly free for 5 secs DONE')
                disp('run test maneuver begin control input')
                AT_phase = 4; % advance to next phase
                Phu_Input = 1;
                V_initial = V;
            else
                AT_fly_free_time = AT_fly_free_time + delta_t;
            end
            
            case 4 % control input check for end of control input criteriia
                switch Phu_Input 
                    case 1 % ramp the stick aft a little bit - need plus for "aft"
                    if auto_test_stick_pos > (initial_stick_pos+Phu_stick)
                        Phu_Input = 2; % advance to next control input phase
                        disp('run test maneuver-hold control input-check for speed decay')
                    else
                        auto_test_stick_pos = auto_test_stick_pos + Phu_stick_ramp_rate * delta_t;
                    end
                    
                    case 2 % hold stick input until speed drops by pre-determined amount
                    if V < (V_initial - V_Phu_drop)
                        Phu_Input = 3; % advance to next control input phase
                        disp('run test maneuver speed decay complete')
                        disp('ramp the stick back to original position')
                    end
            
                    case 3 % ramp the stick back to original position
                    if auto_test_stick_pos <= initial_stick_pos
                        auto_test_stick_pos = initial_stick_pos;
                        AT_phase = 5; % advance to next phase
                        disp('control input done-free response beginning')
                    else
                        auto_test_stick_pos = auto_test_stick_pos - Phu_stick_ramp_rate * delta_t;
                    end
                        otherwise
                            disp('we should never get here')
                end
            case 5 % - free response-check for end of test criteria
            if AT_free_response_time > Phu_free_response_time
                AT_phase = 6; % advance to next phase
            else
               AT_free_response_time = AT_free_response_time + delta_t;
            end
            
            case 6 % test is complete - stop gathering plot data - output plots
                auto_plot_phase = 3; % stop gathering plot data - output plots
                trim_default = true; % re-initialize to default IC conditions and trim
                AT_phase = 1; % get ready for next time an Auto Test is run
                display_menu = true; % tell MAIN to display mode selecct menu
                auto_test = false; % stop calling AutoTest
            
        end
                
    case 2 % Short Period
        switch AT_phase
            case 1 % initialize - do this once
                disp('initialize Short Period test')
                disp('begin trim')
                trim_auto_test = true;
                trim = true; 
                W = 540000;
                h_ft= 20000;
                V_cmd = 680.0;
                FPA_Cmd = 0.0;
                AT_free_response_time = 0.0;
                AT_phase = 2; % advance to next phase
            
            case 2 % trim
            if trim_auto_test % stay in trim phase
            else
                AT_phase =  3; % advance to next phase
                disp('run test maneuver first pass')
                initial_stick_pos = stick_pos; % save off initial stick position
                auto_test_stick_pos = initial_stick_pos;
                auto_plot = true; % when true, AutoPlot module is called
                auto_plot_phase = 1; % tell auto plot to initialize
                AT_fly_free_time = 0.0;
            end
            
            case 3 % run test maneuver - fly free for 5 secs
            if AT_fly_free_time > 5.0
                disp('run test maneuver fly free for 5 secs - DONE')
                disp('run test maneuver begin control input')
                AT_phase = 4; % advance to next phase
                Input = 1;
                V_initial = V;
            else
                AT_fly_free_time = AT_fly_free_time + delta_t;
            end
            
            case 4 % - control input - check for end of control input criteria
                switch Input
                    case 1 % ramp the stick aft
                        Input = 2; % advance to next control input phase
                        disp('run test maneuver - initiate SP stick step input')
                        auto_test_stick_pos = 10.0;
                        input_time = 0.0;
                        disp ('run test maneuver - hold stick for 1 sec')
                    
                    case 2 % hold stick input for 1 sec
                        input_time = input_time + delta_t;
                    if input_time > 1.0
                        Input = 3; % advance to next control input
                        disp('ramp the stick back to original position')
                        auto_test_stick_pos = initial_stick_pos;
                        AT_phase = 5; % advance to next phase
                    end
                end
                
            case 5 % free response - check for end of test criteria
            if AT_free_response_time > SP_free_response_time
                AT_phase = 6; % advance to next phase
                disp('control input done - free response beginning')
            else
                AT_free_response_time = AT_free_response_time + delta_t;
            end
            
            case 6 % test is complete - stop gathering plot data - output plots
                input_time = 0.0;
                AT_free_response_time = 0.0;
                auto_plot_phase = 3; % stop gathering plot data - output plots
                trim_default = true; % re-initialize to default IC conditions and trim
                AT_phase = 1; % get ready for next time an Auto Test is run
                display_menu = true; % tell MAIN to display mode select menu
                auto_test = false;% stop calling AutoTest
        end
end

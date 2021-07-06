%% Auto Plot
switch auto_plot_phase
    case 1 % first pass - new plot
        disp ('begin plot data gathering')
        
        plot_time = 0.0;
        plot_counter = 1;
        auto_plot_phase = 2; % advance to next phase
        
    case 2 % gather plot data
        plot_time_array(plot_counter) = plot_time;
        pitch_deg_array(plot_counter) = pitch_deg;
        V_array(plot_counter) = V;
        h_ft_array(plot_counter) = h_ft;
        alpha_FRL_deg_array(plot_counter) = alpha_FRL_deg;
        nz_array(plot_counter) = nz;
        elev_deg_array(plot_counter) = elev_deg;
        
        plot_counter = plot_counter + 1;
        plot_time = plot_time + delta_t;
        
    case 3 % stop gathering plot data - output plots
        disp ('generate plots')
        
        figure(1)
        plot (plot_time_array, pitch_deg_array);
        grid (gca, 'minor')
        title('Figure 1: Pitch (deg) vs Time');
        
        figure(2)
        plot (plot_time_array, V_array) ;
        grid(gca, 'minor')
        title('Figure 2: TAS(fps) vs Time');
        
        figure (3)
        plot (plot_time_array, h_ft_array)
        grid(gca, 'minor')
        title('Figure 3: Altitude (ft) vs Time');

        figure(4)
        plot (plot_time_array, elev_deg_array) ;
        grid (gca, 'minor')
        title('Figure 4: Elevator (deg) vs Time');
        
        auto_plot_phase = 4;
        
    case 4
        plot_time_array = 0.0;
        pitch_deg_array = 0.0;
        V_array = 0.0;
        h_ft_array = 0.0;
        alpha_FRL_deg_array = 0.0;
        nz_array = 0.0;
        elev_deg_array = 0.0;
        
        auto_plot = false; % stop calling AutoPlot
end

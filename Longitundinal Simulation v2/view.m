%% View
%% Variables
global pitch_deg;
global monitor;
global fpa_deg;
global TLA_norm
global TLA_pos
%% Code
pitch_norm = pitch_deg / 60.0 + 0.538;
if (pitch_norm > 1.0)
    pitch_norm = 1.0;
elseif (pitch_norm < 0)
    pitch_norm = 0;
end

horizon = [0.5 pitch_norm];
h.clear(monitor, [0 0 0]);          %clear screen and draw horizon at position [0.5 pitch_norm]
h.image(monitor,2,horizon);

fpa_norm = pitch_norm - (fpa_deg/60.0 +0.038);
ell_pos = [0.5 fpa_norm];
ell_size = [ (870./V)*0.02 (870./V)*0.02];
r1_pos = [0.1 0.5];
r1_size = [0.05 0.2];
r2_pos = [0.8 0.5];
r2_size = [0.05 0.2];
r3_pos = [0.9 0.5];
r3_size = [0.05 0.2];
if (~trim)
    h.pen(0.1, [255 255 255]);
else
    h.pen(0.1, [255 0 255]);
end
h.ellipse(monitor,ell_pos,ell_size);
h.rectangle(monitor,r1_pos,r1_size);
h.rectangle(monitor,r2_pos,r2_size);
h.rectangle(monitor,r3_pos,r3_size);
stab_ind = stab_deg * (0.2/15.0) + 0.56;
TLA_norm_ind = ((TLA_norm/5.0) + 0.4);    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TLA_pos_ind = ((TLA_pos/5.0) + 0.4);      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pnts = [0.075 stab_ind ; 0.125 stab_ind];
pnts2 = [0.775 TLA_pos_ind ; 0.825 TLA_pos_ind];
pnts3 = [0.875 TLA_norm_ind ; 0.925 TLA_norm_ind];
%pnts2 = [0.775 0.41 ; 0.825 0.41];
%pnts3 = [0.875 0.59 ; 0.925 0.59];
h.pen(0.1,[0 0 0]);
h.line(monitor,pnts);
h.line(monitor,pnts2);
h.line(monitor,pnts3);
h.draw(monitor);
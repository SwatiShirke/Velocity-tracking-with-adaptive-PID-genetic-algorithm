function f_vector = tire_forces(params, z, delta, ax, ay, torque_in)
    %% vehicle forces <- tire forces <- slip and normal forces <- angular wheel and 
    %% linear axel velocity <- T_inout & T_load <- accel, deccel   
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Weight distribution (assuming 50-50 split)
weight_front = 0.5;  % Percentage of weight on front axle
weight_rear = 1 - weight_front;  % Percentage on rear axle

% Static normal forces without acceleration
F_drag =air_drag_force(params, z);
load_transfer_longitudinal = (params.m * ax * params.h) / params.l;
Fz_front = ((weight_front * params.m * params.g * params.b) - load_transfer_longitudinal - F_drag * params.h) / params.l;   % Force on each front tire
Fz_rear = ((weight_rear * params.m * params.g * params.a) + load_transfer_longitudinal + F_drag * params.h) / params.l;     % Force on each rear tire



% Load transfer due to lateral acceleration (cornering)
%load_transfer_lateral = (params.m * ay * params.h) / params.tf;

% Normal forces on each tire
Fz_fl = Fz_front/2 ;  % Front-left tire
Fz_fr = Fz_front/2;  % Front-right tire
Fz_rl = Fz_rear/2;   % Rear-left tire
Fz_rr = Fz_rear/2;   % Rear-right tire


F_z = [Fz_fl, Fz_fr, Fz_rl, Fz_rr]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    Slips = caculate_slip(params, z,torque_in);

    F_x=fricx(Slips ,F_z); %% Fx = [Fflx Ffrx Frlx Frrx]T - longitudinal forces are calulated using slip ratio -> 
                                                        % friction is calculated from that
    
    alpha = calculate_slip_angles(params,z, delta );                                                    % fx = f * fz
    F_y=fricy(alpha,F_z); %%  Fy = [Ffly Ffry Frly Frry]T - lateral forces calculation using similar logic
    
    
    f_vector = [F_x' , F_y'];
end
function dz = VD_closed_loop(t, ref_vel, z, params)
    vel = z(1);
    throtle = apply_PID(ref_vel, vel, params);
    stter_angle = 0; 
    u = [throtle, stter_angle ];
    u = min(max(-1,u), 1);
    dz = vehicle_dynamics(z, u);
    %error = ref_vel - vel;
end


function throtle = apply_PID(ref_vel, vel, params)
    global cumm_error;
    global last_error;
    Kp = 1.9829; %params(1);
    Kd = 9.3883; %params(2);
    Ki = 1.6059; %params(3);
    last_error;
    error = ref_vel - vel;
    cumm_error = cumm_error + error;
    del_error = error - last_error;
    last_error = error;
    throtle = Kp * error + Kd * del_error + Ki * cumm_error;    
end
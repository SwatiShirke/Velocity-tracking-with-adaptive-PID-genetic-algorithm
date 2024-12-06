function torque_in = cal_wheel_torque_in(params, torque_in)
    % if deccel > 0
    %     accel_cmd = -deccel;
    % else
    %     accel_cmd = accel;
    % end
        %accel_cmd = accel;
        t_generated = torque_in; %params.max_torque * accel_cmd ; 
        split_ratio = [0.5, 0.5, 0.0, 0.0];        
        torque_in = split_ratio * t_generated';    
end

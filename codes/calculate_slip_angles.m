function slip_angles =  calculate_slip_angles(params,z, delta)
    Vx = z(1);
    Vy = z(2);
    r =  z(3);
    
    % term_a = atan2( (Vy + params.a * r ), ( Vx - (r * params.tf /2)) );
    % term_b = atan2( (Vy + params.a * r ), ( Vx + (r * params.tf /2)) );
    % term_c = atan2( (Vy - params.b * r ), ( Vx - (r * params.tr /2)) );
    % term_d = atan2( (Vy - params.b * r ), ( Vx + (r * params.tf /2)) );

    term_a = atan2( (Vy + params.a * r ),  Vx  );
    term_b = atan2( (Vy + params.a * r ),  Vx );
    term_c = atan2( (Vy - params.b * r ),  Vx );
    term_d = atan2( (Vy - params.b * r ),  Vx  );

    alpha_fl =  delta - term_a; if isnan(term_a ), alpha_fl = 0; end 
    alpha_fr =  delta - term_b; if isnan(term_b), alpha_fr = 0; end 
    alpha_rl = -term_c; if isnan(term_c), alpha_rl = 0; end
    alpha_rr = -term_d; if isnan(term_d), alpha_rr = 0; end
    
    slip_angles = -1 * [alpha_fl ; alpha_fr; alpha_rl; alpha_rr ];

end
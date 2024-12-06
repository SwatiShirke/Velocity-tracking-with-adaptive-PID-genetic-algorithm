%% main code%%
clc;
clear;
z_init= zeros(10,1);
z_init(1) = 16;
%Vx = z(:,1);
t_span =  [0 100];
ref_vel = 30;
global cumm_error; 
global last_error; 
cumm_error = 0;
last_error = 0;

% Parameters
totalTime = 60;                   % Total time in seconds
timeStep = 0.1;                   % Time step in seconds
maxVelocity = 45;                 % Maximum velocity in m/s

% Frequency and time points for smooth transitions
frequencyPoints = [0.02, 0.03, 0.04, 0.02]; % Low frequencies in Hz
timePoints = [0, 20, 40, 60];               % Corresponding time points in seconds

% Generate the smooth velocity interpolation function
velocityFunc = generateSmoothVelocityInterpolator(totalTime, timeStep, maxVelocity, frequencyPoints, timePoints);

[ t, z ] =ode45(@(t,z) VD_closed_loop_model(t, ref_vel, z), t_span , z_init);
%dy_dt = diff(z(:,3)/ t);
pos_x = z(:,4);
pos_y = z(:, 5);
yaw = z(:, 6);
vel_x = z(:,1);
vel_y = z(:, 2);
yaw_rate = z(:,3);
lat_accel =vel_x .* yaw_rate./9.81;
% figure(1);
% plot(  t,dy_dt , 'b-');
% xlabel('x');
% ylabel('y');
% title('yaw_accel');
% grid on;
% axis equal;
% figure(2);
% plot(  t,sin(t) , 'b-');
% xlabel('t');
% ylabel('delta');
% title('delta plot');
figure(3);

plot(  t,z(:,3) , 'b-');
xlabel('t');
ylabel('yaw rate');
title('yae rate plot');
hold 
plot(  t,lat_accel , '-');
xlabel('t');
ylabel('lat_accel');
title('lat accel plot');

figure(4);
plot(  t,z(:,1) , 'b-');
hold on;
len = size(t);
plot(t,ones(len(1), 1) * ref_vel, 'r-' )
xlabel('t');
ylabel('Vx');
title('Vx');

figure(5);
plot(  t,z(:,2) , 'b-');
xlabel('t');
ylabel('Vy');
title('Vy');

figure(6);
plot(  pos_x,pos_y , 'b-');
xlabel('x');
ylabel('y');
title('pos');
axis equal;  % Sets the aspect ratio to be equal

%%%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function velocityFunc = generateSmoothVelocityInterpolator(totalTime, timeStep, maxVelocity, frequencyPoints, timePoints)
    % Generates a time-parameterized smooth sine wave velocity profile and returns
    % an interpolated function handle to compute velocity at any time.
    %
    % Inputs:
    %   totalTime       - Total duration for the velocity profile (seconds)
    %   timeStep        - Time step for the simulation (seconds)
    %   maxVelocity     - Maximum velocity of the vehicle (m/s)
    %   frequencyPoints - Array of low frequency values for smooth transitions (Hz)
    %   timePoints      - Array of corresponding time points for the frequencies (seconds)
    %
    % Output:
    %   velocityFunc    - Function handle to compute velocity at any time
    
    % Time vector for the simulation
    time = 0:timeStep:totalTime;

    % Interpolate frequencies smoothly over time
    interpolatedFrequencies = interp1(timePoints, frequencyPoints, time, 'pchip');

    % Generate a cumulative phase using the interpolated frequencies
    phase = 2 * pi * cumsum(interpolatedFrequencies) * timeStep;

    % Generate a smooth sine-based velocity profile scaled between 0 and maxVelocity
    velocity = (maxVelocity / 2) * (1 + sin(phase));

    % Smooth the velocity further using a cubic smoothing spline
    smoothedVelocity = smoothdata(velocity, 'lowess');

    % Create an interpolation function for velocity
    velocityFunc = @(t) interp1(time, smoothedVelocity, t, 'spline', 'extrap');

    % Plot the velocity profile for visualization
    figure;
    plot(time, smoothedVelocity, 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    title('Smooth Time-Parameterized Velocity Profile');
    grid on;
end




function dz = VD_closed_loop_model(t, ref_vel, z)
    vel = z(1);
    throtle = apply_PID_control(ref_vel, vel)
    stter_angle = 0; 
    u = [throtle, stter_angle ];
    %u = min(max(-1,u), 1);
    dz = vehicle_dynamics(z, u);
    %error = ref_vel - vel;
end


function throtle = apply_PID_control(ref_vel, vel)
    global cumm_error;
    global last_error;
    Kp = 50; %params(1);
    Kd = 0; %params(2);
    Ki = 0.001; %params(3);
    last_error; 
    error = ref_vel - vel;
    cumm_error = cumm_error + error;
    del_error = error - last_error
    last_error = error;
    throtle = Kp * error + Kd * del_error + Ki * cumm_error;  
    throtle = max(min(throtle,450), -450);
end













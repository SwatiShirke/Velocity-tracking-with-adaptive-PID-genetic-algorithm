% Genetic Algorithm-based PID Parameter Optimization (Minimize Speed Error)
% Objective: Optimize PID parameters Kp, Ki, Kd
% Clear workspace
clear;
clc;
% Set Genetic Algorithm parameters
pop_size = 50; % Population size
max_gen = 5; % Maximum generations
pc = 0.7; % Crossover probability
pm = 0.01; % Mutation probability
bounds = [1 200; % Range of Kp
0 10; % Range of Ki
0 10]; % Range of Kd
% Initialize population
pop = init_population(pop_size, bounds);
% Set target speed (can be a constant value or based on model settings)
target_speed = 5; % Assume target speed is 30 m/s

% Main Genetic Algorithm loop
for gen = 1:max_gen
% Calculate fitness
fitness = zeros(pop_size, 1);
for i = 1:pop_size
params = pop(i, :);
z_init = zeros(10,1);
fitness(i) = fitness_function(params, target_speed, z_init); % Evaluate individual
end
% Select individuals
selected_pop = selection(pop, fitness);
% Crossover operation
new_pop = crossover(selected_pop, pc, bounds);
% Mutation operation
new_pop = mutation(new_pop, pm, bounds);
% Update population
pop = new_pop;
% Output best fitness of current generation
[best_fitness, best_index] = min(fitness);
best_params = pop(best_index, :);
fprintf('Generation: %d, Best Fitness: %.4f, Best Parameters: [Kp = %.4f, Ki = %.4f, Kd =%.4f]\n', gen, best_fitness, best_params (1), best_params (2), best_params (3));
end


% Output final result
fprintf('Optimization complete, Best PID Parameters: Kp = %.4f, Ki = %.4f, Kd = %.4f\n',best_params (1), best_params (2), best_params (3));
%% Initialize Population Function
function pop = init_population(pop_size, bounds)
num_params = size(bounds, 1);
pop = zeros(pop_size, num_params);
for i = 1:pop_size
for j = 1:num_params
pop(i, j) = bounds(j, 1) + rand * (bounds(j, 2) - bounds(j, 1));
end
end
end
%% Fitness Function (Objective Function − Minimize Speed Error)
function fitness = fitness_function(params, target_speed, z_init)
Kp = params (1);
Ki = params (2);
Kd = params (3);
% Set PID controller parameters
assignin('base', 'Kp', Kp);
assignin('base', 'Ki', Ki);
assignin('base', 'Kd', Kd);
% Run Simulink model and get simulation results
%simOut = sim('vehicl_model_0910_2019b', 'SimulationMode', 'normal', 'SaveOutput', 'on','SrcWorkspace', 'current');
global cumm_error; 
global last_error; 
cumm_error = 0;
last_error = 0;
t_span = [0 10];
[ t, z ] =ode45(@(t,z) VD_closed_loop(t, target_speed, z, params), t_span , z_init);

% Extract vehicle speed and time data from simOut
speed = z(1); % Extract vehicle speed
time = t; % Extract time data
% Calculate speed error
speed_error = target_speed - speed;
% Calculate Integral of Absolute Error (IAE) as fitness function
IAE = sum(abs(speed_error) .* diff([0; time]));
% Fitness function (smaller IAE is better)
fitness = IAE;
end
%% Selection Function (Roulette Wheel Selection)
function selected_pop = selection(pop, fitness)
pop_size = size(pop, 1);
fitness_inv = 1./fitness; % Inverse fitness
prob = fitness_inv/sum(fitness_inv); % Selection probability
cum_prob = cumsum(prob); % Cumulative probability
selected_pop = zeros(size(pop));
for i = 1:pop_size
r = rand;
idx = find(cum_prob >= r, 1, 'first');
selected_pop(i, :) = pop(idx, :);
end
end
%% Crossover Function
function new_pop = crossover(pop, pc, bounds)
pop_size = size(pop, 1);
num_params = size(pop, 2);
new_pop = pop;
for i = 1:2:pop_size
if rand < pc
% Randomly select crossover point
crossover_point = randi([1 num_params-1]);
% Crossover operation
new_pop(i, crossover_point + 1:end) = pop(i + 1, crossover_point + 1:end);
new_pop(i + 1, crossover_point + 1:end) = pop(i, crossover_point + 1:end);
end
end
end
%% Mutation Function
function mutated_pop = mutation(pop, pm, bounds)
pop_size = size(pop, 1);
num_params = size(pop, 2);
mutated_pop = pop;
for i = 1:pop_size
for j = 1:num_params
if rand < pm
mutated_pop(i, j) = bounds(j, 1) + rand * (bounds(j, 2) - bounds(j, 1));
end
end
end
end


function throtle = apply_PID(ref_vel, vel, Kp, Ki, Kd)
    global cumm_error;
    global last_error;  
    error = ref_vel - vel;
    cumm_error = cumm_error + error;
    del_error = error - last_error;
    last_error = error;
    throtle = Kp * error + Kd * del_error + Ki * cumm_error;    
end
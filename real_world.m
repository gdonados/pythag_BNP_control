% A MATLAB script to control Rowans Systems & Control Floating Ball 
% Apparatus designed by Mario Leone, Karl Dyer and Michelle Frolio. 
% The current control system is a PID controller.
%
% Created by Kyle Naddeo, Mon Jan 3 11:19:49 EST 
% Modified by Gabe Donados

%% Start fresh
close all; clc; clear device;

%% Connect to device
 device = serialport("COM7", 19200);%open serial communication in the proper COM port

%% Parameters
target      = 0.5;   % Desired height of the ball [m]
sample_rate = 0.25;  % Amount of time between controll actions [s]

%% Give an initial burst to lift ball and keep in air
set_pwm(device, 4000); % Initial burst to pick up ball
while true
    pause(1) % Wait 0.1 seconds
    set_pwm(device, 2550); % Set to lesser value to level out somewhere in
    % the pipe
    pause(6)
    set_pwm(device, 2555);
end
%% Initialize variables
% action      = ; % Same value of last set_pwm   
error       = 0;
error_sum   = 0;

%% Feedback loop
while true
    %% Read current height
    [distance,pwm,target,deadpan] = read_data(device);
    y = ir2y(distance); % Convert from IR reading to distance from bottom [m]
    
    %% Calculate errors for PID controller
    error_prev = error;             % D
    error      = target - y;        % P
    error_sum  = error + error_sum; % I
    
    %% Control
    prev_action = action;
    %action = % Come up with a scheme no answer is right but do something
    % set_pwm(add_proper_args); % Implement action
        
    % Wait for next sample
    pause(sample_rate)
end


% University of Applied Science - FH Vorarlberg
% Master of Mechatronics - 3rd Semester
% Sensor Systems - LSE

% Author:       Stefan Stark
% Date:         30.01.2017
% Description:  Show LSE based on noisy measurements on a path measurement
%               example.

%% clean up
clear all, close all, clc;

%% Example 1 - pathmeasurement
% y = s(t) = v*t+s0

%% create measurement points
y = [0 1 2 3 4 5 6 7 8 9]';         % [m]   ideal path
y0 = 2;                             % [m]   initail offset
y = y+y0;

for i=1:length(y)
    ynoisy(i) = y(i)+randn;         % [m]   noisy measurements
end

%% plot noisy measurement data
figure
plot(y,'o'); grid on; hold on;
plot(ynoisy);

%% LSE
% create base functions - fT = (t 1)
fT = ones(10,2);
fT(:,1) = linspace(0,9,10);
F = fT;

% LSE
P = (F'*F)^-1;          
G = P*F';                           % Parameter Schätzfehler
H = F*G;                            % Hat-Matix

a_hat = G*ynoisy';
y_hat = H*ynoisy';
% y_hat2 = F*a_hat;                 % aleternative way to calc y_hat

% plot result
plot(y_hat);
legend('theory','noisy measurements', 'best approximation',...
    'Location','southeast');
ylabel('path s [m]'); xlabel('time t [s]');
title('Path measurement');

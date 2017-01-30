% University of Applied Science - FH Vorarlberg
% Master of Mechatronics - 3rd Semester
% Sensor Systems - LSE

% Author:       Stefan Stark
% Date:         30.01.2017
% Description:  

%% clean up
clear all, close all, clc;

%% Define Paramer
% Wertepaare - y = a1*x+a2*e^(-x)
x = [0.3 1.15 1.8]';
y = [2.79 3.15 6.35]';

figure
plot(x,y,'o'); grid on; hold on;

% Basisfunction
F = zeros(3,2);             % Definition of Matrix
F (:,1) = x;                % First parameter
F (:,2) = exp(-x)           % Second parameter

%% LSE
P = (F'*F)^-1;
G = P*F';
H = F*G;

a_hat = G*y
y_hat = F*a_hat;

plot(x,y_hat);hold off;
legend('samples','approximation')

%% Wie gut sind diese Schätzwerte eignetlich? - Güte der erhaltenen 
% Schätzwerte

M = eye(3)-F*G;
e_hat = M*y;
s_2 = (e_hat'*e_hat)/(3-2)


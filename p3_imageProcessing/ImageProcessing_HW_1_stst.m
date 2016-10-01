% FHV - Master in Meachatronics
% Sensor System - Image Processing
%
% Exersice: Hough Transform (slide 4)
%
% Author:   Stefan Stark
% Date:     01.10.2016

clear all, close all, clc;

%% Given points
P1 = [1;2]; P2 = [2;3]; P3 = [3;4]; P4 = [3;3];

figure; 
plot(P1(1),P1(2),'o',P2(1),P2(2),'o',P3(1),P3(2),'o',P4(1),P4(2),'o');

%% Draw the points as lines in the parameter space (b=-a*x+y)
a = linspace(-1,5);
for i=1:length(a)
    b1(i) = -P1(1)*a(i)+P1(2);
    b2(i) = -P2(1)*a(i)+P2(2);
    b3(i) = -P3(1)*a(i)+P3(2);
    b4(i) = -P4(1)*a(i)+P4(2);
end
figure;
plot(a,b1,a,b2,a,b3,a,b4); xlabel('a'),ylabel('b');grid on;
title('Lines in parameter space');

%% Find the intersection points in the parameter space and determine 
%% corresponding lines in the xy plane
% manual readout -> intersection of 3 lines at a'=1,b'=1
x = linspace(0,3);
y=1*x+1;
figure; 
plot(x,y);title('Data points & corresponding line');xlabel('x');ylabel('y');
hold on;
plot(P1(1),P1(2),'o',P2(1),P2(2),'o',P3(1),P3(2),'o',P4(1),P4(2),'o');

% FHV - Master in Meachatronics - Sem 3 - Sensor System - Image Processing
%
% Exersice: Gradient
%
% Author:   Stefan Stark
% Date:     22.09.2016

clear all, close all, clc;

%% Read Image
I = imread('coins.png');
I = im2double(I);
figure; imshow(I);              % shows the image

%% Smooth Image (Gaussian Filter)
F = fspecial('Gaussian',11,3);
figure; surf(F);                % plots 3-D colored surface
I1 = imfilter(I,F);
figure; imshow(I1);             % shows the smoothed image

%% Differentiation (Prewitt-Filter)
Fp_y = fspecial('prewitt');     % create prewitt filter mask for y dir.
Fp_x = Fp_y';                   % create prewitt filter mask for x dir.

gy = imfilter(I,Fp_y);
gx = imfilter(I,Fp_x);
figure; 
subplot(2,1,1); imshow(gy,[]);
subplot(2,1,2); imshow(gx,[]);

%% Show gradient as Vector
figure; quiver(I,gy); zoom(8)
figure; quiver(I,gx); zoom(8)

%% Show Magnitude of Gradient
M = abs(gx)+abs(gy);
figure; imshow(M,[])


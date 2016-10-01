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
F = fspecial('Gaussian',5,2);  % in time domains the calculation time
                                % depends square time with the size of the
                                % filter. eh filter of size leads to 25
                                % calculations per pixel.
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
figure; quiver(gx,gy)           % without the smoothing, the gradients
                                % would be much more chaotic
zoom(4);

%% Show Magnitude of Gradient
M = abs(gx)+abs(gy);            
M = sqrt(gx.*gx+gy.*gy);        % another method to calculate the gradient
figure; imshow(M,[])
colormap(copper)
colorbar;


%% notes
% .* operation -> Elementwise operation
% [2 1] [7 2] vektor multiplikation is not possible, we would like to mult.
% elementwise so the result should be: [2*7 1*2]=[14 2]


% FHV - Master in Meachatronics - Sem 3 - Sensor System - Image Processing
%
% Exersice: Hough Transformaion - slide 9 - find and draw lines of an image
%
% Author:   Stefan Stark
% Date:     29.09.2016

clear all, close all, clc;

%% Read Image
I = imread('pictures/tennis.png');
I = im2double(I);
I = rgb2gray(I);
figure; imshow(I);              % shows the image

%% Canny Edge detector to find edges
I=edge(I,'canny',[0.05,0.2]);
figure; imshow(I);

%% Hough transform to detect lines
[H, THETA, RHO] = hough(I);
figure;  imshow(imadjust(mat2gray(H)))
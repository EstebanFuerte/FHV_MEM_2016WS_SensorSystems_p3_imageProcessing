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
I_gray = rgb2gray(I);
%figure; imshow(I_gray);              % shows the image

%% Canny Edge detector to find edges
I=edge(I_gray,'canny',[0.005,0.05]);
figure; imshow(I);

%% Hough transform to detect lines
[H, T, R] = hough(I);
figure; %imshow(imadjust(mat2gray(H)))

%% houghpeaks - Identify peaks in Hough transform
P = houghpeaks(H,10);
x= T(P(:,2)); y = R(P(:,1));
%figure;plot(x,y,'o')

lines = houghlines(I,T,R,P,'MinLength',300)
%split struct in xy coorditnates
figure; imshow(I_gray), hold on
for i=1:length(lines)
    xy = [lines(i).point1; lines(i).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end

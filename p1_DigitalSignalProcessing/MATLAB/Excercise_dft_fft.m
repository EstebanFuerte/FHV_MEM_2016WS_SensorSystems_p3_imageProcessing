%% MATLAB - Demo to demsonstrate the behaviour of a DFT
% Reinhard Schneider, FHV, 2015
% 
% a direct implementation of a DFT should be implemented in a function
% called my_dft( timevalues ). timevalues should be a row vector
% Comparison function must be defined in order to compare fft with my_dft

% function skeleton: please put in a file named "my_dft.m" and complete!
%{ 
function [fftvalues] = my_dft( timevalues )
% DFT: Digital Fourier Transformation
% 
% Self implemented DFT

N = length( timevalues ) ;            % DFT Length

k = 0:N-1 ;         % Index variables k and n for twiddle factor matrix
n = 0:N-1 ;
kn = n' * k; 
W = ...
fftvalues=;   % DFT - discrete!

end
%}

%% clean up workspace, close all windows and clc
clear all, close all, clc;

%% Sample #1, representing a constant function:

x = [1 1 1 1] ;
fftcompare(x) ;

%% Sample #2, representing a discrete dirac pulse:

x = [1 0 0 0] ;
fftcompare(x) ;

%% Sample #3, representing a sine function with perfect window:
t = linspace( -2*pi, 2*pi, 64 ) ;
x = sin( t ) ;
x = x(1:length(x)-1);
fftcompare(x) ;

%% Sample #4, representing a sine function with imperfect window:

t = linspace( -7, 7, 64 ) ;
x = sin( t ) ;
fftcompare(x) ;

%% Sample #5: two sine waves
t = (0:7)* 1/8.0;
x = sin( 2*pi*t ) ;
fftcompare(x) ;

%% Sample #6: create more frequency information by adding zeros
fftcompare([x,  zeros( 1,100) ]) ;

%% Sample #7: create more frequency information by assuming x is periodic
fftcompare(repmat( x,1,10)) ;

%% Sample #8: sine wave wich imperfect window
t = (0:7)* 1/9;
x = sin( 2*pi*t ) ;
fftcompare(x) ;

%% Sample #6: create more frequency information by adding zeros
fftcompare([x,  zeros( 1,100) ]) ;

%% Sample #7: create more frequency information by assuming x is periodic
fftcompare(repmat( x,1,10)) ;

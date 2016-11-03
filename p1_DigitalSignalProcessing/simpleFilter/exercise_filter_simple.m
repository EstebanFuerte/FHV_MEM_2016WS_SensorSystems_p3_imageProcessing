%% FILTER - example
%
% Implement the filter with the cannocical structure
%
% xn ---> (+)   --->   . - *b0 -> (+)
%          ^           |           ^
%          |        |z^-1|         |
%          |           |           |
%         (+)<- *-a1 - . - *b1 -> (+)
%          ^           |           ^
%          |        |z^-1|         |
%          |           |           |
%         (+)<- *-a2 - . - *b2 -> (+)
%
% COPY the lines between "function... " and "end" to a file called
% "myfilter.m" and implement the function core!
%{
function  yn = myfilter( xn ) 
% filter calculation
% filter parameters are global variables called
% a1, a2 and b0, b1, b2
% internal filter status is stored in abz(1:3)
    global a1 a2 b0 b1 b2 abz
   yn = 0 ;    
end
%}

%% Set filter parameter
clear all, close all, clc
global a1 a2 b0 b1 b2 abz
a1 = 0.2 ;
a2 = 0.21 ;
b0 = 0.4 ;
b1 = 0.6 ;
b2 = 0.8 ;

abz = [0 0 0] ;

%x = round(sin( 0:0.2:2*pi), 0) ;

x = ones( 10,1) ;
for i=1:length(x) 
    y(i) = myfilter( x(i) ) ;
end

stem( x ) ; hold on ; plot( y, '*--' ) ; hold off ;
grid  on ;
%% Impulse response:
x = zeros( size(x) ) ; 
x(1) = 1 ;

for i=1:length(x) 
    y(i) = myfilter( x(i) ) ;
end

stem( x ) ; hold on ; plot( y, '*--' ) ; hold off ;




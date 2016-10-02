function y = fftcompare( x ) 
% function y = fftcompare( x )
% used in course SENSOR SYSTEMS at FHV
%
% compares the internal implemented fft function with a external 
% defined function my_dft( x )
%
% Restuls are plotted as discrete points

    fs = 1 ; N = length(x) ;
    f  = linspace( 0, fs, N+1 ) ;
    f(N+1) = [] ;

    X  = hw_1_my_dft( x ) ;
    XF =    fft( x ) ;
    figure
    subplot( 2, 1, 1 ) ;
    stem( x ) ; grid on ;
    
    subplot( 2, 1, 2  ) ;
    stem( f, abs(X), '*r' );  hold on;  grid on ;
    stem( f, abs(XF) ,'oy') ; hold off ;
   
end


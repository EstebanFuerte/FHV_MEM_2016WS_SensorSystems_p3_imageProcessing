function  yn = myfilter( xn ) 
% filter calculation
% filter parameters are global variables called
% a1, a2 and b0, b1, b2
% internal filter status is stored in abz(1:3)
    global a1 a2 b0 b1 b2 abz
    

    abz(1) = xn+abz(2)*(-a1)+abz(3)*(-a2);
    yn = b0*abz(1)+abz(2)*b1+abz(3)*b2;
	abz(3) = abz(2);
    abz(2) = abz(1);
 
    
    
end
function [coeff M] = sinccoeff( FS, FC, BW, type )
% coeff = sinccoeff( fs, fc, bw, type )
% Compute filter coefficients for a windowed SINC - lowpass filter
% fs ... sampling frequency
% fc ... desired cut-off frequency
% bw ... desired transistion bandwidth
% type: 'lowpass', 'highpass', 'bandpass', 'bandstop'
% or:   'l', 'h', 'bp', 'bs',...

bw = BW/FS;    % relative Bandwidth (lower case)
fc = FC / FS ; % relative cutoff frequency (lower case)
M = 2*ceil(2/bw); % filter kernel length = # of coefficients
ii = linspace(0,M,M); % linear spaced "time" for M coefficients

switch lower(type) 
    case {'lowpass','low', 'lo', 'l'}

        % compute M+1 (0..M) coefficients for low pass
        
% *************        
        fc = fc+bw/2  ;  % cutoff frequency + half bandwith for formula
        disp(sprintf('%f - %f', fc,bw))
        
%        coeff = sinc(whatever);
        
        coeff = coeff/sum(coeff); % normalize coefficients
        
    case {'highpass','high', 'hi', 'h'}
        % highpass = somehow "inverted" low pass filter! consider the
        % inverting of the cutoff - frequency!
        coeff = sinccoeff_solution( FS, FS/2-FC, BW, 'l' ) ;
        % do a spectral reverse of the filter (see chapter 14) in order to
        % get a high pass!
        coeff(1:2:end) = - coeff(1:2:end) ;
        
    case {'bandpass','band', 'bp', 'p', 'b'}
        % bandpass -> apply a lowpass AND highpass filter togehter ->
        % convolution of filter coefficients!
        c1 = sinccoeff_solution( FS, FC, BW, 'l' ) ;
        c2 = sinccoeff_solution( FS, FC, BW, 'h' ) ;
        coeff = conv( c1, c2 ) ;
        
    case {'bandstop','notch', 'bs', 's', 'n'}
        % bandstop -> apply highpass and lowpass together -> 
        % ADD the coefficients!
        % Correct the cutoff frequencies!
        c1 = sinccoeff_solution( FS, FC-2*BW, BW, 'l' ) ;
        c2 = sinccoeff_solution( FS, FC+2*BW, BW, 'h' ) ;
        coeff = c1+c2 ;
        coeff = coeff/sum(coeff); % normalize coefficients
        
    otherwise
         disp('Unknown filter type.')
         return ;
end
end


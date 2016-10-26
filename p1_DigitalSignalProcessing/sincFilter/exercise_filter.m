%% FILTER - example
%
% Try to filter unwanted noise and signals from wanted signals
%
% Filter implementatino examle:
%
% Filter 1: moving average 
% Filter 2: Savitzky–Golay smoothing filter 
% Filter 3: lowpass and selective bandpass as windowed - sinc filter
%
% YOUR WORK (only small parts) IS MARKED WITH ********


%% Generate and display data
clear all ;
close all ;
figure(1);

%%

Fs   = 5000;                    % Sampling frequency
Tmax = 2.0 ;                    % time span

fsig1 = 50 ;                    % wanted Signal frequency
Asig1 = 1.4 ;                   % and magnitude

fsig2 = 150 ;                   % 3rd harmonic frequency 
Asig2 = 1.5 ;                   % and magnitude

Anoise = 5.0 ;              	% (huge) magnitude of noise (STANDARD distributed)

t = (0:1/Fs:(Tmax-1/Fs))';         % time from 0 to Tmax; Fs time steps
faxis = [0, 5*fsig2, -100, 0] ; % frequency axis parameter

zoom = (1:(Fs/fsig1*2+1)) + floor(length(t)/2); % display only some periods
taxis = [t(zoom(1)), t(max(zoom)), -2*(Asig1+Asig2),2*(Asig1+Asig2)] ; 

sig1 =  Asig1  * sin(2*pi*t*fsig1) ; % signal
sig2 =  Asig2  * sin(2*pi*t*fsig2) ; % harmonic

signal = sig1 + sig2 + Anoise * randn(size(t)); % overlay and add noise
signalTFplot( Fs, taxis, faxis, t, signal, sig1, sig2 ) 

%% Moving - Average - Filter
% Implement a moving - average - filter to "smooth" the data 
% Let N be the length of the filter!
% store the filtered sequence in "signalfma"
% DO NOT USE THE MATLAB "FILTER" COMMAND, implement the filter yourself!

N = 14 ;

N2 = ceil(N/2);     % half length of filter used for "circshift"!

NSIG = length(signal) ;

signalfma = zeros( size(signal)) ;
for ii=1:NSIG
    signalfma(ii)=signal(ii);
    for j=1:(length(N)-1)
        signalfma(ii)=signalfma(ii)+signal(ii+j);
    end
    signalfma(ii) = 1/N*signalfma(ii);
end

% time shift the resulting signal for plot:
signalfma = circshift(signalfma, N-N2 ) ;

% Implement your filter loop here!
figure()
signalTFplot( Fs, taxis, faxis, t, signalfma, signal, sig1+sig2 ) 

%% Matlab FILTER - command for moving average filter!
% use the MATLAB - "filter" command to create a MOVING AVERAGE FILTER with
% length N
% store the filter coefficients in "fm" and the filtered sequence in "signalfm"

fm = zeros( 1,N) ;      % WRONG values; just for inizialization
signalfm = signal ;     % WRONG values; just for inizialization

% ***********
fm = (1/N*ones(1,N));
signalfm = filter(fm,1,signal);
% ***********
% time shift the resulting signal for plot:
signalfm = circshift(signalfm, -(N-N2-1) ) ;

figure()
signalTFplot( Fs, taxis, faxis, t, signalfm, signal, sig1+sig2 ) 

%% plot moving average filter response
figure();
freqz( fm, 1 ) ;

%% Check the differences between the direct implementation and "filter"
sigdiff = signalfma - signalfm;
max(sigdiff)
min(sigdiff)

% ignore bordary effects at begin/end
sigdiff(1:N) = 0 ;
sigdiff(length(sigdiff)-N:end) = 0 ;
figure ;
plot( t, sigdiff ) ; grid on ;

%% STEP 2: Savitzky–Golay smoothing filter (Hint: doc sgolayfilt)
% Implement a Savitzky-Golay filter here! What is the background of this
% filter?

%Savitzky-Golay smoothing filters (also called digital smoothing polynomial 
% filters or least-squares smoothing filters) are typically used to 
%"smooth out" a noisy signal whose frequency span (without noise) is large

K=20;
F = 65;
signalsg = signal ;

signalsg = sgolayfilt(signal,K,F);

figure()
signalTFplot( Fs, taxis, faxis, t, signalsg, signal, sig1+sig2 ) 

%% STEP 3: Filter with a sinc - lowpass 
% windowed - sinc filters (only for known signals = fsig1 + fsig2 Hz!)
% Pay attention that you use 2 bands that have to be passed (superposed!)
% Try with one first, then add the second one!

% compute a low-pass sinc filter according to www.dspguide.com, chap 16
%

% ***********
% IMPLEMENT THE COMPUTATION OF THE FILTER COEFFICIENTS IN sinccoeff.m!
% ***********


BANDWIDTH = 30;

[sifilt M] = sinccoeff( Fs, fsig2, BANDWIDTH, 'l' ) ;

% apply filter by convolution (for long filter kernels)
signalsc = conv(signal, sifilt);

% cut out the right signal
signalsc = signalsc( (1:length(t)) + ceil(M/2)-1);

signalTFplot( Fs, taxis, faxis, t, signalsc, signal, sig1+sig2 ) 


%% plot sinc lowpass filter response
figure(2);
hold on  ;
freqz( sifilt, 1 ) ;
hold off ;
%% STEP 4: Filter with a selective bandpass filter based on 
% windowed - sinc filters (only for known signals = fsig1 + fsig2 Hz!)
% Pay attention that you use 2 bands that have to be passed (superposed!)
% Try with one first, then add the second one!

% compute a low-pass sinc filter according to www.dspguide.com, chap 16
%

BANDWIDTH = 5;

[sf1 M1] = sinccoeff( Fs, fsig1, BANDWIDTH, 'b' ) ;

% Convolution
signalsc = conv(signal, sf1);

% take right samples
pd = phasedelay( sf1, 1, Fs/2) ;
signalsc = signalsc( (1:length(t)) + ceil(pd(fsig1)));
signalsc1 = signalsc ;

[sf2 M2] = sinccoeff( Fs, fsig2, BANDWIDTH, 'b' ) ;

% Convolution
signalsc = conv(signal, sf2);

% take right samples
pd = phasedelay( sf2, 1, Fs/2) ;
signalsc2 = signalsc( (1:length(t)) + ceil(pd(fsig2)) );
signalsc = signalsc2+signalsc1 ;
figure(1) ;
signalTFplot( Fs, taxis, faxis, t, signalsc, signal, sig1*1+1*sig2 ) 


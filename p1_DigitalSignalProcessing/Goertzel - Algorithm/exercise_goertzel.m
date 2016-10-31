%% GOERTZEL - algorithmus implementation
% Signal and measurement data processing 
%
% Dual-tone Multi-Frequency (DTMF) signaling is the basis for voice
% communications control and is widely used worldwide in modern telephony
% to dial numbers and configure switchboards. It is also used in systems
% such as in voice mail, electronic mail and telephone banking.

%% Generating DTMF Tones
% A DTMF signal consists of the sum of two sinusoids - or tones - with
% frequencies taken from two mutually exclusive groups. These frequencies
% were chosen to prevent any harmonics from being incorrectly detected
% by the receiver as some other DTMF frequency. Each pair of tones
% contains one frequency of the low group (697 Hz, 770 Hz, 852 Hz, 941 Hz)
% and one frequency of the high group (1209 Hz, 1336 Hz, 1477Hz) and
% represents a unique symbol. The frequencies allocated to the push-buttons
% of the telephone pad are shown below:
%
%                          1209 Hz   1336 Hz   1477 Hz   
%                         _ _ _ _ _ _ _ _ _ _ _ _ _ _ _    
%                        |         |         |         |  
%                        |         |   ABC   |   DEF   |  
%                697 Hz  |    1    |    2    |    3    |     
%                        |_ _ _ _ _|_ _ _ _ _|_ _ _ _ _|  
%                        |         |         |         | 
%                        |   GHI   |   JKL   |   MNO   |  
%                770 Hz  |    4    |    5    |    6    |       
%                        |_ _ _ _ _|_ _ _ _ _|_ _ _ _ _|   
%                        |         |         |         |  
%                        |   PRS   |   TUV   |   WXY   |  
%                852 Hz  |    7    |    8    |    9    |         
%                        |_ _ _ _ _|_ _ _ _ _|_ _ _ _ _|   
%                        |         |         |         |  
%                        |         |         |         |  
%                941 Hz  |    *    |    0    |    #    |       
%                        |_ _ _ _ _|_ _ _ _ _|_ _ _ _ _|  
%                                                           

%%
clear all, close all, clc;

%% First, let's generate the ten frequency pairs
f1 = [697 770 852 941]; % Low frequency group
f2 = [1209 1336 1477];  % High frequency group
f = [ f1( 1 ) f2( 1 ) 
      f1( 1 ) f2( 2 ) 
      f1( 1 ) f2( 3 ) 
      f1( 2 ) f2( 1 ) 
      f1( 2 ) f2( 2 ) 
      f1( 2 ) f2( 3 ) 
      f1( 3 ) f2( 1 ) 
      f1( 3 ) f2( 2 ) 
      f1( 3 ) f2( 3 ) 
      f1( 4 ) f2( 2 ) ]' ;

% Next, let's generate and visualize the DTMF tones
Fs  = 8000;       % Sampling frequency 8 kHz
N   = 800;        % Tones of 100 ms
t   = (0:N-1)/Fs; % 800 samples at Fs

tones = zeros(N,size(f,2));
figure
for toneChoice=1:10,
    % Generate tone
    subplot( 10,1,toneChoice) ;
    tones(:,toneChoice) = sum(sin(f(:,toneChoice)*2*pi*t))';
    plot( tones(:,toneChoice) ) 
end

%% Playing DTMF Tones
% Let's play the tones of phone number 055727923502 for example. Notice
% that the "0" symbol corresponds to the 10th tone.
figure();
for i=[0 5 5 7 2 7 9 2 3 5 0 2 ]
    tone = i ;
    if( tone == 0 ) 
        tone = 10 ;
    end
    plot(tones(:,tone)); drawnow ;
    soundsc(tones(:,tone),Fs); 
    tic() ; while( toc() < .2 ) ; end ;
end

%% GOERTZEL
% NOW, let's just look whether your goertzel algorithm is able to detect the signal
% Implement your goertzel algorithm with the following syntax:

% [list_of_frequency_intensities] = my_goertzel( soundsignal, list_of_frequency_indices )

frequency_indices = [f1 f2]/Fs*(length(tones(:,1))-1) ;
%%
for i = 1:10
    subplot( 5,3,i ) ;
    
    f = my_goertzel( tones(:,i ), frequency_indices ) ;
    
    stem( [f1 f2], (abs(f)) * 100 / max((abs(f)))  ) ;
    
end

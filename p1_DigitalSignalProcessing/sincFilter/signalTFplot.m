function signalTFplot( Fs, taxis, faxis, t_plot, s_plot, varargin ) 
% plots the signal(s) in time and frequency domain
% Signal representation in time and frequency domain

    subplot( 2, 1, 1 ) ;
    plot( t_plot, s_plot, 'Linewidth', 2 ) ; 
    colors = ['g', 'r', 'y', 'b', 'g', 'r', 'y', 'b'] ;
    for nplot = 1:length(varargin);
        hold on ;
        plot( t_plot, varargin{nplot}, colors(nplot) ) ; 
        hold off ; 
    end
    grid on ; axis( taxis ) ;
    
    % Analyze signal in frequency spectrum
    h = spectrum.periodogram('Blackman-Harris');           % Create a spectral estimator 
    H  = psd(h,s_plot,'Fs',Fs) ;     % Compute spectra

    subplot(2, 1, 2 ) ;
    plot( H.Frequencies,  20*log10(abs(H.Data)), 'Linewidth', 2 ) ; 
    for nplot = 1:length(varargin);
        H  = psd(h,varargin{nplot},'Fs',Fs) ;     % Compute spectra
        hold on ;
        plot( H.Frequencies,  20*log10(abs(H.Data)), colors(nplot) ) ; 
        hold off ; 
    end
    grid on ; axis( faxis ) ;
end


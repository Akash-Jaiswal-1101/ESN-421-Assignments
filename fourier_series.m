
close all;
clc;

%% Fourier Example (f(x) = x^2)

    x = [-pi:.01:pi]; % range of X
    N = 10; % number of fourier coefficients
    
    % actual function
    fx = @(x) x.^2;

    
    % plot
    figure;
    plot(x,fx(x),'k','LineWidth',3,'DisplayName','f(x)'); grid on
    xlabel('x')
    ylabel('f(x)')
    hold on;
    
    % Compute coefficients (See Lecture Notes)
    
    a0 =(integral(fx,-pi,pi))/(2*pi);
    
    for ii = 1:N
        fx1=@(x) (fx(x).*cos(ii*x)/pi);
        fx2=@(x) (fx(x).*sin(ii*x)/pi);
        % bn(ii) = 0;
        % an(ii) = 4 * (-1).^(ii)/(ii.^2);
        
        an(ii)=integral(fx1,-pi,pi);
        bn(ii)=integral(fx2,-pi,pi);
    end
    
    fx_ii = zeros(1,length(x))+a0; % Initialize
    for ii = 1:N
        fourier_coeff = (an(ii)*cos(ii*x) + bn(ii)*sin(ii*x));
        fx_ii = fx_ii + fourier_coeff;
        % plot(x,fx_ii,'LineWidth',2,'DisplayName',['N = ',num2str(ii)]) % Uncomment this line to see ALL of them
    end
    plot(x,fx_ii,'LineWidth',2,'DisplayName',['N = ',num2str(ii)])
    legend show

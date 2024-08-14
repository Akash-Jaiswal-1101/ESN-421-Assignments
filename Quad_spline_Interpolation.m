
clear all
clc
close all

function [y,m,G] = quad_spline(xi,yi,x)
% Function for performing quadratic spline interpolation
% 
%-------------------
% Total number of points = N
% Total number of connecting functions = N-1
% Total number of unknowns = 3(n-1) % for quadratic
% Total number of unknowns = 4(n-1) % for cubic (BUT NOT SOLVED HERE)
% 
% Dimnesions: 
% G = 3(N-1) x 3(N-1)
% m = 3(N-1) x 1
% d = 3(N-1) x 1
%-------------------

% check length(xi) == length(yi) 
if length(xi)~=length(yi)
    error('Length of input X and input Y must be equal');
end

n = length(xi);

% pre-allocation
G = zeros(3*(n-1),3*(n-1));
% y = zeros(length(x),1);

%------------------------------------
% final data vector of length 3(n-1)
% constraint 1
temp = zeros(3*(n-1),1); 

%  temp contains 3n-3 elements
for i = 2:n-1
    j=2*(i-1);
    temp(j,1) = yi(i);
    j=j+1;
    temp(j,1)=yi(i);
end
% constraint 2
 temp(1)=yi(1);
% contraint 3
 temp(2*n-2)=yi(n);

% Final data vector
d = temp;

%----------------------------------
% Compute G
% we have to generate 3n-3 equations to get 3n-3 model parameters

%  first row for first eqn
% Constraint 1
G(1,1)=xi(1)^2;
G(1,2)=xi(1);
G(1,3)=1;

% here below till 2n-3 row are covered 
k=1;
for i = 2:n-1
    j=2*(i-1);
    G(j,k)=xi(i)^2;
    G(j,k+1)=xi(i);
    G(j,k+2)=1;
    j=j+1;
    k=k+3;
    G(j,k)=xi(i)^2;
    G(j,k+1)=xi(i);
    G(j,k+2)=1;

end
% for (2n-2)th row
m=3*(n-1);
G(2*n-2,m-2)=xi(n)^2;
G(2*n-2,m-1)=xi(n);
G(2*n-2,m)=1;

% Constraint 2
j=2*(n-1)+1;
k=1;
for i=2:n-1
    G(j,k)=2*xi(i);
    G(j,k+1)=1;
    G(j,k+2)=0;
k=k+3;
    G(j,k)=-2*xi(i);
    G(j,k+1)=-1;
    G(j,k+2)=0;
    j=j+1;
end

% Constraint 3
G(3*(n-1),1) = 1;
%-----------------------------

% compute coefficients
m = inv(G)*d;

% Compute polynomials 
% preAllocation
y = zeros(length(x),1);

count = 1;
k=1;
for ii = 1:length(x)
    if x(ii) > xi(count+1)
         k=k+3;
         count=count+1;
    end     


        y(ii) =  (m(k) * x(ii)^2) + (m(k+1) * x(ii)) + (m(k+2)*1);
   
end
end
%% =================================================
% EXAMPLE
if true
    clear all
    close all
    n = 10;
    xi = linspace(-1,1,n);
    x = linspace(-1,1,1000);
    % Test Example
    yi = [3 2 2 1 0 -3 -4 1 2 4];
    %yi = [3 2 2 1 0 -3 -4 1 2 4 3 2 2 1 0 -3 -4 1 2 4]; % for n=10
    
    % Function Call
    [y2,m,G] = quad_spline(xi,yi,x);
    
    y3 = interp1(xi,yi,x,'spline'); 
    
     %plot
    plot(xi, yi, 'o','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','k')
    hold on
    
    % plot
    plot(x,y2,'Linewidth',2,'Displayname','quadratic spline');
    % plot
    plot(x,y3,'Linewidth',2,'Displayname','in-built cubic spline');
    legend
end

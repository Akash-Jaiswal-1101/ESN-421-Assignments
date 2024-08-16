close all;
clc;
function[T,m,G]=formulation(Zi,Ti,Z)
if length(Ti) ~= length(Zi)
        error('Length of input X and input Y must be equal');
end
% Z = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
% T = [10, 15, 23, 35, 50, 70, 95, 120, 150, 190];
n=length(Ti);
% m=length(Zi);
d=[];
for i=1:n
    d(i)=log(Ti(i));
end
d=d';
%computation of G matrix
G=[];
for i=1:n
    k=1;
    G(i,k)=Zi(i);
    G(i,k+1)=1;
end

% computation of m matrix
m = (inv(G' * G) * G')*d;
 % computation of T matrix

T=[];
for i=1:1000
    k=1;
    val = Z(i)*m(k) + m(k+1);
    T(i)=exp(val);
end    

end

%Example
if true
    close all;
    clc;
    n = 10;
    
    % Test Example
     Zi = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
     Ti = [10, 15, 23, 35, 50, 70, 95, 120, 150, 190];
     Z  =  linspace(1,10,1000);
    
    % Function Call
    [y2,m,G] = formulation(Zi,Ti,Z);
    
  
    
    %plot
    plot(Zi, Ti, 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k')
    hold on
    
    % plot
    plot(Z,y2,'Linewidth',2);
    % plot
    % plot(x,y3,'Linewidth',2,'Displayname','in-built cubic spline');
    
end
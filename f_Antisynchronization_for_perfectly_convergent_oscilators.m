clear; close all;clc;
%-----------------------------------------------------------------------------------------------------------%
 %initial conditions
h=0.001; T=30;
x1_k0=-0.5;   x2_k0=0; 
y1_k0= 0.5;    y2_k0=0; 
f1_k0=x1_k0;  f2_k0=x2_k0; 
g1_k0=y1_k0;  g2_k0=y2_k0; 
%------------------------------------------------------------------------------------------------------------%
 %parameter declaration
omega_x=1.5; omega_y=2; alpha_x=1.5; alpha_y=2;K1=10.5; K2=20.5;
%------------------------------------------------------------------------------------------------------------%
 for i=0:h:T
%------------------------------------------------------------------------------------------------------------%
% complete anti-synchronization oscillator 
    x1_k1=x1_k0 + h*x2_k0;
    x2_k1=x2_k0 - h*(alpha_x*(x1_k1^2  + 2*K1 - 1)*x2_k0 + (omega_x^2)*x1_k1);
    y1_k1=y1_k0 + h*y2_k0;
    y2_k1=y2_k0 - h*(alpha_y*(y1_k1^2  + 2*K1 - 1)*y2_k0 + (omega_y^2)*y1_k1);
%------------------------------------------------------------------------------------------------------------%
% complete anti-synchronization oscillator 
    f1_k1=f1_k0 + h*f2_k0;
    f2_k1=f2_k0 - h*(alpha_x*(f1_k1^2  + 2*K1 - 1)*f2_k0 + (omega_x^2)*f1_k1 + alpha_x*K1*(g2_k0 - f2_k0));
    g1_k1=g1_k0 + h*g2_k0;
    g2_k1=g2_k0 - h*(alpha_y*(g1_k1^2  + 2*K1 - 1)*g2_k0 + (omega_y^2)*g1_k1 + alpha_y*K1*(f2_k1 - g2_k0));
%------------------------------------------------------------------------------------------------------------%
  %handling output data
ind=round((1 + (i*(1/h))));
data.t(ind)=i;
data.x1(ind)=x1_k1; data.x2(ind)=x2_k1;
data.y1(ind)=y1_k1; data.y2(ind)=y2_k1;
data.f1(ind)=f1_k1; data.f2(ind)=f2_k1;
data.g1(ind)=g1_k1; data.g2(ind)=g2_k1;
%------------------------------------------------------------------------------------------------------------%
% state assigniment
x1_k0=x1_k1;        x2_k0=x2_k1;
y1_k0=y1_k1;        y2_k0=y2_k1;
f1_k0=f1_k1;        f2_k0=f2_k1;
g1_k0=g1_k1;        g2_k0=g2_k1;
%------------------------------------------------------------------------------------------------------------%
 end
%------------------------------------------------------------------------------------------------------------%
 %plot of the systems
    figure('Color','white','Name','complete synchronization oscillator','NumberTitle','off')
    subplot(2,2,1)
    comet(data.t, data.x1)
    title('Oscilator one before anti-synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,2,3)
    comet(data.t, data.y1)
    title('Oscilator two before anti-synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,2,2)
    comet(data.t, data.f1)
    title('Oscilator one after anti-synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,2,4)
    comet(data.t, data.g1)
    title('Oscilator two after anti-synchronization')
    xlabel('x_1')
    ylabel('x_2')
%------------------------------------------------------------------------------------------------------------%



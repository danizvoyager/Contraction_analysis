clear; close all;clc;
%-----------------------------------------------------------------------------------------------------------%
 %initial conditions
h=0.001; T=20;
x1_k0=-2.5;   x2_k0=0; 
y1_k0=0.5;    y2_k0=0; 
m1_k0=x1_k0;  m2_k0=x2_k0; 
n1_k0=y1_k0; n2_k0=y2_k0;
c1_k0=x1_k0; c2_k0=x2_k0; 
b1_k0=y1_k0; b2_k0=y2_k0; 
s1_k0=x1_k0; s2_k0=x2_k0; 
r1_k0=y1_k0; r2_k0=y2_k0;  
%------------------------------------------------------------------------------------------------------------%
 %parameter declaration
omega_x=1; omega_y=3.5;  alpha_x=1; alpha_y=6;  K1=1.5; K2=2.5;
%------------------------------------------------------------------------------------------------------------%
 for i=0:h:T
%------------------------------------------------------------------------------------------------------------%
  % oscillator one 
    x1_k1=x1_k0 + h*x2_k0;
    x2_k1=x2_k0 - h*(alpha_x*(x1_k1^2 - 1)*x2_k0 + omega_x^2*x1_k1);
%------------------------------------------------------------------------------------------------------------%
  % oscillator two
    y1_k1=y1_k0 + h*y2_k0;
    y2_k1=y2_k0 - h*(alpha_y*(y1_k1^2 - 1)*y2_k0 + omega_y^2*y1_k1);
%------------------------------------------------------------------------------------------------------------%
  % complete synchronization oscillator 
    m1_k1=m1_k0 + h*m2_k0;
    m2_k1=m2_k0 - h*(alpha_x*(m1_k1^2 - 1)*m2_k0 + omega_x^2*m1_k1 - alpha_x*K1*(n2_k0 - m2_k0));
    n1_k1=n1_k0 + h*n2_k0;
    n2_k1=n2_k0 - h*(alpha_y*(n1_k1^2 - 1)*n2_k0 + omega_y^2*n1_k1 - alpha_y*K2*(m2_k1 - n2_k0));
%-------------------------------------------------------------------------------------------------------------%
% complete anti-synchronization oscillator
s1_k1=s1_k0 + h*s2_k0;
s2_k1=s2_k0 - h*(alpha_x*(s1_k1^2 - 1)*s2_k0 + omega_x^2 *s1_k1 + alpha_x*K1*(s2_k0 + r2_k0));
r1_k1=r1_k0 + h*r2_k0;
r2_k1=r2_k0 - h*(alpha_y*(r1_k1^2 - 1)*r2_k0 + omega_y^2 *r1_k1 + alpha_y*K1*(r2_k0 + s2_k1));
%-------------------------------------------------------------------------------------------------------------%
% oscilator 'y' following oscilator 'x'
    b1_k1=b1_k0 + h*b2_k0;
    b2_k1=b2_k0 - h*(alpha_y*(b1_k1^2 - 1)*b2_k0 + omega_y^2*b1_k1 - alpha_y*K2*(x2_k1 - b2_k0));
% oscilator 'x' following oscilator 'y'
    c1_k1=c1_k0 + h*c2_k0;
    c2_k1=c2_k0 - h*(alpha_x*(c1_k1^2 - 1)*c2_k0 + omega_x^2*c1_k1 - alpha_x*K2*(y2_k1 - c2_k0));
%------------------------------------------------------------------------------------------------------------% 
%handling output data
    ind=round((1 + (i*(1/h))));
    data.t(ind)=i;
    data.x1(ind)=x1_k1; data.x2(ind)=x2_k1;
    data.y1(ind)=y1_k1; data.y2(ind)=y2_k1;
    data.m1(ind)=m1_k1; data.m2(ind)=m2_k1;
    data.n1(ind)=n1_k1; data.n2(ind)=n2_k1;
    data.b1(ind)=b1_k1; data.b2(ind)=b2_k1;
    data.c1(ind)=c1_k1; data.c2(ind)=c2_k1;
    data.s1(ind)=s1_k1; data.s2(ind)=s2_k1;
    data.r1(ind)=r1_k1; data.r2(ind)=r2_k1;
%------------------------------------------------------------------------------------------------------------%
% state assigniment
    x1_k0=x1_k1;        x2_k0=x2_k1;
    y1_k0=y1_k1;        y2_k0=y2_k1;
    m1_k0=m1_k1;        m2_k0=m2_k1;
    n1_k0=n1_k1;        n2_k0=n2_k1;
    b1_k0=b1_k1;        b2_k0=b2_k1;
    c1_k0=c1_k1;        c2_k0=c2_k1;
    s1_k0=s1_k1;        s2_k0=s2_k1;
    r1_k0=r1_k1;        r2_k0=r2_k1;
%------------------------------------------------------------------------------------------------------------%
 end
%------------------------------------------------------------------------------------------------------------%
 %plot of the systems
    figure('Color','white','Name','Vander Pol Oscillator','NumberTitle','off')
    subplot(2,4,1)
    comet(data.t,data.x1)
%     comet(data.x1,data.x2)
    title('Oscilator one before synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,4,2)
    comet(data.t,data.y1)
%     comet(data.y1,data.y2)
    title('Oscilator two before synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,4,3)
    comet(data.t,data.m1)
%     comet(data.m1,data.m2)
    title('Oscilator one after synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,4,4)
    comet(data.t,data.n1)
%     comet(data.n1,data.n2)
    title('Oscilator two after synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,4,5)
    comet(data.t,data.s1)
%     comet(data.s1,data.s2)
    title('Oscilator one after anti-synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,4,6)
    comet(data.t,data.r1)
%     comet(data.r1,data.r2)
    title('Oscilator two after anti-synchronization')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,4,7)
    comet(data.t,data.b1)
%     comet(data.b1,data.b2)
    title('Oscilator two following oscilator one')
    xlabel('x_1')
    ylabel('x_2')
    subplot(2,4,8)
    comet(data.t,data.c1)
%       comet(data.c1,data.c2)
    title('Oscilator one following oscilator two')   
    xlabel('x_1')
    ylabel('x_2')
%------------------------------------------------------------------------------------------------------------%
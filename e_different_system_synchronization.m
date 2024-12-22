clear; close all;clc;
%-----------------------------------------------------------------------------------------------------------%
 %initial conditions
h=0.001; T=20;
x1_k0=-2;     x2_k0=0;   y1_k0=0;      y2_k0=0; 
m1_k0=x1_k0;  m2_k0=0;   n1_k0=y1_k0;  n2_k0=0;
a1_k0=x1_k0;  a2_k0=0;   b1_k0=y1_k0;  b2_k0=0; 
s1_k0=x1_k0;  s2_k0=0;   r1_k0=y1_k0;  r2_k0=0; 
%------------------------------------------------------------------------------------------------------------%
 %parameter declaration
omega_x=2; alpha_x=1; g=9.81; l_y=5; K1=100.5; K2=50.5;
%------------------------------------------------------------------------------------------------------------%
 for i=0:h:T
%------------------------------------------------------------------------------------------------------------%
  % Vanderpol oscilator 
    x1_k1=x1_k0 + h*x2_k0;
    x2_k1=x2_k0 - h*(alpha_x*(x1_k1^2 - 1)*x2_k0 + omega_x^2*x1_k1);
%------------------------------------------------------------------------------------------------------------%
  % oscillator two
    y1_k1=y1_k0 + h*y2_k0;
    y2_k1=y2_k0 - h*(g/l_y)*sin(y1_k1);
%------------------------------------------------------------------------------------------------------------%
  % complete synchronization oscillator 
    m1_k1=m1_k0 + h*m2_k0;
    m2_k1=m2_k0 - h*(alpha_x*(m1_k1^2 - 1)*m2_k0 + omega_x^2*m1_k1 - K1*(n2_k0 - m2_k0));
    n1_k1=n1_k0 + h*n2_k0;
    n2_k1=n2_k0 - h*((g/l_y)*sin(n1_k1) - K2*(m2_k0 - n2_k0));
%------------------------------------------------------------------------------------------------------------%
% complete anti-synchronization oscillator
    s1_k1=s1_k0 + h*s2_k0;
    s2_k1=m2_k0 - h*(alpha_x*(s1_k1^2 - 1)*s2_k0 + omega_x^2*s1_k1 + K1*(r2_k0 + s2_k0));
    r1_k1=r1_k0 + h*r2_k0;
    r2_k1=r2_k0 - h*((g/l_y)*sin(r1_k1) + K2*(r2_k0 + s2_k0));
%------------------------------------------------------------------------------------------------------------%
% oscilator 'b' follow oscilator 'x'
    a1_k1=a1_k0 + h*a2_k0;
    a2_k1=a2_k0 - h*(alpha_x*(a1_k1^2 - 1)*a2_k0 + omega_x^2*a1_k1 - K1*(y2_k0 - a2_k0));
    b1_k1=b1_k0 + h*b2_k0;
    b2_k1=b2_k0 - h*((g/l_y)*sin(b1_k1) - K1*(x2_k0 - b2_k0));
%------------------------------------------------------------------------------------------------------------%
  %handling output data
ind=round((1 + (i*(1/h))));
data.t(ind)=i;
data.x1(ind)=x1_k1; data.x2(ind)=x2_k1;
data.y1(ind)=y1_k1; data.y2(ind)=y2_k1;
data.m1(ind)=m1_k1; data.m2(ind)=m2_k1;
data.n1(ind)=n1_k1; data.n2(ind)=n2_k1;
data.s1(ind)=s1_k1; data.s2(ind)=s2_k1;
data.r1(ind)=r1_k1; data.r2(ind)=r2_k1;
data.a1(ind)=a1_k1; data.a2(ind)=a2_k1;
data.b1(ind)=b1_k1; data.b2(ind)=b2_k1;
%------------------------------------------------------------------------------------------------------------%
% state assigniment
x1_k0=x1_k1;        x2_k0=x2_k1;
y1_k0=y1_k1;        y2_k0=y2_k1;
m1_k0=m1_k1;        m2_k0=m2_k1;
n1_k0=n1_k1;        n2_k0=n2_k1;
a1_k0=a1_k1;        a2_k0=a2_k1;
b1_k0=b1_k1;        b2_k0=b2_k1;
s1_k0=s1_k1;        s2_k0=s2_k1;
r1_k0=r1_k1;        r2_k0=r2_k1;
%------------------------------------------------------------------------------------------------------------%
 end
%------------------------------------------------------------------------------------------------------------%
 %Original Systems
    figure('color','white','Name','Pendulum and Vander Pol Oscillator ','NumberTitle','off')
    subplot(2,4,1)
    comet(data.t, data.x1,0.5)
    title('Vanderpol oscilator before synchronization')
    subplot(2,4,2)
    comet(data.t, data.y1,0.5)
    title('Pendulum before synchronization')
    subplot(2,4,3)
    comet(data.t, [data.m1,data.n1],0.5)
    title('Vanderpol oscilator after synchronization')
    subplot(2,4,4)
    comet(data.t, data.n1,0.5)
    title('Pendulum after synchronization')
    subplot(2,4,5)
    comet(data.t, data.s1,0.5)
    title('Vanderpol oscilator after anti-synchronization')
    subplot(2,4,6)
    comet(data.t, data.r1,0.5)
    title('Pendulum after anti-synchronization')
    subplot(2,4,7)
    comet(data.t, data.b1,0.5)
    title('Pendulum after being a follower')
    subplot(2,4,8)
    comet(data.t, data.a1,0.5)
    title('Vanderpol oscilator after being a follower')
%------------------------------------------------------------------------------------------------------------%
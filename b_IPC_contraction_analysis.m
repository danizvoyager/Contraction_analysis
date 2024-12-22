close all 
clc; clear;
mp=0.25;mc=0.2; l=0.3;I=0.5*mp*l^2; g=9.81; h=0.001;
q=(mp+mc)*(mp*l^2 + I) - (mp*l)^2;
A=[0 1 0 0; 0 0 -((mp*l)^2)*g/q 0; 0 0 0 1; 0 0 mp*l*g*(mp+mc)/q 0];
B=[0; (I+mp*l^2)/q; 0; -mp*l/q];
C=[1 0 1 0];
Q=C'*C;
R=1;
K_lqr=lqr(A,B,Q,R);
k1=0.01;k2=0.01;
%system dynamics
x1_k0=0.001;x2_k0=0; x3_k0=pi/20;x4_k0=0;v1_hat=0;v2_hat=0; v1_bar_k0=0; v2_bar_k0=0;
for i=0:h:40
a=(mp*l^2 + I)*mp*l*(x4_k0^2)*sin(x3_k0) - (mp*l)^2 * g*sin(x3_k0)*cos(x3_k0);
b=-(mp*l)^2 * (x4_k0^2)*sin(x3_k0)*cos(x3_k0) + (mp+ mc)*mp*l*g*sin(x3_k0);
c=(mp+mc)*(mp*l^2 + I) - (mp*l*cos(x3_k0))^2;
 u=-K_lqr*[x1_k0;v1_hat;x3_k0;v2_hat];
 x1_k1=x1_k0 + h*x2_k0;
 x2_k1=x2_k0 + h*(a + (mp*l^2 + I)*u)/c;
 x3_k1=x3_k0 + h*x4_k0;
 x4_k1=x4_k0 + h*(b - (mp*l*cos(x3_k1)*u))/c;
a_o=(mp*l^2 + I)*mp*l*(v2_hat^2)*sin(x3_k1) - (mp*l)^2 * g*sin(x3_k1)*cos(x3_k1);
b_o=-(mp*l)^2 * (v2_hat^2)*sin(x3_k1)*cos(x3_k1) + (mp+ mc)*mp*l*g*sin(x3_k1);
c_o=(mp+mc)*(mp*l^2 + I) - (mp*l*cos(x3_k1))^2;
 v1_hat=v1_bar_k0 + k1*x1_k1;
 v1_bar_k1=v1_bar_k0 + h*(a_o + (mp*l^2 + I)*u)/c_o - k1*v1_hat;
 v2_hat=v2_bar_k0 + k2*x3_k1;
 v2_bar_k1=v2_bar_k0 + h*(b_o - (mp*l*cos(x3_k1)*u))/c_o - k2*v2_hat;
ind=round((1 + (i*(1/h))));
data.t(ind)=i;
data.x1(ind)=x1_k1;
data.x2(ind)=x2_k1;
data.x3(ind)=x3_k1;
data.x4(ind)=x4_k1;
data.v1_hat(ind)= v1_hat;
data.v2_hat(ind)= v2_hat;
x1_k0=x1_k1;
x2_k0=x2_k1;
x3_k0=x3_k1;
x4_k0=x4_k1;
v1_bar_k0= v1_bar_k1;
v2_bar_k0= v2_bar_k1;
end
figure('Color','white','Name','system response','NumberTitle','off');
 subplot(2,2,1)
 plot(data.t,[data.x1;data.x3])
 title('system response')
 xlabel('time (sec)')
 ylabel('magnitude')
 legend('linear position','angular position')
 subplot(2,2,2)
 plot(data.t,[data.x2;data.v1_hat])
 title('Estimated x_2 and measured x_2')
  xlabel('time (sec)')
 ylabel('magnitude m/s')
 legend('measured x_2','Estimated x_2')
 subplot(2,2,3)
 plot(data.t,[data.x4;data.v2_hat])
 title('Estimated x_4 and measured x_4')
  xlabel('time (sec)')
  ylabel('magnitude rad/sec')
 legend('measured x_4','Estimated x_4')
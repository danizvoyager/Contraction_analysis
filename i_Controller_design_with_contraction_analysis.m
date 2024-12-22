clc; clear; close all;
 h=0.001;
x_k0_in=-1:0.5:2; x2_k0=0;
for j=1:1:length(x_k0_in)
 x1_k0=x_k0_in(j);  
for i=0:h:20
     u_1= -2*(x2_k0^3 + x2_k0)  + x1_k0^2 + x1_k0 - x1_k0^3 - 1.2^3;
     u_2=-2;
     x1_k1=x1_k0 + h*x2_k0;
     x2_k1=x2_k0 + h*((x2_k0^3) - x1_k1^2  + u_1);
    ind=round((1 + (i*(1/h))));
    data.t(ind)=i;
    data.x1(ind)=x1_k1;
    data.x2(ind)=x2_k1;
    x1_k0=x1_k1;
    x2_k0=x2_k1;
end
figure(1);
 subplot(2,1,1)
 hold on
 plot(data.t,data.x1)
 title('system response')
 xlabel('time (sec)')
 ylabel('magnitude')
 subplot(2,1,2)
  hold on
 plot(data.t,data.x2)
 title('system response x_2')
  xlabel('time (sec)')
 ylabel('magnitude')
end
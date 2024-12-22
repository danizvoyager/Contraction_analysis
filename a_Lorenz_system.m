close all; clear; clc;
x_k0_in=-2:0.1:2;y_k0_in=x_k0_in; z_k0_in=x_k0_in; delta=10; beta=1; rho=30;h=0.001;
for j=1:1:length(x_k0_in)
 x_k0=x_k0_in(j); y_k0=y_k0_in(j);  z_k0=z_k0_in(j); yhat_k0=y_k0; zhat_k0=z_k0;   
for i=0:h:10
x_k1=x_k0 + h*delta*(y_k0 - x_k0);
y_k1=y_k0 + h*(rho*x_k1 - y_k0 - x_k1*z_k0);
z_k1=z_k0 + h*(-beta*z_k0 + x_k1*y_k1);
yhat_k1=yhat_k0 + h*(rho*x_k1 - yhat_k0 - x_k1*zhat_k0);
zhat_k1=zhat_k0 + h*(-beta*zhat_k0 + x_k1*yhat_k1);
ind=round((1 + (i*(1/h))));
data.x(ind)=x_k1;
data.y(ind)=y_k1;
data.z(ind)=z_k1;
data.yhat(ind)=yhat_k1;
data.zhat(ind)=zhat_k1;
data.t(ind)=i;
x_k0=x_k1;
y_k0=y_k1;
z_k0=z_k1;
yhat_k0=yhat_k1;
zhat_k0=zhat_k1;
end
figure(1)
subplot(2,2,1)
grid on
plot3(data.x,data.y,data.z);
title('Measured value of the states')
hold on
subplot(2,2,2)
grid on
plot3(data.x,data.yhat,data.zhat);
title('Estimated value of the states')
hold on
subplot(2,2,3)
plot(data.x,data.z,'black');
title('Lorenz Attractor')
hold on
end
function plot_impulse(A)

N = A.N;
h = A.h;
T = 1:N;

P_x = A.Impulses(:,1);
P_y = A.Impulses(:,2);
P_z = A.Impulses(:,3);
P_xt = A.Impulses(:,4);
P_yt = A.Impulses(:,5);
P_zt = A.Impulses(:,6);


figure
plot(T*h,P_x/h,T*h,P_y/h);
xlabel('Time (s)');
ylabel('Force (N)');
legend('F_x','F_y');

figure
plot(T*h,P_xt/h,T*h,P_yt/h,T*h,P_zt/h);
xlabel('Time (s)');
ylabel('Torque (N.m)');
legend('\tau_x','\tau_y','\tau_z');

end
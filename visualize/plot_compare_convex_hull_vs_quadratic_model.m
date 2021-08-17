clear all
addpath('ICRA_non-convex_data');

load('quadratic_data_4s.mat')
load('NCP_data_4s.mat')
load('convex_Hull_data_4s.mat')

% time consuming
T_quadratic = quadratic_data.time_quadratic;
T_NCP = NCP_data.time_NCP;
T_convex_hull = Convex_hull.time_NCP;

% velocity
v_x_quadratic = quadratic_data.v_x_p;
v_y_quadratic = quadratic_data.v_y_p;

v_x_NCP = NCP_data.z(1,:);
v_y_NCP = NCP_data.z(2,:);

v_x_convex_hull = Convex_hull.z(1,:);
v_y_convex_hull = Convex_hull.z(2,:);

% angular velocity
w_z_quadratic = quadratic_data.w_z_p;
w_z_NCP = NCP_data.z(6,:);
w_z_convex_hull = Convex_hull.z(6,:);

N = quadratic_data.N;
h = quadratic_data.h;
T = 1:N;
figure

plot(T*h,log(T_quadratic));
hold on
plot(T*h,log(T_NCP));
hold on
plot(T*h,log(T_convex_hull));

figure
subplot(2,1,1);
plot(T*h,v_x_quadratic,T*h,v_x_NCP,'*',T*h,v_x_convex_hull,'o');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
legend('v_xQ', 'v_xN', 'v_xC');
subplot(2,1,2);
plot(T*h,-v_x_NCP+v_x_convex_hull,T*h,v_x_convex_hull-v_x_quadratic);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
legend('v_xC - v_xN', 'v_xC -v_xQ');

figure
subplot(2,1,1);
plot(T*h,w_z_quadratic,T*h,w_z_NCP,'*',T*h,w_z_convex_hull,'o');
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
legend('w_zQ', 'w_zN', 'w_zC');
subplot(2,1,2);
plot(T*h,-w_z_NCP+w_z_convex_hull,T*h,w_z_convex_hull-w_z_quadratic);
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
legend('w_zC - w_zN', 'w_zC -w_zQ');
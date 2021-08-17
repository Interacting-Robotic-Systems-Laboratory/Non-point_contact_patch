function plot_q_a(A)

N = A.N;
h = A.h;
T = 1:N;

% Q_x = A.q(1,:);
% Q_y = A.q(2,:);
% Q_z = A.q(3,:);
A_x = A.z(7,:);
A_y = A.z(8,:);
A_z = A.z(9,:);
figure

plot(T*h,A_z,T*h,A_x,T*h,A_y);
xlabel('Time (s)');
ylabel('Distance (m)');
legend('a_z','a_x','a_y');

end
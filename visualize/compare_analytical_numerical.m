function compare_analytical_numerical(A)
N =A.N;
h = A.h;
for i = 1:N
    diff_q_x(i) = A.q(1,i) - A.pure_trans_q_x(i);
    diff_q_y(i) = A.q(2,i) - A.pure_trans_q_y(i);
    diff_p_t(i) = A.z(25,i) + A.z(28,i) + A.z(31,i) - A.pure_trans_p_t(i);
    diff_p_o(i) = A.z(26,i) + A.z(29,i) + A.z(32,i) - A.pure_trans_p_o(i);
end
figure
T = 1:N;
subplot(2,1,1);
plot(T*h,diff_p_t);
hold on
plot(T*h,diff_p_o);
xlabel('Time (s)')
ylabel('Impulse (N.s)')
subplot(2,1,2);
plot(T*h,diff_q_x);
hold on
plot(T*h,diff_q_y);
xlabel('Time (s)')
ylabel('Position (m)')
end
function state_plot(A)




T = 1:A.N;
n = A.n_try;
h = A.h;
for i = 1:n
    
    store_v_x(i,:) = A.z(1,:,i);
    store_v_y(i,:) = A.z(2,:,i);
    store_w_z(i,:) = A.z(6,:,i);
    store_a11_x(i,:) = A.z(7,:,i);


end

figure

subplot(2,1,1)
for i = 1:n
    plot(T*h,store_v_x(i,:));
    hold on
end
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('x-coordinate of translational velocity and standard deviation for ten different simulations');
subplot(2,1,2)
S_v_x = std(store_v_x,1,1);
plot(h*T,S_v_x);
xlabel('Time (s)')
ylabel('Deviation (m/s)')


figure
subplot(2,1,1)
for i = 1:n
    plot(h*T,store_v_y(i,:));
    hold on
end
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('y-coordinate of translational velocity and standard deviation for ten different simulations');
subplot(2,1,2)
S_v_y = std(store_v_y,1,1);
plot(h*T,S_v_y);
xlabel('Time (s)')
ylabel('Deviation (m/s)')



figure
subplot(2,1,1)
for i = 1:n
    plot(h*T,store_w_z(i,:));
    hold on
end
xlabel('Time (s)')
ylabel('Angular velocity (rad/s)')
title('Angular velocity about normal axis and stadnard deviation for ten different simulations');
subplot(2,1,2)
S_w_z = std(store_w_z,1,1);
plot(h*T,S_w_z);
xlabel('Time (s)')
ylabel('Deviation (rad/s)')


figure
subplot(2,1,1)
for i = 1:n
    plot(h*T,store_a11_x(i,:));
    hold on
end
xlabel('Time (s)')
ylabel('Position (m)')
title('X-coordinate of equivalent contact point 1 and stadnard deviation for ten different simulations');
subplot(2,1,2)
S_a11_x = std(store_a11_x,1,1);
plot(h*T,S_a11_x);
xlabel('Time (s)')
ylabel('Deviation (m)')
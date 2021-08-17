function  movie_multiple_patches(A)
N = A.N;


H_o = A.dim(3)/2;
R = A.dim_patch(2);
H_p = A.dim_patch(3);
R_p = A.dim_patch(1);



if A.num_patches == 1
elseif A.num_patches == 2
elseif A.num_patches == 3
    theta = pi/6;
    q_b1 = [-cos(theta)*R;-sin(theta)*R;-(H_o-H_p/2);1];
    q_b2 = [cos(theta)*R;-sin(theta)*R;-(H_o-H_p/2);1];
    q_b3 = [0;R;-(H_o-H_p/2);1];
    
    q_bt = [0;0;0.05;1];
    q_bb = [0;0;-0.05;1];
    
    q_bb1 = [-cos(theta)*R;-sin(theta)*R;-H_o;1];
    q_bb2 = [cos(theta)*R;-sin(theta)*R;-H_o;1];
    q_bb3 = [0;R;-H_o;1];
    
    set(gca,'nextplot','replacechildren'); 
    v = VideoWriter('test.avi');
    open(v);
    for i = 1:N
    q0 = A.q(4,i);
    q1 = A.q(5,i);
    q2 = A.q(6,i);
    q3 = A.q(7,i);
    
    q_x = A.q(1,i);
    q_y = A.q(2,i);
    q_z = A.q(3,i);
    
    a3_x = A.z(19,i);
    a3_y = A.z(20,i);
    a3_z = A.z(21,i);
    
    a1_x = A.z(7,i);
    a1_y = A.z(8,i);
    a1_z = A.z(9,i);
    
    a2_x = A.z(13,i);
    a2_y = A.z(14,i);
    a2_z = A.z(15,i);
    
    E = [-q1 q0 -q3 q2;
     -q2 q3 q0 -q1;
     -q3 -q2 q1 q0];

    G = [-q1 q0 q3 -q2;
         -q2 -q3 q0 q1;
         -q3 q2 -q1 q0];
 
    R = E*G';
    
    H = [R,[q_x;q_y;q_z];zeros(1,3),1];
    
    q_w1 = H*q_b1;
    q_w2 = H*q_b2;
    q_w3 = H*q_b3;
    
    q_wt = H*q_bt;
    q_wb = H*q_bb;
    
    q_wb1 = H*q_bb1;
    q_wb2 = H*q_bb2;
    q_wb3 = H*q_bb3;
    
    [x1,y1,z1]=cylinder_mod([q_w1(1),q_w1(2),q_w1(3)],R_p,H_p);
    [x2,y2,z2]=cylinder_mod([q_w2(1),q_w2(2),q_w2(3)],R_p,H_p);
    [x3,y3,z3]=cylinder_mod([q_w3(1),q_w3(2),q_w3(3)],R_p,H_p);
    [x4,y4,z4]=cylinder_mod([q_x,q_y,q_z],0.4,0.1);
    
    [x_t, y_t, z_t] = ellipsoid(q_wt(1),q_wt(2),q_wt(3),0.4,0.4,0,30);
    [x_b, y_b, z_b] = ellipsoid(q_wb(1),q_wb(2),q_wb(3),0.4,0.4,0,30);
    
    [x_b1, y_b1, z_b1] = ellipsoid(q_wb1(1),q_wb1(2),q_wb1(3),0.1,0.1,0,30);
    [x_b2, y_b2, z_b2] = ellipsoid(q_wb2(1),q_wb2(2),q_wb2(3),0.1,0.1,0,30);
    [x_b3, y_b3, z_b3] = ellipsoid(q_wb3(1),q_wb3(2),q_wb3(3),0.1,0.1,0,30);
    
     a1=surf(x1,y1,z1,'FaceColor',[1 1 0]);
     hold on
     a2=surf(x2,y2,z2,'FaceColor',[1 1 0]);
     hold on
     a3=surf(x3,y3,z3,'FaceColor',[1 1 0]);
     hold on
     a4=surf(x4,y4,z4,'FaceColor',[1 1 0]);
     hold on
     a5=surf(x_t,y_t,z_t,'FaceColor',[1 1 0],'Linestyle','none');
     hold on
     a6=surf(x_b,y_b,z_b,'FaceColor',[1 1 0]);
     hold on
     a7=surf(x_b1,y_b1,z_b1,'FaceColor',[1 1 0]);
     hold on
     a8=surf(x_b2,y_b2,z_b2,'FaceColor',[1 1 0]);
     hold on
     a9=surf(x_b3,y_b3,z_b3,'FaceColor',[1 1 0]);
     
     plot3(a1_x,a1_y,a1_z,'xr');
     hold on
     plot3(a2_x,a2_y,a2_z,'xr');
     hold on
     plot3(a3_x,a3_y,a3_z,'xr');
     %view(0,90);
    axis('equal');
    axis([-0.5 1.5 -0.5 1.5 0 2]);
    xlabel('x (meter)');
    ylabel('y (meter)');
    zlabel('z (meter)');
%     plot3(q_x,q_y,q_z,'ro');
%     plot3(q_w1(1),q_w1(2),0,'ro');
%     plot3(q_w2(1),q_w2(2),0,'ro');
%     plot3(q_w3(1),q_w3(2),0,'ro');
    input = A.q(4:7,i);
    output = quater2rotate(input);
    direction = output(2:4);
    theta = output(1);
    
    rotate(a1,direction,(theta/pi)*180,[q_w1(1),q_w1(2),q_w1(3)]);
    rotate(a2,direction,(theta/pi)*180,[q_w2(1),q_w2(2),q_w2(3)]);
    rotate(a3,direction,(theta/pi)*180,[q_w3(1),q_w3(2),q_w3(3)]);
    
    rotate(a4,direction,(theta/pi)*180,[q_x,q_y,q_z]);
    
    rotate(a5,direction,(theta/pi)*180,[q_wt(1),q_wt(2),q_wt(3)]);
    rotate(a6,direction,(theta/pi)*180,[q_wb(1),q_wb(2),q_wb(3)]);
    
    rotate(a7,direction,(theta/pi)*180,[q_wb1(1),q_wb1(2),q_wb1(3)]);
    rotate(a8,direction,(theta/pi)*180,[q_wb2(1),q_wb2(2),q_wb2(3)]);
    rotate(a9,direction,(theta/pi)*180,[q_wb3(1),q_wb3(2),q_wb3(3)]);
    
    hold off
    frame = getframe(gcf);
    writeVideo(v,frame);
    end
else
      
end
close(v);
end





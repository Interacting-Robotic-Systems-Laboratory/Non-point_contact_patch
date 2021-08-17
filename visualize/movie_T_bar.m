function  movie_T_bar(A)
N = A.N;

% dimension of the T bar
% len = 20 cm;
% wid = 5 cm;
% heg = 5 cm;
% d_cm = 7 cm;
% ECP
a_x =A.z(7,:);
a_y =A.z(8,:);
a_z = A.z(9,:);
% surface 1 in body frame (bottom)
ratio = 1;
[X11,Y11] = meshgrid(0.02:0.05:0.07,-0.1:0.2:0.1);
[X12,Y12] = meshgrid(-0.13:0.15:0.02,-0.025:0.05:0.025);

Z11  =Y11.*0 - X11.*0 - 0.05/2;
Z12  =Y12.*0 - X12.*0 - 0.05/2;

 % surface 2 in body frame (top)

[X21,Y21] = meshgrid(0.02:0.05:0.07,-0.1:0.2:0.1);
[X22,Y22] = meshgrid(-0.13:0.15:0.02,-0.025:0.05:0.025);

Z21  =Y21.*0 - X21.*0 + 0.05/2;
Z22  =Y22.*0 - X22.*0 +0.05/2;

% surface 3 in body frame 
[Y3,Z3] = meshgrid(-0.1:0.2:0.1,-0.025:0.05:0.025);
X3 = Y3.*0 - Z3.*0 + 0.07;

% surface 4 in body frame
[Y4,Z4] = meshgrid(-0.025:0.05:0.025,-0.025:0.05:0.025);
X4 = Y4.*0 - Z4.*0 - 0.13;

% surface 5 in body frame
[X5,Z5] = meshgrid(0.02:0.05:0.07,-0.025:0.05:0.025);
Y5 = X5.*0 - Z5.*0 - 0.1;

% surface 6 in body frame
[X6,Z6] = meshgrid(0.02:0.05:0.07,-0.025:0.05:0.025);
Y6 = X6.*0 - Z6.*0 + 0.1;

% surface 7 in body frame
[X7,Z7] = meshgrid(-0.13:0.15:0.02,-0.025:0.05:0.025);
Y7 = X7.*0 - Z7.*0 - 0.025;

% surface 8 in body frame
[X8,Z8] = meshgrid(-0.13:0.15:0.02,-0.025:0.05:0.025);
Y8 = X8.*0 - Z8.*0 + 0.025;

% surface 9 in body frame
[Y9,Z9] = meshgrid(-0.1:0.2:0.1,-0.025:0.05:0.025);
X9 = Y9.*0 - Z9.*0 + 0.02;

% plane 
[X,Y] = meshgrid(-0.6:1.2:0.6,-0.6:1.2:0.6);
Z = X.*0+Y.*0;

    set(gca,'nextplot','replacechildren'); 
    v = VideoWriter('test.avi');
    open(v);
    for i = 1:2:N
    q0 = A.q(4,i);
    q1 = A.q(5,i);
    q2 = A.q(6,i);
    q3 = A.q(7,i);
    
    q_x = A.q(1,i);
    q_y = A.q(2,i);
    q_z = A.q(3,i);
    
    
    
    E = [-q1 q0 -q3 q2;
     -q2 q3 q0 -q1;
     -q3 -q2 q1 q0];

    G = [-q1 q0 q3 -q2;
         -q2 -q3 q0 q1;
         -q3 q2 -q1 q0];
 
    R = E*G';
    
    H = [R,[q_x;q_y;q_z];zeros(1,3),1];

    [Q11_x,Q11_y,Q11_z] = transform_points( H,X11,Y11,Z11);
    [Q12_x,Q12_y,Q12_z] = transform_points( H,X12,Y12,Z12);
    [Q21_x,Q21_y,Q21_z] = transform_points( H,X21,Y21,Z21);
    [Q22_x,Q22_y,Q22_z] = transform_points( H,X22,Y22,Z22);
    [Q3_x,Q3_y,Q3_z] = transform_points( H,X3,Y3,Z3);
    [Q4_x,Q4_y,Q4_z] = transform_points( H,X4,Y4,Z4);
    [Q5_x,Q5_y,Q5_z] = transform_points( H,X5,Y5,Z5);
    [Q6_x,Q6_y,Q6_z] = transform_points( H,X6,Y6,Z6);
    [Q7_x,Q7_y,Q7_z] = transform_points( H,X7,Y7,Z7);
    [Q8_x,Q8_y,Q8_z] = transform_points( H,X8,Y8,Z8);
    [Q9_x,Q9_y,Q9_z] = transform_points( H,X9,Y9,Z9);

     %view(0,90);
    axis equal;
    axis([-20 10 -15 15 0 30]/100);

    % surface 1
    surf(Q11_x,Q11_y,Q11_z,'FaceColor',[1 1 0],'Linestyle','-');  
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q12_x,Q12_y,Q12_z,'FaceColor',[1 1 0],'Linestyle','-'); 
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    % surface 2
    hold on
    surf(Q21_x,Q21_y,Q21_z,'FaceColor',[1 0 0],'Linestyle','-');  
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q22_x,Q22_y,Q22_z,'FaceColor',[1 0 0],'Linestyle','-'); 
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q3_x,Q3_y,Q3_z,'FaceColor',[1 1 0],'Linestyle','-'); 
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q4_x,Q4_y,Q4_z,'FaceColor',[1 1 0],'Linestyle','-'); 
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q5_x,Q5_y,Q5_z,'FaceColor',[1 1 0],'Linestyle','-'); 
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q6_x,Q6_y,Q6_z,'FaceColor',[1 1 0],'Linestyle','-'); 
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q7_x,Q7_y,Q7_z,'FaceColor',[1 1 0],'Linestyle','-');
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q8_x,Q8_y,Q8_z,'FaceColor',[1 1 0],'Linestyle','-'); 
    axis equal; 
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    surf(Q9_x,Q9_y,Q9_z,'FaceColor',[1 1 0],'Linestyle','-'); 
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on
    
    % frame
%     xr = -0.3;
%     yr = -0.1;
%     L = 0.15;
%     p1 = [xr,yr,0;xr,yr,0;xr,yr,0];
%     p2 = [xr+L,yr,0;xr,yr+L,0;xr,yr,L];
%     arrow3(p1,p2,'k1.5');
%     axis equal;
%     axis(ratio*[-20 10 -15 15 0 15]/100);
%     hold on
    % applied force and torque
   
    
    
    
%     r = L/3;
%     
%     if i<= 15
%         
%         th = -pi:pi/50:pi;
%         zr = 0;
%         
%         yunit = r*cos(th) + yr;
%         zunit = r*sin(th) + zr;
%         xunit = 0*sin(th) + xr+L/3;
%         p = plot3(xunit,yunit,zunit,'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p =  plot3([xr+L/3,xr+L/3],[yr-r-r/6,yr-r],[zr+r/1.6,zr],'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p =  plot3([xr+L/3,xr+L/3],[yr-r+r/2,yr-r],[zr+r/3,zr],'r');
%         set(p,'LineWidth',1.5);
%         
%         axis equal;
%         axis(ratio*[-20 10 -15 15 0 15]/100);
%         hold on
%     elseif (i>=16)&&(i<=20)
%         th = -pi:pi/50:pi;
%         zr = 0;
%         
%         xunit = r*cos(th) + xr;
%         zunit = r*sin(th) + zr;
%         yunit = 0*sin(th) + yr+L/3;
%         p = plot3(xunit,yunit,zunit,'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p = plot3([xr+r+r/6,xr+r],[yr+L/3,yr+L/3],[zr+r/1.6,zr],'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p = plot3([xr+r-r/6,xr+r],[yr+L/3,yr+L/3],[zr+r/1.6,zr],'r');
%         set(p,'LineWidth',1.5);
%         
%         axis equal;
%         axis(ratio*[-20 10 -15 15 0 15]/100);
%         hold on
%     elseif (i>=151)&&(i<=165)
%         th = -pi:pi/50:pi;
%         zr = 0;
%         
%         yunit = r*cos(th) + yr;
%         zunit = r*sin(th) + zr;
%         xunit = 0*sin(th) + xr+L/3;
%         p = plot3(xunit,yunit,zunit,'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p =  plot3([xr+L/3,xr+L/3],[yr+r-r/3,yr+r],[zr+r/1.6,zr],'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p =  plot3([xr+L/3,xr+L/3],[yr+r+r/6,yr+r],[zr+r/3,zr],'r');
%         set(p,'LineWidth',1.5);
%         
%         axis equal;
%         axis(ratio*[-20 10 -15 15 0 15]/100);
%         hold on
%     elseif (i>=166)&&(i<=170)
%         th = -pi:pi/50:pi;
%         zr = 0;
%         
%         xunit = r*cos(th) + xr;
%         zunit = r*sin(th) + zr;
%         yunit = 0*sin(th) + yr+L/3;
%         p = plot3(xunit,yunit,zunit,'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p = plot3([xr+r+r/6,xr+r],[yr+L/3,yr+L/3],[zr+r/1.6,zr],'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p = plot3([xr+r-r/6,xr+r],[yr+L/3,yr+L/3],[zr+r/1.6,zr],'r');
%         set(p,'LineWidth',1.5);
%         
%         axis equal;
%         axis(ratio*[-20 10 -15 15 0 15]/100);
%         hold on
%         
%     elseif (i>=300)&&(i<=500)
%         th = -pi*3/2:pi/50:0;
%         p1 = [xr,yr,0];
%         theta = atan(cos(2*pi*i*0.01)/sin(2*pi*i*0.01));
%         vf = L*[cos(theta),sin(theta),0];
%         p2 = p1 + vf;
%         arrow3(p1,p2,'r1.5');
%         hold on
%         
%         zr = L/3;
%         xunit = r*cos(th) + xr;
%         yunit = r*sin(th) + yr;
%         zunit = 0*sin(th) + zr;
%         p = plot3(xunit,yunit,zunit,'r');
%         set(p,'LineWidth',1.5);
%         hold on
%         p =  plot3([xr+r+r/12,xr+r],[yr-r/1.6,yr],[zr,zr],'r');
%         set(p,'LineWidth',1.5);
%         hold on 
%         p =  plot3([xr+r-r/3,xr+r],[yr-r/2,yr],[zr,zr],'r');
%         set(p,'LineWidth',1.5);
% 
%         axis equal;
%         axis(ratio*[-20 10 -15 15 0 15]/100);
%         hold on
%         
%     else
%     end
%         
        

    % ground
    surf(X,Y,Z,'FaceColor',[0 1 0],'Linestyle','none'); 
    axis equal;
    axis(ratio*[-20 10 -15 15 0 15]/100);
    hold on 
    
    plot3(a_x(i),a_y(i),a_z(i),'x');
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m)');    
    hold off
    frame = getframe(gcf);
    writeVideo(v,frame);
        
    pause(0.01);
    
    end

   close(v);   
end







function  movie_desk(A)
N = A.N;

% ECP
a_x =A.z(7,:);
a_y =A.z(8,:);
a_z = A.z(9,:);

ratio = 1;

% plane 
[X,Y] = meshgrid(-0.5:2.5:2,-0.5:2.5:2);
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

    % A desk can be defined by 5 cuboids (desk and 4 feets)
    [X1,Y1,Z1] = mashgrid_cuboid(0.5,0.5,0.05,H,[0;0;0.025]);
    
    [X2,Y2,Z2] = mashgrid_cuboid(0.06,0.06,0.45,H,[-0.22;0.22;-0.45/2]);
    
    [X3,Y3,Z3] = mashgrid_cuboid(0.06,0.06,0.45,H,[0.22;0.22;-0.45/2]);
    
    [X4,Y4,Z4] = mashgrid_cuboid(0.06,0.06,0.45,H,[0.22;-0.22;-0.45/2]);
    
    [X5,Y5,Z5] = mashgrid_cuboid(0.06,0.06,0.45,H,[-0.22;-0.22;-0.45/2]);
    
    % robot hand in right can be defined by 4 cuboid
    [X1R,Y1R,Z1R] = mashgrid_cuboid(0.04,0.02,0.1,H,[-0.26;-0.18;0.025]);
    [X2R,Y2R,Z2R] = mashgrid_cuboid(0.04,0.08,0.02,H,[-0.3;-0.18;0.085]);
    [X3R,Y3R,Z3R] = mashgrid_cuboid(0.04,0.08,0.02,H,[-0.3;-0.18;-0.035]);
    [X4R,Y4R,Z4R] = mashgrid_cuboid(0.04,0.02,0.14,H,[-0.34;-0.18;0.025]);
     %view(0,90);
    axis equal;
    %axis([-20 10 -15 15 0 30]);
    xlabel('x (cm)');
    ylabel('y (cm)');
    zlabel('z (cm)');

    % Cuboid 1
    surf(X1,Y1,Z1,'FaceColor',[1 1 0],'Linestyle','-');  
    axis equal;
    axis(ratio*[-0.5 2 -0.5 2 0 1]);
    hold on
    
     % Cuboid 2
    surf(X2,Y2,Z2,'FaceColor',[1 1 0],'Linestyle','-');  
    axis equal;
    axis(ratio*[-0.5 2 -0.5 2 0 1]);
    hold on
    
    % Cuboid 3
    surf(X3,Y3,Z3,'FaceColor',[1 1 0],'Linestyle','-');  
    axis equal;
    axis(ratio*[-0.5 2 -0.5 2 0 1]);
    hold on
    
    % Cuboid 4
    surf(X4,Y4,Z4,'FaceColor',[1 1 0],'Linestyle','-');  
    axis equal;
    axis(ratio*[-0.5 2 -0.5 2 0 1]);
    hold on
    
    % Cuboid 5
    surf(X5,Y5,Z5,'FaceColor',[1 1 0],'Linestyle','-');  
    axis equal;
    axis(ratio*[-0.5 2 -0.5 2 0 1]);
    hold on
    
    % robot hand 
%     surf(X1R,Y1R,Z1R,'FaceColor',[1 0 1],'Linestyle','-');  
%     surf(X2R,Y2R,Z2R,'FaceColor',[0 1 0],'Linestyle','-'); 
%     surf(X3R,Y3R,Z3R,'FaceColor',[0 1 0],'Linestyle','-'); 
%     surf(X4R,Y4R,Z4R,'FaceColor',[0 1 0],'Linestyle','-'); 

    % frame
    xr = 1;
    yr = 0;
    L = 0.4;
    p1 = [xr,yr,0;xr,yr,0;xr,yr,0];
    p2 = [xr+L,yr,0;xr,yr+L,0;xr,yr,L];
    arrow3(p1,p2,'k1.5');
    axis equal;
    axis(ratio*[-1.1 1.4 -0.3 3 0 0.5]);
    hold on
    % applied force and torque
   
    
    
    
    r = L/3;
    
    if i<= 40
        th = -pi:pi/50:pi;
        zr = 0;
        
        yunit = r*cos(th) + yr;
        zunit = r*sin(th) + zr;
        xunit = 0*sin(th) + xr+0.3;
        p = plot3(xunit,yunit,zunit,'r');
        set(p,'LineWidth',1.5);
        hold on
        p =  plot3([xr+0.3,xr+0.3],[yr-r-r/6,yr-r],[zr+r/1.6,zr],'r');
        set(p,'LineWidth',1.5);
        hold on
        p =  plot3([xr+0.3,xr+0.3],[yr-r+r/2,yr-r],[zr+r/3,zr],'r');
        set(p,'LineWidth',1.5);
        
        axis equal;
        axis(ratio*[-0.5 2 -0.5 2 0 1]);
        hold on
    elseif (i>=101)&&(i<=500)
        th = -pi*3/2:pi/50:0;
        p1 = [xr,yr,0];
        theta = atan((cos(2*pi*i*0.01)+1)/(sin(2*pi*i*0.01)+1));
        vf = L*[cos(theta),sin(theta),0];
        p2 = p1 + vf;
        arrow3(p1,p2,'r1.5');
        hold on
        if cos(2*pi*i*0.01)>=0
            zr = 0.3;
            xunit = r*cos(th) + xr;
            yunit = r*sin(th) + yr;
            zunit = 0*sin(th) + zr;
            p = plot3(xunit,yunit,zunit,'r');
            set(p,'LineWidth',1.5);
            hold on
            p =  plot3([xr+r+r/12,xr+r],[yr-r/1.6,yr],[zr,zr],'r');
            set(p,'LineWidth',1.5);
            hold on 
            p =  plot3([xr+r-r/3,xr+r],[yr-r/2,yr],[zr,zr],'r');
            set(p,'LineWidth',1.5);

            axis equal;
            axis(ratio*[-0.5 2 -0.5 2 0 1]);
            hold on
        else
            zr = 0.3;
            xunit = r*cos(th) + xr;
            yunit = r*sin(th) + yr;
            zunit = 0*sin(th) + zr;
            p = plot3(xunit,yunit,zunit,'r');
            set(p,'LineWidth',1.5);
            hold on
            p =  plot3([xr-r/2,xr],[yr+r+r/4,yr+r],[zr,zr],'r');
            set(p,'LineWidth',1.5);
            hold on 
            p =  plot3([xr-r/3,xr],[yr+r-r/3,yr+r],[zr,zr],'r');
            set(p,'LineWidth',1.5);

            axis equal;
            axis(ratio*[-0.5 2 -0.5 2 0 1]);
            hold on
        
        
        end
        
        
    else
    end
        
        

    

    
    % ground
     surf(X,Y,Z,'FaceColor',[0 1 0],'Linestyle','-');  
     hold on
     plot3(a_x(i),a_y(i),a_z(i),'rx');
     axis equal;
     axis(ratio*[-0.5 2 -0.5 2 0 1]);
    
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







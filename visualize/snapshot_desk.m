function snapshot_desk(A)

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
% the corner in body frame 
a1 = [0.25,0.25,1];


a2 =[ 0.25, -0.25,1];

a3 = [-0.25,-0.25,1];

a4 = [-0.25,0.25,1];
% small squares in body frame
a12 = [0.25,0.19,1];
a13 = [0.19,0.19,1];
a14 = [0.19,0.25,1];

a21 = [0.25,-0.19,1];
a23 = [0.19,-0.25,1];
a24 = [0.19,-0.19,1];

a31 = [-0.19,-0.19,1];
a32 = [-0.19,-0.25,1];
a34 = [-0.25,-0.19,1];

a41 = [-0.19,0.25,1];
a42 = [-0.19,0.19,1];
a43 = [-0.25,0.19,1];

Con = [a1',a2',a3',a4',a1',a1',a12',a13',a14',a1',a21',a2',a23',a24',a21',a31',a32',a3',a34',a31',a41',a42',a43',a4',a41'];

%     set(gca,'nextplot','replacechildren'); 
%     v = VideoWriter('test.avi');
%    open(v);
    for i = 1:40:N
    q0 = A.q(4,i);
    q1 = A.q(5,i);
    q2 = A.q(6,i);
    q3 = A.q(7,i);
    
    q_x = A.q(1,i);
    q_y = A.q(2,i);
    
    
    
    
    E = [-q1 q0 -q3 q2;
     -q2 q3 q0 -q1;
     -q3 -q2 q1 q0];

    G = [-q1 q0 q3 -q2;
         -q2 -q3 q0 q1;
         -q3 q2 -q1 q0];
 
    R = E*G';
    
    H = [R(1:2,1:2),[q_x;q_y];zeros(1,2),1];

    New_Con = H*Con;


     %view(0,90);
    axis equal;
    %axis([-20 10 -15 15 0 30]);
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m)');

    for p = 1:5
        for j = 1:4
            P = [New_Con(1:2,j+5*(p-1)),New_Con(1:2,j+1+5*(p-1))];
            if p == 1
                plot(P(1,:),P(2,:),'r');
            else
                plot(P(1,:),P(2,:),'k');
            end
            axis equal;
            hold on
        end
        
    end
   
    plot(a_x(i),a_y(i),'rx');
        
    hold on
%     frame = getframe(gcf);b
%     writeVideo(v,frame);
    
    
    end

%   close(v);   








end
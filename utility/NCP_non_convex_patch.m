function A = NCP_non_convex_patch(A)
unit = A.unit;
N = A.N;

global e_t e_o e_r mu;

e_t = A.ellipsoid(1);
e_o = A.ellipsoid(2);
e_r = A.ellipsoid(3)*unit;
mu =A.cof;



global m g;
m = A.mass;
g = A.gravity*unit;

global len wid heg  I_xx I_yy I_zz Height;

len = A.dim(1)*unit;  % in fixed body frame's x direction
wid = A.dim(2)*unit;  % in fixed body frame's y direction
heg = A.dim(3)*unit;  % in fixed body frame's z direction

I_xx = (m/12)*(wid^2+heg^2);
I_yy = (m/12)*(heg^2+len^2);
I_zz = (m/12)*(wid^2+len^2);

Height = A.dim(3)*unit/2;



global h;
h =A.h;

% applied wrenches
P_x = A.Impulses(:,1);
P_y = A.Impulses(:,2);
P_z = A.Impulses(:,3);
P_xt = A.Impulses(:,4);
P_yt = A.Impulses(:,5);
P_zt = A.Impulses(:,6);

global p_x p_y p_z p_xt p_yt p_zt;


%% initial configuration and state
% q_old - position and orientation vector at l, q_old=[q_xo;q_yo;q_zo;q0_o;q1_o;q2_o;q3_o]
global q_old;

q_old(1:3,1) = A.initial_q(1:3)*unit;
q_old(4:7,1) = A.initial_q(4:7);
% nu_old - generalized velocity vector at l, nu_old=[v_xo;v_yo;v_zo;w_xo;w_yo;w_zo]
global nu_old;

nu_old(1:3,1) = A.initial_v(1:3)*unit;
nu_old(4:6,1) = A.initial_v(4:6); 


%% define the infinity and initial guess and fun to use
 A = initial_guess(A);
 l = A.l;
 u = A.u;
 Z = A.Z;
 
 fun = A.fun;
 Q = q_old;
for i=1:N
    p_x = P_x(i);
    p_y = P_y(i);
    p_z = P_z(i);
    p_xt = P_xt(i);
    p_yt = P_yt(i);
    p_zt = P_zt(i);
    tic;
    [A.z(:,i),f,J,Mu,status] = pathmcp(Z,l,u,fun);
    time_NCP = toc;
    if status == 1 
        A.time_NCP(i) = time_NCP;
    else
        A.time_NCP(i) = 0;
    end
    j = 1;
    if i == 1
        while status == 0
        j = j+1;
        Z = change_initial_guess(A,Z,Q);
        tic
        [A.z(:,i),f,J,Mu,status] = pathmcp(Z,l,u,fun);
        time_NCP = toc;
        if status == 1 
            A.time_NCP(i) = time_NCP;
        else
            A.time_NCP(i) = 0;
        end
            if j>=30
                error('Path can not found the solution, change your initial guess');
            end
        end
        
    else
        while status == 0
            j = j+1;
            Z = change_guess(A,Z,Q);
            tic
            [A.z(:,i),f,J,Mu,status] = pathmcp(Z,l,u,fun);
            time_NCP = toc;
            if status == 1 
                A.time_NCP(i) = time_NCP;
            else
                A.time_NCP(i) = 0;
            end
            if j>=30
                error('Path can not found the solution, change your initial guess');
            end
        end
    end
    
   

   [Q,Nu] = kinematic_map(q_old,A.z(:,i,index),h); % the function which returns the state vectors
   
   Z = A.z(:,i); % updating the initial guess for each iteration
   A.q(:,i) = Q; 
   
   q_old = Q; % updating the beginning value for next time step
   nu_old = Nu; 
   
   
end

end
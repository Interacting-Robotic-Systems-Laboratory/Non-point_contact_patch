function A = initial_guess(A)

%% all the initial guess depends on the 1)planar sliding 2)initial oritentation with zero rotation about normal axis
unit = A.unit;
infty = 1e20;
 
e_t = A.ellipsoid(1);
e_o = A.ellipsoid(2);
e_r = A.ellipsoid(3)*unit;
mu =A.cof;

m = A.mass;
g = A.gravity*unit;
h = A.h;

R = rand;
nu = A.initial_v; 
nu(1:3) = nu(1:3)*unit;
v_x = nu(1);
v_y = nu(2);
w_x = nu(4);
w_y = nu(5);
w_z = nu(6);

q_x = A.initial_q(1)*unit;
q_y = A.initial_q(2)*unit;
q_z = A.initial_q(3)*unit;
a_z = q_z;
if A.object == "Table"
    
    A.l(1:15,1) = -infty;
    A.l(16:24,1) = 0;
    A.u(1:24,1) = infty;
     
    ECP = [q_x;q_y;a_z;q_x;q_y;a_z];
    
    v_t = v_x - w_z*(ECP(2) - q_y) + w_y*(ECP(3) - q_z);
    v_o = v_y + w_z*(ECP(1) - q_x) - w_x*(ECP(3) - q_z);
    v_r = w_z;
    
    sig = sqrt(e_t^2*v_t^2 + e_o^2*v_o^2 + e_r^2*v_r^2);
    p_n = R*m*g*h;
    if sig == 0
        p_t = 0;
        p_o = 0;
        p_r = 0;
    else
        p_t = -e_t^2*mu*p_n*v_t/sig;
        p_o = -e_o^2*mu*p_n*v_o/sig;
        p_r = -e_r^2*mu*p_n*v_r/sig;
    end
    
    
    
    
    Con_wrench = [p_t;p_o;p_r];
    
    La =[0;0;0;0;1;0;0]; %% assuming planar contact
    
    A.Z = [nu;ECP;Con_wrench;sig;La;p_n]; 
    
    A.fun = 'mcp_funjac_single_convex_contact_patch_cuboid';
elseif A.object == "T_bar"
    A.l(1:15,1) = -infty;
    A.l(16:26,1) = 0;
    A.u(1:26,1) = infty;
     
    ECP = [q_x;q_y;a_z;q_x;q_y;a_z];
    
    v_t = v_x - w_z*(ECP(2) - q_y) + w_y*(ECP(3) - q_z);
    v_o = v_y + w_z*(ECP(1) - q_x) - w_x*(ECP(3) - q_z);
    v_r = w_z;
    
    sig = sqrt(e_t^2*v_t^2 + e_o^2*v_o^2 + e_r^2*v_r^2);
    p_n = R*m*g*h;
    if sig == 0
        p_t = 0;
        p_o = 0;
        p_r = 0;
    else
        p_t = -e_t^2*mu*p_n*v_t/sig;
        p_o = -e_o^2*mu*p_n*v_o/sig;
        p_r = -e_r^2*mu*p_n*v_r/sig;
    end
    
    
    
    
    Con_wrench = [p_t;p_o;p_r];
    
    La =[1;0;0;0;0;0;0;0;0]; %% assuming planar contact
    
    A.Z = [nu;ECP;Con_wrench;sig;La;p_n]; 
    
    A.fun = 'mcp_funjac_convex_hull_T_bar';

end

end
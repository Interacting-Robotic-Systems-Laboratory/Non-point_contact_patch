clear all
syms h real; % time step h
syms g real;

syms v_x v_y v_z w_x w_y w_z real;
nu =[v_x;v_y;v_z;w_x;w_y;w_z];

syms v_xo v_yo v_zo w_xo w_yo w_zo real;
nu_old = [v_xo;v_yo;v_zo;w_xo;w_yo;w_zo];

V_old = nu_old(1:3);
V = nu(1:3);
W_old = nu_old(4:6);
W = nu(4:6);


syms q_xo q_yo q_zo q0_o q1_o q2_o q3_o real;
q_old = [q_xo;q_yo;q_zo;q0_o;q1_o;q2_o;q3_o];
q(1:3,:) = q_old(1:3) + h*V;

syms q_x q_y q_z real;
q(1:3,:) = [q_x;q_y;q_z];

q0 = q_old(4);
q1 = q_old(5);
q2 = q_old(6);
q3 = q_old(7);

E = [-q1 q0 -q3 q2;
     -q2 q3 q0 -q1;
     -q3 -q2 q1 q0];
 
q_term = q_old(4:7)+h*0.5*E'*W;
norm_q = (q_term(1)^2+q_term(2)^2+q_term(3)^2+q_term(4)^2)^(1/2);
norm_q = simplify(norm_q);
norm_q = subs(norm_q,q0_o^2+q1_o^2+q2_o^2+q3_o^2,1);
%norm_q = (h^2*w_x^2 + h^2*w_y^2 + h^2*w_z^2 + 4)^(1/2)/2;
q(4) = q_term(1)/norm_q;
q(5) = q_term(2)/norm_q;
q(6) = q_term(3)/norm_q;
q(7) = q_term(4)/norm_q;

q0 = q(4);
q1 = q(5);
q2 = q(6);
q3 = q(7);
syms q0 q1 q2 q3 real;

 syms R11 R12 R13 R21 R22 R23 R31 R32 R33 real;

 R = [R11 R12 R13;R21 R22 R23;R31 R32 R33];
syms p_x p_y p_z p_xt p_yt p_zt real;
P_app = [p_x;p_y;p_z;p_xt;p_yt;p_zt];

syms m real;  %mass
syms I_xx I_yy I_zz real;
M = [m,0,0;0,m,0;0,0,m];
I = [I_xx,0,0;0,I_yy,0;0,0,I_zz];

syms I11 I12 I13 I21 I22 I23 I31 I32 I33 real;
Tensor_I = [I11 I12 I13;I21 I22 I23;I31 I32 I33];
%Tensor_I = R*I*R';
%% contact force 
syms p_t p_o p_r p_n real;

syms a1_x a1_y a1_z a2_x a2_y a2_z real

a1 = [a1_x;a1_y;a1_z];
a2 = [a2_x;a2_y;a2_z];

r = a1-q(1:3);

n = [0;0;1];
t = [1;0;0];
o = [0;1;0];

W_n(1:3,:) = sym(n);
W_n(4:6,:) = cross(r,n);

W_t(1:3,:) = sym(t);
W_t(4:6,:) = cross(r,t);

W_o(1:3,:) = sym(o);
W_o(4:6,:) = cross(r,o);

W_r(1:3,:) =  sym(0*n);
W_r(4:6,:) = sym(n);

P_cont = W_n*p_n+W_t*p_t+W_o*p_o+W_r*p_r;


%% Dynamic equations
LHS(1:3,:)=M*(V-V_old)+[0;0;m*g*h];
LHS(4:6,:)=Tensor_I*(W-W_old)+h*cross(W_old,Tensor_I*W_old);

RHS=P_cont + P_app;
DYM = RHS - LHS;

%% friction model
syms mu real;
syms e_t e_o e_r real;
syms sig real;
P_friction(1,1)=mu*e_t^2*p_n*W_t'*nu+p_t*sig;
P_friction(2,1)=mu*e_o^2*p_n*W_o'*nu+p_o*sig;
P_friction(3,1)=mu*e_r^2*p_n*W_r'*nu+p_r*sig;

P_friction(4,1) = (mu*p_n)^2-(p_t/e_t)^2-(p_o/e_o)^2-(p_r/e_r)^2;
%% contact constraints for the plane
syms x y z real;
gcn = z;
%% contact constraints for Convex hull of T bar

syms len wid heg d_cm real; % dimension of the T bar
 
len = 0.2;
wid = 0.05;
heg = 0.05;
d_cm = 0.07;

syms l1 l2 l3 l4 l5 l6 l7 l8 l9 real; % lagrangue multiplier
L = [l1;l2;l3;l4;l5;l6;l7;l8;l9];
 
H(1:3,1:3) = R;
H(1:3,4) = q(1:3);
H(4,1:3)=0;
H(4,4) = 1;

P_w = [x;y;z;1];

H_i(1:3,1:3) = R';
H_i(1:3,4) = -R'*q(1:3);
H_i(4,1:3)=0;
H_i(4,4) = 1;
P_b = H_i*P_w;

% equation of constraints
f_1 = -z-heg/2;
f_2 =  z-heg/2;

f_3 = x-d_cm; 
f_4 =  -x-(len-d_cm);

f_5 = -y-len/2;
f_6 =  y-len/2;

% a = ((len-wid)/2)/sqrt(((len-wid)/2)^2 + (len-wid)^2);
% b = (len-wid)/sqrt(((len-wid)/2)^2 + (len-wid)^2);

a = 1/sqrt(5);
b = 2/sqrt(5);

x7 = d_cm - wid;
y7 = -len/2;

x8 = d_cm - wid;
y8 = len/2;
f_7 = -a*(x-x7)-b*(y-y7);
f_8 = -a*(x-x8)+b*(y-y8);

Fcn = [f_1;f_2;f_3;f_4;f_5;f_6;f_7;f_8];
Fcn = subs(Fcn,[x y z],[P_b(1) P_b(2) P_b(3)]);

sum_grad_a1 = 0;
for i = 1:8
    grad_a1(:,:,i) = gradient(Fcn(i),[x,y,z]);
    grad_a1(:,:,i) = subs(grad_a1(:,:,i),{x,y,z},{a1_x,a1_y,a1_z});
    sum_grad_a1 = sum_grad_a1 +L(i)*grad_a1(:,:,i);
end
sum_grad_a1 = simplify(sum_grad_a1);

grad_a2 = [0;0;1];


DST(1:3,1)=(a2-a1)+l9*(grad_a2);
DST(4:6,1)=grad_a2+sum_grad_a1;
DST(7:14,1) = -subs(Fcn,{x,y,z},{a1_x,a1_y,a1_z});
DST(15,1) = -subs(gcn,{x,y,z},{a2_x,a2_y,a2_z});  
DST(16,1) = subs(gcn,{x,y,z},{a1_x,a1_y,a1_z});

DST = simplify(DST);
fcn = [DYM;P_friction(1:3);DST(1:6);P_friction(4);DST(7:16)];
fcn = simplify(fcn);

Z(1,1:6) = [v_x v_y v_z w_x w_y w_z];
Z(1,7:12) = [a1_x a1_y a1_z a2_x a2_y a2_z];
Z(1,13:15) = [p_t p_o p_r];
Z(1,16) = sig;
Z(1,17:25) = [l1 l2 l3 l4 l5 l6 l7 l8 l9];
Z(1,26) = p_n;

U(1,1:26) = Z;
U(1,27:30) = [q0 q1 q2 q3];

T(1,1:26) = Z;
T(1,27:35) = [R11 R12 R13 R21 R22 R23 R31 R32 R33];
T(1,36:44) = [I11 I12 I13 I21 I22 I23 I31 I32 I33];
T(1,45:47) = [q_x q_y q_z];
J1 = jacobian(fcn',T);

J1 = simplify(J1);

T = subs(T,[R11 R12 R13 R21 R22 R23 R31 R32 R33 q_x q_y q_z],[q0^2 + q1^2 - q2^2 - q3^2, 2*q1*q2 - 2*q0*q3,2*q0*q2 + 2*q1*q3,2*q0*q3 + 2*q1*q2,q0^2 - q1^2 + q2^2 - q3^2,2*q2*q3 - 2*q0*q1,2*q1*q3 - 2*q0*q2,2*q0*q1 + 2*q2*q3,q0^2 - q1^2 - q2^2 + q3^2,q_xo+h*v_x,q_yo+h*v_y,q_zo+h*v_z]);
T = subs(T,I11,(I_xx*(q0^2 + q1^2 - q2^2 - q3^2)^2 + I_yy*(2*q0*q3 - 2*q1*q2)^2 + I_zz*(2*q0*q2 + 2*q1*q3)^2));
T = subs(T,I12,(I_xx*(2*q0*q3 + 2*q1*q2)*(q0^2 + q1^2 - q2^2 - q3^2) - I_zz*(2*q0*q1 - 2*q2*q3)*(2*q0*q2 + 2*q1*q3) - I_yy*(2*q0*q3 - 2*q1*q2)*(q0^2 - q1^2 + q2^2 - q3^2)));
T = subs(T,I13,I_zz*(2*q0*q2 + 2*q1*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - I_xx*(2*q0*q2 - 2*q1*q3)*(q0^2 + q1^2 - q2^2 - q3^2) - I_yy*(2*q0*q1 + 2*q2*q3)*(2*q0*q3 - 2*q1*q2));
T = subs(T,I21,I_xx*(2*q0*q3 + 2*q1*q2)*(q0^2 + q1^2 - q2^2 - q3^2) - I_zz*(2*q0*q1 - 2*q2*q3)*(2*q0*q2 + 2*q1*q3) - I_yy*(2*q0*q3 - 2*q1*q2)*(q0^2 - q1^2 + q2^2 - q3^2));
T = subs(T,I22,I_yy*(q0^2 - q1^2 + q2^2 - q3^2)^2 + I_xx*(2*q0*q3 + 2*q1*q2)^2 + I_zz*(2*q0*q1 - 2*q2*q3)^2);
T = subs(T,I23,I_yy*(2*q0*q1 + 2*q2*q3)*(q0^2 - q1^2 + q2^2 - q3^2) - I_xx*(2*q0*q2 - 2*q1*q3)*(2*q0*q3 + 2*q1*q2) - I_zz*(2*q0*q1 - 2*q2*q3)*(q0^2 - q1^2 - q2^2 + q3^2));
T = subs(T,I31,I_zz*(2*q0*q2 + 2*q1*q3)*(q0^2 - q1^2 - q2^2 + q3^2) - I_xx*(2*q0*q2 - 2*q1*q3)*(q0^2 + q1^2 - q2^2 - q3^2) - I_yy*(2*q0*q1 + 2*q2*q3)*(2*q0*q3 - 2*q1*q2));
T = subs(T,I32,I_yy*(2*q0*q1 + 2*q2*q3)*(q0^2 - q1^2 + q2^2 - q3^2) - I_xx*(2*q0*q2 - 2*q1*q3)*(2*q0*q3 + 2*q1*q2) - I_zz*(2*q0*q1 - 2*q2*q3)*(q0^2 - q1^2 - q2^2 + q3^2));
T = subs(T,I33,I_zz*(q0^2 - q1^2 - q2^2 + q3^2)^2 + I_xx*(2*q0*q2 - 2*q1*q3)^2 + I_yy*(2*q0*q1 + 2*q2*q3)^2);
J2 = jacobian(T,U);
J2 =simplify(J2);

U= subs(U,[q0 q1 q2 q3],[-(2*((h*q1_o*w_x)/2 - q0_o + (h*q2_o*w_y)/2 + (h*q3_o*w_z)/2))/(h^2*w_x^2 + h^2*w_y^2 + h^2*w_z^2 + 4)^(1/2),(2*(q1_o + (h*q0_o*w_x)/2 + (h*q3_o*w_y)/2 - (h*q2_o*w_z)/2))/(h^2*w_x^2 + h^2*w_y^2 + h^2*w_z^2 + 4)^(1/2),(2*(q2_o - (h*q3_o*w_x)/2 + (h*q0_o*w_y)/2 + (h*q1_o*w_z)/2))/(h^2*w_x^2 + h^2*w_y^2 + h^2*w_z^2 + 4)^(1/2),(2*(q3_o + (h*q2_o*w_x)/2 - (h*q1_o*w_y)/2 + (h*q0_o*w_z)/2))/(h^2*w_x^2 + h^2*w_y^2 + h^2*w_z^2 + 4)^(1/2)]);
J3 = jacobian(U,Z);
J3 =simplify(J3);
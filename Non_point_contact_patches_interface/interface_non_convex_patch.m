%% notation
% l - beginning of current time step
% l+1 - end of current time step
% If the error 'Jacobian has too many entries: update nnz in pathmcp.m'
% appears , you can modify the mod_N parameter in pathmcp.m file

clear all
cd('..');
addpath('Non_point_contact_patches_interface');
addpath('visualize');
addpath('funjac');
addpath('utility');
addpath('pathmexmaci64');

cd('Non_point_contact_patches_interface')
A = struct();
% object type "T_bar" or "Table"
A.object = "T_bar"; 

% mass of the object
A.mass = 2; %(kg)
A.gravity = 9.8; %(m/s^2)

% approximate dimension of the object 
A.dim=[0.5 0.5 0.5]; %(m) length width height

% the dimension of T bar is embeded in the function, len = 0.2m, wid =
% 0.05m, heg = 0.05m, d_cm = 0.07m
                                
                              
                                
% friction model

A.ellipsoid = [1 1 0.1]; % the choice of e_r (m) depends on the CM
A.cof = 0.22;

% time step
A.h = 0.03; %(s)

% initial state and configuration
A.initial_q = [0;0;0.025;1;0;0;0]; % m
A.initial_v = [0;0;0;0;0;0];  %m/s

% unit
A.unit = 1; % 1 - m, 10 - dm, 100 - cm, 1000 - mm  

% impulses
A = planner_T_bar(A);

%N - the number of iteration


A = NCP_non_convex_patch(A);

%movie_desk(A);
movie_T_bar(A);


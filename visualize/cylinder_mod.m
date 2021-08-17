function [x,y,z] = cylinder_mod( x0,r,h )
%cylinder
% x0 represent the position vector of cm of the cylinder
% r represents the redius and h represents the height
x_p = x0(1);
y_p = x0(2);
z_p = x0(3)-h/2;
[X,Y,Z] = cylinder(r,50);
x= X+x_p;
y =Y+y_p;
z=h*Z+z_p;


end
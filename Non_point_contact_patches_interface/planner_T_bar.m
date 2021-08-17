function A = planner_T_bar(A)
N = 30;
A.N =N;
A.Impulses = zeros(N,6);



for i = 1:15
    %A.Impulses(i,1) = 30*0.015*sin(2*pi*i*0.01);
    %A.Impulses(i,2) = 30*0.015*cos(2*pi*i*0.01);
    A.Impulses(i,4) = 0.044;
end

for i = 16:20
    A.Impulses(i,5) = 0.010;
end

for i = 151:165
    %A.Impulses(i,1) = 30*0.015*sin(2*pi*i*0.01);
    %A.Impulses(i,2) = 30*0.015*cos(2*pi*i*0.01);
    A.Impulses(i,4) = -0.044;
end

for i = 166:170
    A.Impulses(i,5) = 0.010;
end

for i = 300:500
    A.Impulses(i,1) = 3.5*0.015*sin(2*pi*i*0.01);
    A.Impulses(i,2) = 3.5*0.015*cos(2*pi*i*0.01);
    A.Impulses(i,6) = 0.005;
end





% theta = 0.687488031893190;
% 
% for i = 101:140:N
%     A.Impulses(i,4) = -0.45*cos(theta);
%     A.Impulses(i,5) = -0.45*sin(theta);
% end
% % 
% for i = 201:140:N
%     A.Impulses(i,4) = 0.15*cos(theta);
%     A.Impulses(i,5) = 0.15*sin(theta);
% end
% 
% 
% 
end
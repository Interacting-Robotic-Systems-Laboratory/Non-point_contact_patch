function A = planner(A)
N = 50;
A.N =N;
A.Impulses = zeros(N,6);


for i = 1:40
    A.Impulses(i,4) = 2.1/5;
end

for i = 101:500
    A.Impulses(i,1) = 15*0.015*(sin(2*pi*i*0.01)+1);
    A.Impulses(i,2) = 15*0.015*(cos(2*pi*i*0.01)+1);
    A.Impulses(i,6) = 2.1*cos(2*pi*i*0.01)*0.01;

end



end
function [Q_x,Q_y,Q_z] = transform_points( H,X,Y,Z)
    [m,n] = size(X);
    Q_x = zeros(m,n);
    Q_y = zeros(m,n);
    Q_z = zeros(m,n);
for i = 1:m
    A = H*[X(i,:);Y(i,:);Z(i,:);ones(1,n)];
    Q_x(i,:) = A(1,:);
    Q_y(i,:) = A(2,:);
    Q_z(i,:) = A(3,:);
end

end
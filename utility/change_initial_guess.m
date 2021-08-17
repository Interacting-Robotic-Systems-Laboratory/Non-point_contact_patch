function Z = change_initial_guess(A,Z,Q)

if  A.object == "Table"
    R =rand;
    Z = R*Z;
elseif A.object == "T_bar"
    
    R =rand;
    Z = R*Z;
end

end
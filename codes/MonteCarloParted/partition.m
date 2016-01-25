function x = partition(X,Y,offset)
%to input here -10 as a viriable
n = size(X,2);
idx = zeros(n,1);

for i=1:n

    % case 1 TopLeft
    if X(i) <= 0 && Y(i) > offset
        idx(i) = 1;
    elseif X(i)>0 && Y(i) > offset
        idx(i) = 2;
    elseif X(i)<= 0 && Y(i) <= offset
        idx(i) = 3;
    else idx(i) = 4;

    end  

end

idx;

x = [X' Y' idx];
end

    

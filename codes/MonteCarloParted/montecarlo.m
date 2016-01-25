function x = montecarlo (X,Y,partition_idx)
% Compute the monte carlo method.
% X ,Y are two vectors containing all points of the partition.
% Domain


omega_xmin = -80;
omega_xmax = 80;
omega_ymin = -80;
omega_ymax = 60;

%random sampling
n =100;
x_rand =omega_xmin + (abs(omega_xmin) + abs(omega_xmax))*rand(n,1);
y_rand =omega_ymin + (abs(omega_ymin) + abs(omega_ymax))*rand(n,1);

figure (3)
plot(X,Y,'o', x_rand, y_rand,'*')
%rand_points = [x_rand y_rand]

np_outside = 0;
np_inside = 0;

for i = 1:n
     
    interval = zeros(2,2);
    for j = 1:n
     if y_rand(i) == Y(j)
        interval = [X(j) Y(j)]% here we have all points with coordinate Y(i)
     end
    end % here we have found 2 border's points

      
         diff1 = abs(y_rand(i)) + abs(interval(1,2));
         diff2 = abs(y_rand(i)) + abs(interval(2,2));
         d = diff1+diff2;
         diff = abs(interval(1,2)) + abs(interval(2,2));

         if d == diff
             np_inside = np_inside + 1;
            else np_outside = np_outside + 1;
         end 
    
    
end
np_outside
np_inside

end
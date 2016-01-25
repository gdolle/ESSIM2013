function [] = extract_partition_nodes(all_coordinates)
% 
[m n] = size(all_coordinates);
partition_1;
partition_2;
partition_3;
partition_4;


for i = 1:m
    if all_coordinates(i,3) == 1
        partition_1 = [partition_1;all_coordinates(i,:)];
    elseif all_coordinates(i,3) == 2
        partition_2 = [partition_2;all_coordinates(i,:)];
    elseif all_coordinates(i,3) == 3
        partition_3 = [partition_3;all_coordinates(i,:)];    
    elseif partition_4 = [partition_4;all_coordinates(i,:)];
    end
        
end


end


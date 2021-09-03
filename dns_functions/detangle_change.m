function [ struct_out ] = detangle_change( struct1,delta )
% detangle_change Summary of this function goes here
%   Perform the detector bank position modification "delta" deg (add)
%   and recalculate the 2theta 
%   e.g.: nicr_1=detangle_change(nicr,-0.5)

struct_out=struct();
names=fieldnames(struct1);
for i=1:length(names)
    mat1 = getfield(struct1, names{i});
    mat1(:,end) = mat1(:,end)+delta;
    mat1(:,1) = abs(mat1(:,end))+5*mat1(:,3);
    struct_out=setfield(struct_out,names{i},mat1);
end

end


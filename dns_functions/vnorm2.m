function [ struct_out ] = vnorm2( struct1,vana,fac )
% vnorm2 : vanadium normalization function of structure data format 
%   struct1: structure format 
%   vana   : matrix format
%   fac    : double format.

struct_out=struct();
names=fieldnames(struct1);
for i=1:length(names)
    disp(['apply vanadium normalization to ', names{i}]);
    mat1=getfield(struct1,names{i});
    mat2=vana;
    mat3=vnorm(mat1,mat2,fac);
    struct_out=setfield(struct_out,names{i},mat3);
end

end


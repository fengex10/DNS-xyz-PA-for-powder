function [ struct_out,unit ] = normalise1( struct1,keyword )
%normalise1 : Normalise the data according the key word.
%   cite the 'normalise.m' function.
%   input : structure format, include xsf,xnsf,ysf,ynsf,zsf,znsf; keyword
%   is string: 'Monitor' or 'Timer'
%   output: structure format, include xsf,xnsf,ysf,ynsf,zsf,znsf; unit.
struct_out=struct();
if isstruct(struct1)
    names=fieldnames(struct1);
    for i=1:length(names)
        mat1=getfield(struct1,names{i});
        disp([inputname(1),'-',names{i}]);  % obtain input var name as string
        [mat2,unit]=normalise(mat1,keyword);
        struct_out=setfield(struct_out,names{i},mat2);
    end

else
    disp('input wrong! check routines!')
end

end


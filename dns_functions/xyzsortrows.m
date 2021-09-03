function [ output1 ] = xyzsortrows( input1,colnum )
% xyzsortrows : sort data ascending according colum indicater 'colnum'
%   input : matrix or structure
%   default: colnum = 1
if nargin<2
    colnum=1;
end
if isstruct(input1) % input is structure case
    names=fieldnames(input1);
    output1=struct();
    for i=1:length(names)
        mat1=getfield(input1,names{i});
        mat1=sortrows(mat1,colnum);
        output1=setfield(output1,names{i},mat1);
    end
else
    output1=sortrows(input1,colnum);
end

end


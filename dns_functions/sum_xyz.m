function out_mat = sum_xyz( input1 )
%sum_xyz : Perform the summation of xyz-sf/nsf 6 channel data
%   input1 should be structre data format include
%   xsf,xnsf,ysf,ynsf,zsf,znsf 6 channel data
%   out_mat is matrix with 5 cols: 2theta, Intensity, error, bkposition,
%   detnum

if isstruct(input1) 
    names=fieldnames(input1);
    out_mat=getfield(input1,names{1});
    if length(names)>1
        for i=2:length(names)
            mat1=getfield(input1,names{i});
            out_mat=dns_Plus(out_mat,mat1);
        end
    end
else
    disp('please input structure data with xyz-sf/nsf');
    return;
end
end


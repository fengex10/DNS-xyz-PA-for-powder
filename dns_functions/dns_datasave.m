function  dns_datasave( input1,outname,lambda )
% datasave:  save data to ascii format in 4 col:
%   Detailed explanation goes here
%   input   : matrix or structure, first col is 2theta
if nargin<3
    lambda=4.2;
end

if isstruct(input1)
    names=fieldnames(input1);
    for i=1:length(names)
        newname=[outname,'_',names{i}];
        mat1=getfield(input1,names{i});
        savematrix(mat1,newname,lambda);
    end
else
    savematrix(input1,outname,lambda);
end      
end


function savematrix(mat1,outname,lambda)
% matrix mode: save single matrix data and convert 2theta to Q
% output is Q, 2theta, intensity, err
mat1=sortrows(mat1);
theta=mat1(:,1)/2;
Q=4*pi*sin(theta*pi/180)/lambda;
mat_out=[Q,mat1(:,1:3)];

col_names={'Q(A^-1)', '2theta(deg)', 'Intensity(a.u.)', 'error'};
fid=fopen([outname,'.txt'],'wt');
for a=1:length(col_names)
    if a==length(col_names)
        fprintf(fid,'%s\n', col_names{a});
    else
        fprintf(fid,'%s\t', col_names{a});
    end
end

[m,n]=size(mat_out);
for i=1:m
    for j=1:n
        if j==n
            fprintf(fid,'%g\n', mat_out(i,j));
        else
            fprintf(fid,'%g\t', mat_out(i,j));
        end
    end
end
fclose(fid);
end

function [ matout ] = dns_Divide( input1,input2 )
%dns_Divide : apply divide calculate to two matrics or matrix with number
%   mat1/mat2 or mat1/num2 or num1/mat2
%   input matrix is 5 cols: twotheta,intensity,error,Detector_num,DetBank
%   output matrix is 5 cols: twotheta,intensity,error,Detector_num,DetBank
det_bak_err=0.03;

if ismatrix(input1) && ismatrix(input2) && length(input1)>1 && length(input2)>1
    if size(input1,1) <= size(input2,1) % row of mat1 smaller or equal row of mat2.
        matout=divide1(input1,input2,det_bak_err);
    else % row of mat1 bigger row of mat2.
        matout=divide2(input1,input2,det_bak_err);
    end
elseif ismatrix(input1) && isnumeric(input2) && length(input2)==1 && length(input1)>1 %input1 is matrix
    intensity = input1(:,2)./input2(1,1);
    err = input1(:,3)./input2(1,1);
    matout=input1;
    matout(:,2)=intensity;
    matout(:,3)=err;
elseif ismatrix(input2) && isnumeric(input1) && length(input1)==1 && length(input2)>1 %input2 is matrix
    intensity = input1(1,1)./input2(:,2); 
    err = input1(1,1)*input2(:,3)./input2(:,2).^2;
    matout=input2;
    matout(:,2)=intensity; 
    matout(:,3)=err;
else    
    disp('Input error!, please check input data!');
    return;
end

end


function [matout]=divide1(mat1,mat2,det_bak_err)
% for the case the row number of mat1 is small than that of mat2
matout=zeros(1,5);
for i=1:size(mat1,1)
    angle   = mat1(i,1);
    det_num = mat1(i,end-1);
    det_bak = mat1(i,end);
    id=find(abs(mat2(:,end-1)-det_num)<0.01 & abs(mat2(:,end)-det_bak)<det_bak_err);
    intensity = mat1(i,2)/mat2(id,2);
    err = sqrt((mat1(i,3)/mat2(id,2))^2+(mat1(i,2)*mat2(id,3)/mat2(id,2)^2)^2);
    newline=[angle,intensity,err,det_num,det_bak];
    matout=[matout;newline];
end
matout=matout(2:end,:);
end

function [matout]=divide2(mat1,mat2,det_bak_err)
% for the case the row number of mat1 is small than that of mat2
matout=zeros(1,5);
for i=1:size(mat2,1)
    angle   = mat2(i,1);
    det_num = mat2(i,end-1);
    det_bak = mat2(i,end);
    id=find(abs(mat1(:,end-1)-det_num)<0.01 & abs(mat1(:,end)-det_bak)<det_bak_err);
    intensity = mat1(id,2)/mat2(i,2);
    err = sqrt((mat1(id,3)/mat2(i,2))^2+(mat1(id,2)*mat2(i,3)/mat2(i,2)^2)^2);
    newline=[angle,intensity,err,det_num,det_bak];
    matout=[matout;newline];
end
matout=matout(2:end,:);
end
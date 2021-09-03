function [ matout ] = dns_Plus( input1,input2 )
%dns_Plus : apply plus calculate to two matrics or matrix with number
%   mat1+mat2 or mat1+num2 or num1+mat2
%   input matrix is 5 cols: twotheta,intensity,error,Detector_num,DetBank
%   output matrix is 5 cols: twotheta,intensity,error,Detector_num,DetBank
det_bak_err=0.03;

if ismatrix(input1) && ismatrix(input2) && length(input1)>1 && length(input2)>1
    if size(input1,1) <= size(input2,1) % row of mat1 smaller or equal row of mat2.
        matout=plus1(input1,input2,det_bak_err);
    else % row of mat1 bigger row of mat2.
        matout=plus2(input1,input2,det_bak_err);
    end
elseif ismatrix(input1) && isnumeric(input2) && length(input2)==1 && length(input1)>1
    intensity = input1(:,2)+input2(1,1);
    matout=input1;
    matout(:,2)=intensity;
elseif ismatrix(input2) && isnumeric(input1) && length(input1)==1 && length(input2)>1
    intensity = input2(:,2)+input1(1,1);
    matout=input2;
    matout(:,2)=intensity; 
else    
    disp('Input error!, please check input data!');
    return;
end

end


function [matout]=plus1(mat1,mat2,det_bak_err)
% for the case the row number of mat1 is small than that of mat2
matout=zeros(1,5);
for i=1:size(mat1,1)
    angle   = mat1(i,1);
    det_num = mat1(i,end-1);
    det_bak = mat1(i,end);
    id=find(abs(mat2(:,end-1)-det_num)<0.01 & abs(mat2(:,end)-det_bak)<det_bak_err);
    intensity = mat1(i,2)+mat2(id,2);
    err = sqrt(mat1(i,3)^2+mat2(id,3)^2);
    newline=[angle,intensity,err,det_num,det_bak];
    matout=[matout;newline];
end
matout=matout(2:end,:);
end

function [matout]=plus2(mat1,mat2,det_bak_err)
% for the case the row number of mat1 is bigger that of mat2
matout=zeros(1,5);
for i=1:size(mat2,1)
    angle   = mat2(i,1);
    det_num = mat2(i,end-1);
    det_bak = mat2(i,end);
    id=find(abs(mat1(:,end-1)-det_num)<0.01 & abs(mat1(:,end)-det_bak)<det_bak_err);
    intensity = mat1(id,2)+mat2(i,2);
    err = sqrt(mat1(id,3)^2+mat2(i,3)^2);
    newline=[angle,intensity,err,det_num,det_bak];
    matout=[matout;newline];
end
matout=matout(2:end,:);
end


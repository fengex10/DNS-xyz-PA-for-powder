function [ matout ] = subtract( mat1,mat2,ratio )
% subtract :  Apply 'mat2'subtraction with 'ratio' from mat1 
% this routine should follow the 'normalise.m' function.
% only the points which det_num and det_bak are same will be calculated. 
%   equation : mat1-ratio*mat2
%   input matix in 5 col: twotheta,intensity,error,Detector_num,DetBank
%   output matix in 5col: twotheta,intensity,error,Detector_num,DetBank
det_bak_err=0.03;
if size(mat1,1)~=size(mat2,1)
    disp(['the length of',inputname(1),' and ',inputname(2),'is not match!']);
    disp('only matched points will be calculated!');
end
matout=zeros(1,5);
a=size(mat1,1);
for i=1:a
    angle   = mat1(i,1);
    det_num = mat1(i,end-1);
    det_bak = mat1(i,end);
    %find proper id of mat2 according det_num and det_bak
    id=find(abs(mat2(:,end-1)-det_num)<0.01 & abs(mat2(:,end)-det_bak)<det_bak_err);
    intensity=mat1(i,2)-ratio*mat2(id,2);
    err=sqrt(mat1(i,3)^2+ratio*mat2(id,3)^2);
    newline=[angle,intensity,err,det_num,det_bak];
    matout=[matout;newline];
end
matout=matout(2:end,:);

end


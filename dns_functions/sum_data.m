function [ matsum ] = sum_data( mat1,mat2 )
% Sum two runs data, include Intensity, Monitor cts, Timer.
%   the input data must be the follow format:
%   twotheta,intensity,Detector_num,Mon,timer,DetBank
det_bak_err=0.3;
if size(mat1,1)<=size(mat2,1)
    a=size(mat1,1);
    for i=1:a
        det_num=mat1(i,3);
        det_bak=mat1(i,6);
        %[abs(mat2(:,3)-det_num),abs(mat2(:,6)-det_bak)]
        id=find(abs(mat2(:,3)-det_num)<0.01 & abs(mat2(:,6)-det_bak)<det_bak_err);
        mat1(i,2)=mat1(i,2)+mat2(id,2);
        mat1(i,4)=mat1(i,4)+mat2(id,4);
        mat1(i,5)=mat1(i,5)+mat2(id,5);
    end
    matsum=mat1;
else
    a=size(mat2,1);
    for i=1:a
        det_num=mat2(i,3);
        det_bak=mat2(i,6);
        id=find(abs(mat1(:,3)-det_num)<0.01 & abs(mat1(:,6)-det_bak)<det_bak_err);
        mat2(i,2)=mat2(i,2)+mat1(id,2);
        mat2(i,4)=mat2(i,4)+mat1(id,4);
        mat2(i,5)=mat2(i,5)+mat1(id,5);
    end
    matsum=mat2;
end

end


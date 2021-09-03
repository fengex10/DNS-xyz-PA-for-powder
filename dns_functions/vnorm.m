function [ matout ] = vnorm( mat1,vana,keyword )
% vnorm : detector efficiency correction using the vanadium data
%   factor*mat1/vana, data can obtained after 'normalise.m'
% cited function 'dns_Divide.m' and dns_Multy.m 
%   input : two matrics in 5 cols: twotheta,intensity,error,Detector_num,DetBank
%   output: matrix in 5 cols:twotheta,intensity,error,Detector_num,DetBank          
%   option: keyword
%   keyword: no input, fac=1;
%   keyword: not number, fac=average of the vana intensity
%   keyword: is number, fac=keyword


if nargin<2 || nargin>3
    disp('input wrong!, please check!');
    return;
elseif nargin==2
    if size(mat1,1)~=size(vana,1)
        disp(['the length of',inputname(1),' and ',inputname(2),' is not match!']);
        disp('only matched points will be calculated!');
    end
    matout=dns_Divide(mat1,vana);
elseif isnumeric(keyword)
    if size(mat1,1)~=size(vana,1)
        disp(['the length of',inputname(1),' and ',inputname(2),' is not match!']);
        disp('only matched points will be calculated!');
    end
    matout=dns_Multy( dns_Divide(mat1,vana),keyword);
elseif ~isnumeric(keyword)
    if size(mat1,1)~=size(vana,1)
        disp(['the length of',inputname(1),' and ',inputname(2),' is not match!']);
        disp('only matched points will be calculated!');
    end
    fac=mean(vana(:,2));
    matout=dns_Multy( dns_Divide(mat1,vana),fac);    
end
end


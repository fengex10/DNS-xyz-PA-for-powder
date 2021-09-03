function [ output1 ] = mask_det( input1, varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin==1
    det_del=[0]; % default value:0th detector will be musked
elseif nargin>1
    det_del=[];
    for i=1:length(varargin)
        det_del=[det_del,varargin{i}];
    end
end

if ismatrix(input1) && size(input1,1)>2
    output1=mask_mat(input1,det_del);
elseif isstruct(input1) && size(input1,1)==1
    output1=mask_struct(input1,det_del);
else
    disp('input wrong! please check!')
end
end

function [struct_out] = mask_struct(struct1,det_del)

struct_out=struct();
names=fieldnames(struct1);
for i=1:length(names)
    mat1=getfield(struct1,names{i});
    mat2=mask_mat(mat1,det_del);
    struct_out=setfield(struct_out,names{i},mat2);
end
end

function [matout] = mask_mat(mat1,det_del) %varargin 0-23
    %check input mat1 format, obtain the det_num col num.
    if size(mat1,2)==6 % data before 'normalise.m':twotheta,intensity,Detector_num,Mon,timer,DetBank
        det_num_col=3;
    elseif size(mat1,2)==5 % data after 'normalise.m' :twotheta,intensity,error,Detector_num,DetBank
        det_num_col=4;
    else
        disp('input matrix wrong, please check format and routines');
    end   
    
    matout=mat1;
    for i=1:length(det_del)
        a=det_del(i); %obtain the masked detector number
        id=find(abs(matout(:,det_num_col)-a)<0.01);
        matout(id,:)=[];
    end
end


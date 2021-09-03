function [ struct_out ] = subtract1( struct1,struct2,ratio )
% subtract1 : apply subtraction of struct2 with ratio from struct1
% according their same field: xsf,xnsf,ysf,ynxsf,zsf,znsf.
% only the points which det_num and det_bak are same will be calculated.
%   Detailed explanation goes here 
%   function: subtract.m
%   equation: struct1-ratio*struct2
%   input : two sturcture data format, and subtraction ratio of struct2
%   output: sturcture data format within 5 cols matrix data format:
%           twotheta,intensity,error,Detector_num,DetBank
struct_out=struct();
if isstruct(struct1) && isstruct(struct2)
    names = fieldnames(struct1);
    names2= fieldnames(struct2);
    %class(names2)
    for i=1:length(names)
        %class(names{i})
        if ~isempty(strfind(names2,names{i})) % determine if the field in the subtracted struct!
            mat1=getfield(struct1,names{i});
            mat2=getfield(struct2,names{i});
            disp([inputname(1),'-',num2str(ratio),'*',inputname(2),' ',names{i}]);
            mat3=subtract(mat1,mat2,ratio); % apply subtraction by 'subtract.m'
            struct_out=setfield(struct_out,names{i},mat3);
        else
            disp([names(i),'cannot be found, will be skiped']);
            continue;
        end
    end

else
    disp('input wrong! check routines!');
end

end


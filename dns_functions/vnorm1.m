function [ struct_out ] = vnorm1( struct1,vana,varargin )
% vnorm1 : apply detector efficiency correction by vanadium data in
% structure data format.
%   factor*struct1/vana, data can obtained after 'normalise.m'
%   cited function 'vnorm.m', 'dns_Divide.m' and dns_Multy.m 
%   Detailed explanation goes here
% input mode:
%   1) 4 inputs, (sampl_structure, vana_structure, fac_sf, fac_nsf)
%       take the exact channel of vana to normalize, fac_sf and fac_nsf
%       will be aplied to sf and nsf channel, respectively.
%   2) 3 inputs, (sampl_structure, vana_matrix, fac)
%       all channel data will be normalized by the same vana_matrix data,
%       fac will be applied to all channel.
%   3) 2 inputs, (sampl_structure, vana_structure), 
%       fac_sf=fac_nsf=1 mode of case 1)
%   4) 2 inputs, (sampl_structure, vana_matrix),
%       fac=1 mode of case 2)

% length(varargin)
% class(varargin)
% nargin
struct_out=struct();
if nargin<2 || nargin>4
    disp('input wrong!, only 2-4 elements accepted, please check!');
    return;
else 
    switch nargin
        case 2
            if isstruct(struct1) && isstruct(vana)  % wo structure case
                struct_out=vnorm_2struct(struct1,vana);
            elseif isstruct(struct1) && ismatrix(vana) && length(vana)>15 % one structure and one vana matrix
                struct_out=vnorm_strctmat(struct1,vana);
            else
                disp('input wrong, must be struct-struct or struct-matrix!');
            end
        case 3
            if isstruct(struct1) && isstruct(vana) 
                struct_out=vnorm_2struct(struct1,vana,varargin{end});
            elseif isstruct(struct1) && ismatrix(vana) && length(vana)>15
                struct_out=vnorm_strctmat(struct1,vana,varargin{end});
            else
                disp('input wrong in 3 agrs case, must be struct-matrix-factor')
                return;
            end
        case 4
            fac_sf=varargin{end-1};
            fac_nsf=varargin{end};
            if isstruct(struct1) && isstruct(vana)
                struct_out=vnorm_2struct(struct1,vana,fac_sf,fac_nsf);
            else
                disp('input wrong in 4 agrs case, must be struct-struct-fac_sf-fac_nsf!');
            end            
    end
end
disp(['vanadium normalization applied succesfully! with factor: ', varargin{:}])
end

function [out]=vnorm_2struct (struct1,vana,fac_sf,fac_nsf)
% for two structure data input case
% input must be (2 struct) or (2 struct and 2 factors)
names=fieldnames(struct1);
out=struct();
if nargin==2 % without factors input, set both to 1.
    fac_sf=1;
    fac_nsf=1;
elseif nargin==3 && ~isnumeric(fac_sf)
    fac_sf ='mean';
    fac_nsf='mean';
elseif nargin==3 && isnumeric(fac_sf)
    fac_nsf=1/2*fac_sf;
% elseif nargin==4 && isnumeric([fac_sf,fac_nsf])
%     fac_sf =varargin{1};
%     fac_nsf=varargin{2};
else
    disp('input wrong factor! check the input!')
    return;
end

for i=1:length(names)
    mat1=getfield(struct1,names{i});
    mat2=getfield(vana,names{i});
    if strfind(names{i},'nsf')
        fac=fac_nsf;
    else
        fac=fac_sf;
    end
    mat3=vnorm(mat1,mat2,fac);
    out=setfield(out,names{i},mat3);
end

end

function [out]=vnorm_strctmat (struct1,vana,fac)
% for one structure format 'struct1' and vana is matrix format case
names=fieldnames(struct1);
out=struct();
if nargin==2 % without factors input, set both to 1.
    fac=1;
end
for i=1:length(names)
    mat1=getfield(struct1,names{i});
    mat2=vana;
    mat3=vnorm(mat1,mat2,fac);
    out=setfield(out,names{i},mat3);
end
end
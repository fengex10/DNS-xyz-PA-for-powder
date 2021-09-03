function [ out1 ] = angle2Q( input1,lambda )
% angle2Q : convert 2theta to Q according lambda(default 4.2A)
%   Detailed explanation goes here
%   input : matrix or structure, first col is 2theta.
if nargin<2
    lambda=4.2;
end

if isstruct(input1) %input1 is structure
    out1=struct();
    names=fieldnames(input1);
    for i=1:length(names)
        mat1=getfield(input1,names{i});
        matout=angle2Q_mat(mat1,lambda);
        out1=setfield(out1,names{i},matout);
    end
else
    out1=angle2Q_mat(input1,lambda);
end
end

function [mat_out]=angle2Q_mat(mat,lambda)
% matrix mode: convert 2theta (first col) to Q according lambda
theta=mat(:,1)/2;
Q=4*pi*sin(theta*pi/180)/lambda;
mat_out=[Q,mat(:,2:end)];
end


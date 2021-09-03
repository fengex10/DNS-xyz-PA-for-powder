function [ moment_sq, moment_err ] = deltaM_sq_Nd( mat1 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
g=8/11;
Q=mat1(:,1);
intensity=mat1(:,2);
err=mat1(:,3);
integ_inner=Q.^2.*intensity;
err_new=Q.^2.*err;
[fenzi,fenzi_err]=numfuc_integ(Q,integ_inner,err_new);
fenmu=trapz(Q,Q.^2);
moment_sq=3*g^2*fenzi/fenmu;
moment_err=3*g^2*fenzi_err/fenmu;
end


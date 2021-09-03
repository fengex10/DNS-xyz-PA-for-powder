function [ matout ] = SQ_Nd( input1 )
%SQ_Nd:  convert absolute intensity to S(Q) by magnetic form factor
%   Detailed explanation goes here
Q=input1(:,1);
intensity=input1(:,2);
err=input1(:,3);
r0_sq=0.29106;  %magnetic cross section per solid angle, in barn/sr
magform_sq_Nd=Magformfac_Nd(Q).^2;
g=8/11; % Lande g factor of Nd3+.

factor=2./(g^2*r0_sq*magform_sq_Nd);
S_Q=factor.*intensity;
err_new=factor.*err;
matout=[Q,S_Q,err_new];
end


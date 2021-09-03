%% dns data treatment routines
clc, clear;
%%
readpath='data\';
readpath2='data\standard_files_rc42\';
nor_word='Timer'; % 'Monitor' to per 1K moncts, 'Timer' to per seconds
lambda=4.2; % define wavelength
nicr_num=[7611:7670];
vana_num=[7743:7802];
leer_num=[7671:7730];
samp_num1=[6498:6557;6558:6617;6618:6677;6678:6737]; % 89mK
samp_num2=[6798:6857]; % 605mK
samp_num3=[7338:7397]; % 10K
%% read data into struc data: xsf,xnsf,ysf,ynsf,zsf,znsf
vana=datacollect([readpath2,'p12185000036'],vana_num,'vana.d_dat');
nicr=datacollect([readpath2,'p12185000036'],nicr_num,'nicr.d_dat');
leer=datacollect([readpath2,'p12185000036'],leer_num,'leer.d_dat');
samp_89mK=datacollect([readpath, 'p12185000036'],samp_num1,'ndhf.d_dat');
samp_600mK=datacollect([readpath, 'Sum605mK'],samp_num2,'ndhf.d_dat');
samp_10K=datacollect([readpath, 'Sum10K'],samp_num3,'ndhf.d_dat');
% mask detectors, from 0 to 23 ,default is 0th detector
vana=mask_det(vana); % mask_det(vana,0,1,23)
nicr=mask_det(nicr);
leer=mask_det(leer);
samp_89mK=mask_det(samp_89mK);
samp_600mK=mask_det(samp_600mK);
samp_10K=mask_det(samp_10K);
% normalise data to monitro cts or timer.
[vana_nor,unit]=normalise1(vana,nor_word);
nicr_nor=normalise1(nicr,nor_word);
leer_nor=normalise1(leer,nor_word);
samp_nor_89mK=normalise1(samp_89mK,nor_word);
samp_nor_600mK=normalise1(samp_600mK,nor_word);
samp_nor_10K=normalise1(samp_10K,nor_word);
% subtract leer
vana_sub=subtract1(vana_nor,leer_nor,0.7);
nicr_sub=subtract1(nicr_nor,leer_nor,0.6);
samp_sub_89mK=subtract1(samp_nor_89mK,leer_nor,0);
samp_sub_600mK=subtract1(samp_nor_600mK,leer_nor,0);
samp_sub_10K=subtract1(samp_nor_10K,leer_nor,0);
% Flipping ratio correction and xyz-seperation
samp_FRcorr_89mK=FR_corr_xyz(samp_sub_89mK,nicr_sub);
samp_FRcorr_600mK=FR_corr_xyz(samp_sub_600mK,nicr_sub);
samp_FRcorr_10K=FR_corr_xyz(samp_sub_10K,nicr_sub);
samp_xyz_89mK=xyz_seperation(samp_FRcorr_89mK );
samp_xyz_600mK=xyz_seperation(samp_FRcorr_600mK );
samp_xyz_10K=xyz_seperation(samp_FRcorr_10K );
% vanadium normalization and plot
% samp_xyz_vnor_89mK = vnorm2( samp_xyz_89mK,vana_sub.xsf,'mean'); % normalized by vana_xsf with averaged vana_xsf intensity factor
% samp_xyz_vnor_600mK = vnorm2( samp_xyz_600mK,vana_sub.xsf,'mean');
% samp_xyz_vnor_10K = vnorm2( samp_xyz_10K,vana_sub.xsf,'mean');
% absolute unit normalization
eta_samp=3.402388864/1.661/(757.4598/2);  % per Nd ion
eta_vana=0.0708;
fac_vana=(9/12)*(eta_vana/eta_samp)*(1/1.75)*(5.08/4/pi);
% M_samp=7.6693/(757.4598/2); % per Nd
% M_vana=6*(4*pi*(0.45^2-0.35^2))/50.942; % per vanadium
% t_vana=0.786; %transimission of vana
% t_samp=0.580; % transimission of NHO
% t_Cu=0.892; % transimission of Cu in 0.08cm thickness
% t_samp=t_samp*t_Cu;
% fac_vana=(9/12)*(M_vana/M_samp)*(t_vana/t_samp)*(5.08/4/pi);
% fac_vana=(9/12)*(M_vana/M_samp)*(t_vana/t_samp)*(5.08/4/pi)*2.66997; % peak normalization
vana_sum_x=dns_Plus(vana_sub.xsf,vana_sub.xnsf);
vana_sum_y=dns_Plus(vana_sub.ysf,vana_sub.ynsf);
vana_sum_z=dns_Plus(vana_sub.zsf,vana_sub.znsf);
vana_sum=dns_Multy(1/3,dns_Plus(vana_sum_x,dns_Plus(vana_sum_y,vana_sum_z)));

samp_xyz_vnor_89mK = vnorm2( samp_xyz_89mK,vana_sum,fac_vana); % normalized by vana 6channel with averaged vana_xsf intensity factor
samp_xyz_vnor_600mK = vnorm2( samp_xyz_600mK,vana_sum,fac_vana);
samp_xyz_vnor_10K = vnorm2( samp_xyz_10K,vana_sum,fac_vana);

NHO_89mK=angle2Q(samp_xyz_vnor_89mK,lambda);
xyzplotQ(NHO_89mK,unit)
NHO_600mK=angle2Q(samp_xyz_vnor_600mK,lambda);
xyzplotQ(NHO_600mK,unit)
NHO_10K=angle2Q(samp_xyz_vnor_10K,lambda);
xyzplotQ(NHO_10K,unit)
dns_datasave(samp_xyz_vnor_89mK,'out\NHO_89mK_vana');
dns_datasave(samp_xyz_vnor_600mK,'out\NHO_600mK_vana');
dns_datasave(samp_xyz_vnor_10K,'out\NHO_10K_vana');
%% paramagnetic state
Q=0:0.1:3;
r0_sq=0.539^2;
magform_sq_Nd=Magformfac_Nd(Q).^2;
I_el=2/3*r0_sq*magform_sq_Nd/4*(2.475)^2;
figure;
plot(Q,I_el);
grid on;
%% apply sum rule
Imag_89mK=xyzsortrows(NHO_89mK.Imag);
Imag_600mK=xyzsortrows(NHO_600mK.Imag);
Imag_10K=xyzsortrows(NHO_10K.Imag);

Qr=[0.2,1.5]; %set Q range
Imag_89mK=Imag_89mK(Qr(1)<Imag_89mK(:,1)&Imag_89mK(:,1)<Qr(2),1:3);
Imag_600mK=Imag_600mK(Qr(1)<Imag_600mK(:,1)&Imag_600mK(:,1)<Qr(2),1:3);
Imag_10K=Imag_10K(Qr(1)<Imag_10K(:,1)&Imag_10K(:,1)<Qr(2),1:3);

SQ_89mK=SQ_Nd(Imag_89mK);
SQ_600mK=SQ_Nd(Imag_600mK);
SQ_10K=SQ_Nd(Imag_10K);

[mom_89mK,mom_err_89mK]=deltaM_sq_Nd(Imag_89mK)
[mom_600mK,mom_err_600mK]=deltaM_sq_Nd(Imag_600mK)
[mom_10K,mom_err_10K]=deltaM_sq_Nd(Imag_10K)



function [ data ] = datacollect( prefix,datanum,postfix )
%   datacollect: read data and reture 6 channel result in 6 cols
% e.g.[ data ] = dataread( 'data\p12185000036',[6498:6557;6558:6617],'ndhf.d_dat' )
%   Summary of this function goes here
%   reture a structure, include xsf, xnsf,ysf,ynsf,zsf,znsf matrix in 6cols
%   twotheta,intensity,Detector_num,Mon,timer,DetBank

% calculate 6 channel data, first run
% out matrix is: twotheta,intensity,Detector_num,Mon,timer,DetBank
xsf = comb_bank( prefix,datanum(1,1):datanum(1,end),6,postfix );
xnsf= comb_bank( prefix,datanum(1,2):datanum(1,end),6,postfix );    
ysf = comb_bank( prefix,datanum(1,3):datanum(1,end),6,postfix );
ynsf= comb_bank( prefix,datanum(1,4):datanum(1,end),6,postfix );
zsf = comb_bank( prefix,datanum(1,5):datanum(1,end),6,postfix );
znsf= comb_bank( prefix,datanum(1,6):datanum(1,end),6,postfix );

if size(datanum,1)>1 % multi runs data combination
    for i=2:size(datanum,1)
        xsf_new  = comb_bank( prefix,datanum(i,1):datanum(i,end),6,postfix );
        xnsf_new = comb_bank( prefix,datanum(i,2):datanum(i,end),6,postfix );    
        ysf_new  = comb_bank( prefix,datanum(i,3):datanum(i,end),6,postfix );
        ynsf_new = comb_bank( prefix,datanum(i,4):datanum(i,end),6,postfix );
        zsf_new  = comb_bank( prefix,datanum(i,5):datanum(i,end),6,postfix );
        znsf_new = comb_bank( prefix,datanum(i,6):datanum(i,end),6,postfix );
        
        xsf  = sum_data(xsf,xsf_new);
        xnsf = sum_data(xnsf,xnsf_new);
        ysf  = sum_data(ysf,ysf_new);
        ynsf = sum_data(ynsf,ynsf_new);
        zsf  = sum_data(zsf,zsf_new);
        znsf = sum_data(znsf,znsf_new);
    end
end
% data.xsf = xsf;
% data.xnsf= xnsf;
% data.ysf = ysf;
% data.ynsf= ynsf;
% data.zsf = zsf;
% data.znsf= znsf;
data=struct('xsf',xsf,'xnsf',xnsf,'ysf',ysf,'ynsf',ynsf,'zsf',zsf,'znsf',znsf);
end


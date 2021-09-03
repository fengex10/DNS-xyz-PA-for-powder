function [data_comb] = comb_bank( prefix,rondnum,channum,postfix)
% comb_data: combine data of different detector bank position
%   Detailed explanation goes here
%   rondnum is number list
%   out matrix is 6cols: twotheta,intensity,Detector_num,Mon,timer,DetBank
data_comb=zeros(1,6);
for i=rondnum(1):channum:rondnum(end)
    name=[prefix,num2str(i,'%d'),postfix];
    data=dnsdata1(name);
    data_comb=[data_comb;data];
end
data_comb=data_comb(2:end,:);

end


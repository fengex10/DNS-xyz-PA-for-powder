function [ xsf,xnsf,ysf,ynsf,zsf,znsf] = comb_data( prefix,rondnum,postfix )
% comb_data: combine data of different detector bank position
%   Detailed explanation goes here
xsf=zeros(1,6);
for i=rondnum(1):6:rondnum(end)
    name=[prefix,num2str(i,'%d'),postfix]
    data=dnsdata1(name);
    xsf=[xsf;data];
end
xsf=xsf(2:end,:)

xnsf=zeros(1,6);
for i=rondnum(2):6:rondnum(end)
    name=[prefix,num2str(i,'%d'),postfix]
    data=dnsdata1(name);
    xnsf=[xnsf;data];
end
xnsf=xnsf(2:end,:)

ysf=zeros(1,6);
for i=rondnum(3):6:rondnum(end)
    name=[prefix,num2str(i,'%d'),postfix]
    data=dnsdata1(name);
    ysf=[ysf;data];
end
ysf=ysf(2:end,:)

ynsf=zeros(1,6);
for i=rondnum(4):6:rondnum(end)
    name=[prefix,num2str(i,'%d'),postfix]
    data=dnsdata1(name);
    ynsf=[ynsf;data];
end
ynsf=ynsf(2:end,:)

zsf=zeros(1,6);
for i=rondnum(5):6:rondnum(end)
    name=[prefix,num2str(i,'%d'),postfix]
    data=dnsdata1(name);
    zsf=[zsf;data];
end
zsf=zsf(2:end,:)

znsf=zeros(1,6);
for i=rondnum(6):6:rondnum(end)
    name=[prefix,num2str(i,'%d'),postfix]
    data=dnsdata1(name);
    znsf=[znsf;data];
end
znsf=znsf(2:end,:)

end


function  xyzplottth( struct1,unit )
% xyzplot1 : plot the data sets after 'xyz_seperation.m'
%   Detailed explanation goes here
names={'Imag';'Imag_sf';'Imag_nsf';'Inuc';'Isp_inc';'xsf';'xnsf';'ysf';'ynsf';'zsf';'znsf'};
names2=fieldnames(struct1);
for i=1:length(names)
    id=find(strcmp(names{i},names2));
    if isempty(id)
        disp('input data wrong! please check the data format!');
        disp(['the data must contain ',names{:}]);
        return;
    end
end

if nargin<2
    unit='';
end
% plot Imag,Imag_sf,Imag_nsf,Inuc,Ispin
figure(1);
subplot(2,3,1);
singleplot(struct1,'Imag',unit,'*b');
subplot(2,3,2);
singleplot(struct1,'Imag_sf',unit,'*b');
subplot(2,3,3);
singleplot(struct1,'Imag_nsf',unit,'*b');
subplot(2,3,4);
singleplot(struct1,'Inuc',unit,'*b');
subplot(2,3,5);
singleplot(struct1,'Isp_inc',unit,'*b');

figure(2);
subplot(2,3,1);
singleplot(struct1,'xsf',unit,'*r');
subplot(2,3,4);
singleplot(struct1,'xnsf',unit,'*b');
subplot(2,3,2);
singleplot(struct1,'ysf',unit,'*r');
subplot(2,3,5);
singleplot(struct1,'ynsf',unit,'*b');
subplot(2,3,3);
singleplot(struct1,'zsf',unit,'*r');
subplot(2,3,6);
singleplot(struct1,'znsf',unit,'*b');

return;
end

function singleplot(struct1,field,unit,point)

a=getfield(struct1,field);
errorbar(a(:,1),a(:,2),a(:,3),point); %point is the point format
b=strrep(field,'_','\_'); % calcle subscript '_' 
title(b);
xlabel( '2 theta (deg)' )
ylabel( ['Intensity (cts ',unit,')'] )
grid on

end

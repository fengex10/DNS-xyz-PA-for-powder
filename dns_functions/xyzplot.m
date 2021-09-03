function  xyzplot( struct1,unit )
% xyzplot : plot xsf,xnsf,ysf,ynsf,zsf,znsf data in one structure data
%   input : structure format, must include x,y,z-sf/nsf 6 channal data
figure; 
names=fieldnames(struct1);
for i=1:length(names)
    subplot(3,2,i);
    a=getfield(struct1,names{i});
    errorbar(a(:,1),a(:,2),a(:,3),'*b');
    b=[inputname(1),' ',names{i}];
    b=strrep(b,'_','\_'); % calcle subscript '_' for 'F'
    title(b);
    xlabel( '2 theta (deg)' )
    ylabel( ['Intensity (cts/',unit,')'] )
    grid on
end
return;
end


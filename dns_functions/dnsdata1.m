function [ data ] = dnsdata1( filename )
%dnsdata: read dns single data file and reture the data
%Summary of this function goes here
%   DeteRota: first detector angle
%   Mon     : Monitor counts
%   Tim     : Timer of measurement
%   datar   : 24*2 matrix, first col is detector number, second col is counts
%   twotheta: scattering angle of 2 theta
%   out matrix is 24*6: twotheta,intensity,Detector_num,Mon,timer,DetBank
fID=fopen(filename);
disp(['read: ',filename]);
%row=0;
datar=zeros(1,2);
while ~feof(fID)
    tline=fgetl(fID);
    %row=row+1;

    if strfind(tline,'DeteRota')
        line=strsplit(tline);
        DeteRota=str2num(line{end-1});
        %row;
    elseif strfind(tline,'Monitor')
        line=strsplit(tline);
        Mon=str2num(line{end});
        %row;
    elseif strfind(tline,'Timer')
        line=strsplit(tline);
        Tim=str2num(line{end-1});
        %row;
    elseif ~strcmp(tline(1),'#')
        %row;
        line=strsplit(tline);
        datar=[datar;str2num(line{end-1}),str2num(line{end})];
    end    
end
fclose(fID);

datar=datar(2:25,:);
timer=Tim*ones(size(datar,1),1);
Monct=Mon*ones(size(datar,1),1);
twotheta=datar(:,1)*5+abs(DeteRota);
DetBank=DeteRota*ones(size(datar,1),1);
DetNum=datar(:,1);
Int=datar(:,2);
data=[twotheta,Int,DetNum,Monct,timer,DetBank];
end


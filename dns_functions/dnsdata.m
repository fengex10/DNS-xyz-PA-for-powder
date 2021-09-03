function [ DeteRota,Mon,Tim,data ] = dnsdata(filename)
%dnsdata: read dns data file and reture the data
%Summary of this function goes here
%   DeteRota: first detector angle
%   Mon     : Monitor counts
%   Tim     : Timer of measurement
%   data    : 24*2 matrix, first col is detector number, second col is counts
fID=fopen(filename);
%row=0;
data=zeros(1,2);
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
        data=[data;str2num(line{end-1}),str2num(line{end})];
    end    
end

data=data(2:25,:);

fclose(fID);

end


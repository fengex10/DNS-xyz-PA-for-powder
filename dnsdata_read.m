% read data from dns data 
clc,clear;
fID=fopen('data/p121850000366498ndhf.d_dat');
row=0;
data=zeros(1,3);
while ~feof(fID)
    tline=fgetl(fID);
    row=row+1;

    if strfind(tline,'DeteRota')
        line=strsplit(tline);
        DeteRota=str2num(line{end-1});
        row;
    elseif strfind(tline,'Monitor')
        line=strsplit(tline);
        Mon=str2num(line{end});
        row;
    elseif strfind(tline,'Timer')
        line=strsplit(tline);
        Tim=str2num(line{end-1});
        row;
    elseif ~strcmp(tline(1),'#')
        row;
        line=strsplit(tline);
        data=[data;row,str2num(line{end-1}),str2num(line{end})];
    end    
end
data=data(2:25,:);
fclose(fID);
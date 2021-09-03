function [ data ] = datamerg( prefix,datanum,postfix )
%   datacollect: read data and reture 6 channel result in 6 cols
% e.g.[ data ] = dataread( 'data\p12185000036',[6498:6557;6558:6617],'ndhf.d_dat' )
%   Summary of this function goes here
%   reture a matrix 
%   twotheta,intensity,Detector_num,Mon,timer,DetBank

% calculate 1 channel data, first run
% out matrix is: twotheta,intensity,Detector_num,Mon,timer,DetBank
data = comb_bank( prefix,datanum(1,1):datanum(1,end),1,postfix );


if size(datanum,1)>1 % multi runs data combination
    for i=2:size(datanum,1)
        data_new  = comb_bank( prefix,datanum(i,1):datanum(i,end),1,postfix );        
        data  = sum_data(data,data_new);
    end
end

end


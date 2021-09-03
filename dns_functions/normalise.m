function [ matout,unit ] = normalise( mat,keyword )
%normalise : Normalise the data to time or monitor cts, after 'dataread.m'
%   Detailed explanation goes here
%   mat: input matrix in 6 col: twotheta,intensity,Detector_num,Mon,timer,DetBank
%   keyword: 'Monitor' or 'Timer'
%   matout : output matix in 5 col: twotheta,intensity,error,Detector_num,DetBank
%   unit : normalized unit

switch keyword
    case 'Monitor'
        disp('Normalize to Monitor, per 1000cts');
        intensity=1000*mat(:,2)./mat(:,4);
        err = 1000*sqrt(mat(:,2))./mat(:,4);
        unit='per 1k monitor cts';
    case 'Timer'
        disp('Normalize to Timer, per sec')
        intensity=mat(:,2)./mat(:,5);
        err = sqrt(mat(:,2))./mat(:,5);
        unit='per sec';
    otherwise
        warning('please check the keyword!');
end
matout=[mat(:,1),intensity,err,mat(:,3),mat(:,end)];

end


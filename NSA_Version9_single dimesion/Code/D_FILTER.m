% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com% Function to convert GPS co-ordinates into metric units.
% Written by Nandkishor Dhawale,  August 2011

function FILT_DATA= D_FILTER(Y);

clc
count=Y;
[row col]=size(count);
%% to trim the tails
% disp('Please observe the following figures and enter the values to trim the tails');
% 
% subplot(2,1,1);plot(count(:,1))
% grid on
% subplot(2,1,2);plot(count(:,2))
% grid on
% title('Data to check by moving cursor')

% low_val = input('Please enter the cutoff value for the lower tail: ', 's');
% %low_val=200; %str2num(low_val);
% up_val = input('Please enter the cutoff value for the upper tail: ', 's');
% up_val=str2num(up_val);

low_val=100; up_val=length(count)-377;
count=count((low_val:up_val),:);

%disp('Confirming new data after trimming the tails');

% subplot(2,1,1);plot(count(:,1))
% grid on
% subplot(2,1,2);plot(count(:,2))
% grid on
% title('Confirming trimmed data')
% %waitforbuttonpress
% close

%% correct data [replace a value of 0 by the mean of previous and next values]
for I = 3:5,
    ind = find(count(:,I)<0);
    if ind > 0;
    count(ind,I)= (count(ind-1,I)+count(ind+1,I))/2;
    end
end

%% Filter data
% Smoothing Filter
C = count; % create new similar data
for I = 3:5,
    C(:,I) = smooth(count(:,I)); %'sgolay');
end

% Median Filter
% C = count; % create new similar data
% for I = 3:4,
%     C(:,I) = medfilt1(count(:,I),3);
% end

%% Scale data ..... to scale from 0 onwards
%outputData = scaleData(inputData,minVal,maxVal);
% Example:
% a = [1 2 3 4 5];
% a_out = scaledata(a,0,1);
% maxval=1; minval=0;
% for I=3:4,
% C2(:,I) = C1(:,I)-min(C1(:,I)); %dataout = datain - min(datain(:));
% C2(:,I) = (C2(:,I)/range(C2(:,I)))*(maxval-minval);
% %dataout = (dataout/range(dataout(:)))*(maxval-minval);
% C2(:,I) = C2(:,I) + minval;
% %dataout = dataout + minval;
% end


% %% Z=(x-mu)/sigma; Standardized Data
% for I = 3:4,
%     [Z,mu,sigma] = zscore(C(:,I));
%     C(:,I) = (C(:,I)-mu)/sigma;
% end
% 
% %% Shift data towards positive
% for I = 3:4,
%     C(:,I) = C(:,I)- min(C(:,I)) + exp(1);
% end

%% to subsitute original data with its logarithm
% for I=3:4,
%     C(:,I)= log(C(:,I));
% end
% 
% % Shift data towards positive
% for I = 3:4,
%     C(:,I) = C(:,I)- min(C(:,I)) + exp(1);
% end

FILT_DATA=C;


%end


% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com
%% Clustering Algorithm for a grid averaged data feature
function  NSA_PRE_CLASSIFICATION();
%% 
clc; %load Y
all_data=GRID_AVG(); % call grid function
nan_ind = find(isnan(all_data)); % find indices of all NaN elements 
all_data(nan_ind)=0;% replace them by zeros
[~, pp]=size(all_data); inc=pp/5;
A1=all_data(:,1:inc*1); 
A2=all_data(:,inc*1+1:inc*2); % Select Easting and Northing Data
A3=all_data(:,inc*2+1:inc*3); 
A4=all_data(:,inc*3+1:inc*4);% Select EC shallow and Deep data
A5=all_data(:,inc*4+1:inc*5); %Select the Elevation data

% Make boarder elements with zeroes
A3(1,:)=0; A3(end,:)=0; A3(:,1)=0; A3(:,end)=0; % EC Shallow
A4(1,:)=0; A4(end,:)=0; A4(:,1)=0; A4(:,end)=0; % EC Deep
A5(1,:)=0; A5(end,:)=0; A5(:,1)=0; A5(:,end)=0; % elevation

%% Creating a flag matrix
F41=A4; F41(find(A4~=0))=1;

%%
DATA=A4;  LON=A1; LAT=A2; ELEV=A5; ZONE1=F41; DATA1=A3;%-min(A3(:));
%DATA(find(DATA<0))=  min(DATA(find(DATA~=0)));
%DATA1(find(DATA == 0))=0; %DATA1(find(DATA1<0))=  min(DATA1(find(DATA1~=0)));
save('NSA_DATA1', 'DATA', 'DATA1', 'ZONE1', 'LON', 'LAT', 'ELEV') %stores only the specified variables.


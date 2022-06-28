%%% SOC
% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com

%% PART of the CODE used for running the algorithm

%% Memory maintenance commands
delete all % delete all previous data
clear   % clear the workspace
clc     % clean the command window area
close all % close all figures
%% Importing text data
M=uiimport;  % import soil data to workspace from text file
% Hunnicutt_Veris_09(200,14830),Brandon_Veris_09(100,7099),Krienke_09(200, 13100), 
% Rathje_VSEC_09(165,11240),Heiss_Veris_09(124,9857), Lusseto_Veris_09(200, 15900)
Y=M.data; % Extract the useful content from the worspace data
%% Call sub routines
FILT_DATA=D_FILTER(Y); %apply smoothing and logarithmic transformations
%Y=FILT_DATA; 
clear Y; clear M; pause(1); 
METRIC=GPS_TO_METER(FILT_DATA); % apply metric conversions
save FILT_DATA; clear FILT_DATA; pause(1); % saving the filtered data 
%PLOT_BASIC_FIGURES(METRIC); % plot figues illustrating data
save METRIC; pause(1); clear METRIC; % saving the metric data
NSA_PRE_CLASSIFICATION(); % apply preclassification processes
%[DATA FZONE NSA_RMSE] = CLASSIFY(); % start classification
[DATA FZONE NSA_RMSE NSA_CLS] = CLASSIFY(); %% start classification
% NSA_ZONE_CENTROIDS(FZONE); % calculate the centoids of delineated zones

















%% PART of the CODE used for DATA ANALYSIS
% code to find the final number of cluster
for p=1:1:max(FZONE(:)),
v(p)=0.04*length(FZONE(FZONE==p));
end
k=length(v(v~=0)) ;

%% CODE to calculate the final results on output layers
load NSA_DATA1; %load the saved data
%DATA=DATA1;   % to change the data layer to be used
Z1RMSE = NSA_ERR(DATA,ZONE1);
FZRMSE = NSA_ERR(DATA,FZONE);
NSA_RSQR=(Z1RMSE-FZRMSE)/Z1RMSE;
NSA_RESULTS= [Z1RMSE; FZRMSE; NSA_RSQR;0.04*length(find(DATA~=0));k]


%% code to calculate the statistical properties of the field data layer
NSA_STATS1=[ (min(DATA(find(DATA~=0)))) (mean(DATA(find(DATA~=0))))... 
    (median(DATA(find(DATA~=0)))) (mode(DATA(find(DATA~=0))))...
    (max(DATA(find(DATA~=0)))) (range(DATA(find(DATA~=0))))... 
    (std(DATA(find(DATA~=0)))) (var(DATA(find(DATA~=0))))];

%% code to calculate the statistical properties withing group of the output
%% map
for i=1:1:max(FZONE(:)),
    NSA_STATS11(i,:)=[ (min(DATA(find(FZONE==i)))) (mean(DATA(find(FZONE==i))))... 
    (median(DATA(find(FZONE==i)))) (mode(DATA(find(FZONE==i))))...
    (max(DATA(find(FZONE==i)))) (range(DATA(find(FZONE==i))))... 
    (std(DATA(find(FZONE==i)))) (var(DATA(find(FZONE==i))))];
end

%%% EOC

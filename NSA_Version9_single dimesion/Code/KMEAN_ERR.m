% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com% Function to convert GPS co-ordinates into metric units.
% Written by Nandkishor Dhawale,  August 2011

% Function to calculate root mean squared error between EC_Deep measurments
% and the derived spatial classes using Neighbourhood Search Approach (NSA) 

%%
% Date- December/10/13 % Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, % Department of Bioresource Engineering,
% McGill University, Macdonald Campus, % Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, % Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9. % email: nmdhawale@gmail.com

%%
% Both inputs are matrices(n X m) DATA and ZONE
% Output is a value of Root Mean Squared Error (RMSE)
% To call this funtion load the input data in Workspace 
% (eg. load NSA_DATA1) and then type RMSE = NSA_ERR(DATA, ZONE)

%%
%sof

function RMSE = KMEAN_ERR(DATA,ZONE),

%% Identify parameters and assign values according to Zones
K=max(ZONE(:)); N=length(ZONE(:)) - length(ZONE(find(ZONE==0))); %N > K
if N>K,
WB=DATA; %create a temporary matrice to perform rough work
for i=1:K,
      % calculate and insert average of i zone values
    WB(find(ZONE==i))= mean(DATA(find(ZONE==i)));  
end

%% Calculate the Root Mean Squared Error Term
% RMSE=sqrt((sum(sum((DATA-WB).^2)))/(N-K));  %return RMSE value
RMSE=(sum(sum((DATA-WB).^2)))/(N-K);  %return MSE value
else 
    
end
%%
%eof



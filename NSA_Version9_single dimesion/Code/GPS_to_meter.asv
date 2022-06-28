% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com% Function to convert GPS co-ordinates into metric units.
% Written by Nandkishor Dhawale,  August 2011

function METRIC = GPS_TO_METER(FILT_DATA)
clc

%% Read data from Excell Sheet
[n,p] = size(FILT_DATA); t = 1:n;

%% Assignment of variables
X=FILT_DATA(:,1); % LON
Y=FILT_DATA(:,2); % LAT
EC_SH=FILT_DATA(:,3); % EC-Shallow
EC_DP=FILT_DATA(:,4); % EC-Deep
Z=FILT_DATA(:,5); % Altitude

%%  Paramters
a=6378137;
b=6356752.3142;
%f_inv=298.2572236
f=0.003353;
%e^2=0.006694380
N=6388838;
M=6367382;
W=0.998325;
phi=mean(Y);
h=mean(Z);
%% Formulas
% F_long=(a^2/sqrt(a^2*(cos(phi*pi/180))^2+b^2*(sin(phi*pi/180))^2)+h)*cos(phi*pi/180)*pi/180 %,using N,M,W
F_long=(N+h)*cos(phi*pi/180)*pi/180; %,using stand alone
% F_lat=(a^2*b^2/(a^2*(cos(phi*pi/180))^2+b^2*(sin(phi*pi/180))^2)^(3/2)+h)*pi/180 %,using N,M,W
F_lat=(M+h)*pi/180; %,using stand alone

%% Distance formula
%sqrt((F_long*(x(i)-x(i-1))^2+(F_lat*(y(i)-y(i-1)))^2));
MIN_X=min(X);
MIN_Y=min(Y);
MIN_Z=min(Z);
for i=1:1:length(X)
    X(i)=F_long*(X(i)-MIN_X);
    Y(i)=F_lat*(Y(i)-MIN_Y);
    Z(i)=Z(i)-MIN_Z;
end

%Z(find(Z~=0))=log(Z(find(Z~=0)))- min(log(Z(find(Z~=0))))+ exp(1);
METRIC = [X Y EC_SH EC_DP Z];
% end

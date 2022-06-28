% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com% Function to convert GPS co-ordinates into metric units.
% Written by Nandkishor Dhawale,  August 2011

% Function to Plot the basic figures.
% Written by Nandkishor Dhawale,  August 2011
function  PLOT_BASIC_FIGURES(METRIC)
clc

%% Assignment of variables
x1=METRIC(:,1); % Latitude converted to meters
y1=METRIC(:,2); % Longitude converted to meters
z=METRIC(:,5); % Altitude converted to meters
var_ec_sh=METRIC(:,3); % EC-Shallow
var_ec_dp=METRIC(:,4); % EC-Deep

%% Plot 1-1
figure(gcf);
clf;
subplot(2,3,1); plot3(x1,y1,z, '--b')
title('Field Elevation Map')
xlim([min(x1) max(x1)]) 
ylim([min(y1) max(y1)]) 
zlim([min(z) max(z)])
xlabel('Easting [m]')
ylabel('Northing [m]')
zlabel('Elev[m]')
grid on

subplot(2,3,2); plot3(x1,y1,var_ec_sh, '--r')
title('Field EC Shallow Map')
xlim([min(x1) max(x1)]) 
ylim([min(y1) max(y1)])
xlabel('Easting [m]')
ylabel('Northing [m]')
zlabel('EC_Sh [mSiemens/m^2]')
grid on

subplot(2,3,3); plot3(x1,y1,var_ec_dp, '--g')
title('Field EC Deep Map')
xlim([min(x1) max(x1)]) 
ylim([min(y1) max(y1)])
xlabel('Easting [m]')
ylabel('Northing [m]')
zlabel('EC_Dp [mSiemens/m^2]')
grid on

waitforbuttonpress

%% Plot 1-2
subplot(2,3,4.5);plot(z,var_ec_sh, '-b')
title('Field Elevation Vs Field EC Shallow')
grid on
xlim([min(z) max(z)])
ylim([min(var_ec_sh), max(var_ec_sh)])
xlabel('Elev [m]')
ylabel('EC_Sh [mSiemens/m^2]')

subplot(2,3,5.5);plot(z,var_ec_dp, '--r')
title('Field Elevation Vs Field EC Deep')
grid on
xlim([min(z) max(z)])
ylim([min(var_ec_dp), max(var_ec_dp)])
xlabel('Elev [m]')
ylabel('EC_Dp [mSiemens/m^2]')

%print('-dpdf','Farm Brandes 09-1')

waitforbuttonpress
%% Plot 2
figure(gcf);
clf;
subplot(3,1,1); plot(x1,y1, '--g')
title('Field Northing Vs Easting')
xlim([min(x1), max(x1)])
ylim([min(y1), max(y1)])
xlabel('Easting [m]')
ylabel('Northing [m]')
grid on

subplot(3,1,2); plot(x1,z, '--r')
title('Field Easting Vs Elevation')
xlim([min(x1), max(x1)])
ylim([min(z) max(z)])
xlabel('Easting [m]')
ylabel('Elev [m]')
grid on

subplot(3,1,3); plot(y1,z, '--b')
title('Field Northing Vs Elevation')
xlim([min(y1), max(y1)])
ylim([min(z) max(z)])
xlabel('Northing [m]')
ylabel('Elev [m]')
grid on

%print('-dpdf','Farm Brandes 09-2')

%% Scatter Plot 1
waitforbuttonpress
figure(gcf);
clf;
scatterhist(var_ec_sh,var_ec_dp)
title('Frequency distributon plot-EC Shallow Vs EC Deep')
xlabel('EC_Sh [mSiemens/m^2]')
ylabel('EC_Dp [mSiemens/m^2]')

%print('-dpdf','Farm Brandes 09-3')

%% Scatter Plot 2
waitforbuttonpress
figure(gcf);
clf;
scatterhist(var_ec_sh,z)
title('Frequency distributon plot-Elevation Vs EC Deep')
xlabel('EC_Sh [mSiemens/m^2]')
ylabel('Elev [m]')

%print('-dpdf','Farm Brandes 09-4')

%% Scatter Plot 3
waitforbuttonpress
figure(gcf);
clf;
scatterhist(var_ec_dp,z)
title('Frequency distributon plot-Elevation Vs EC Deep')
xlabel('EC_Dp [mSiemens/m^2]')
ylabel('Elev [m]')

%print('-dpdf','Farm Brandes 09-5')
waitforbuttonpress
clf
close all
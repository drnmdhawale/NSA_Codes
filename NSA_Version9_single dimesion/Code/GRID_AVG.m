% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com%% Program to convert a given sensor data file to a grid based matrix data
% A=(n,m) n=rows; m=colums
% B=
% C=A/B
function  NSA_GRID_AVG=GRID_AVG();
%% data
clc
load METRIC;
gdsz=20;
hgd=gdsz/2;
lon= METRIC(:,1);
lat=METRIC(:,2);
londx= 0:gdsz:round(max(METRIC(:,1)));
latdx =0:gdsz:round(max(METRIC(:,2)));
Y1= METRIC(:,1);
Y2= METRIC(:,2);
Y3= METRIC(:,3);
Y4= METRIC(:,4);
Y5= METRIC(:,5);

%% code 1 using loop
for i=1:length(latdx)
  for j=1:length(londx)
     ind = find(lat<=latdx(i)+hgd & lat>latdx(i)-hgd & lon<=londx(j)+hgd & lon>londx(j)-hgd);
     avg_data1(i,j) = londx(j)+hgd; % nanmean(Y1(ind));
     avg_data2(i,j) = latdx(i)+hgd; % nanmean(Y2(ind));
     avg_data3(i,j) = nanmean(Y3(ind));
     avg_data4(i,j) = nanmean(Y4(ind));
     avg_data5(i,j) = nanmean(Y5(ind));
  end
end 

 
 NSA_GRID_AVG= [avg_data1 avg_data2 avg_data3 avg_data4 avg_data5];
 

clear
clc
close all
%% SOC
% Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com
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
load NSA_DATA1
% code to test Kmeans for single dimensional
KZONED=ZONE1; 
KZONE=KZONED;
IDS=(find (KZONED==1));
%DATA=DATA/20;


% Error in default Zone
Label1 = kmeans([DATA(IDS),DATA1(IDS),ELEV(IDS)],1);

for j=1:1:length(IDS)
    KZONED(IDS(j)) =Label1(j);
end
RMSED = KMEAN_ERR(DATA,ZONE1)*KMEAN_ERR(DATA1,ZONE1)*(KMEAN_ERR(ELEV,ZONE1))^2;

z_num=3;
for i=1:1:10
       
Label1 = kmeans([DATA(IDS), DATA1(IDS), ELEV(IDS)],z_num);

for jj=1:1:length(IDS)
    KZONE(IDS(jj)) =Label1(jj);
end

RMSE1 = KMEAN_ERR(DATA,KZONE)*KMEAN_ERR(DATA1,KZONE)* (KMEAN_ERR(ELEV,KZONE))^2;
RSQR1= (RMSED-RMSE1)/RMSED;
LABEL(:,i)= Label1;
RMSE(i,:)=RMSE1;
RSQR(i,:)= RSQR1;

% figure(2)
% plot(i, RMSE1, '*b'); grid on; hold on; 
%plot(i, RSQR1, '*r'); grid on; hold on;
% NSA_FIGURE()
% pause(0.1)
end
STATS1=[RMSE, RSQR];

LABEL(:, find(RSQR == max(RSQR)));

for jj=1:1:length(IDS)
    KZONE(IDS(jj)) =LABEL(jj);
end

figure(2)
surf(LON,LAT, KZONE)
view([0,90])
% colorbar
% h = figure(3);
% print(h, '-dtiff', 'F1ZK');

B = medfilt2(KZONE);
%B = medfilt2(B);
B = KZONE;
%B = medfilt2(B);

figure(3)
surf(LON,LAT, B)
view([0,90])
% colorbar
% h = figure(4);
% print(h, '-dtiff', 'F1ZKM');

for jj=1:1:length(IDS)
    LABEL2(jj,:) =B(IDS(jj));
end

RMSE2 = KMEAN_ERR(DATA,B)*KMEAN_ERR(DATA1,B)*(KMEAN_ERR(ELEV,B))^2;
RSQR2= (RMSED-RMSE2)/RMSED;
STATS2= [min(RMSE) RMSE2; min(RSQR) RSQR2]


RSQINDV=[ (NSA_ERR(DATA,ZONE1))^2, (NSA_ERR(DATA1,ZONE1))^2, (NSA_ERR(ELEV,ZONE1))^2 ; ...
(NSA_ERR(DATA,B))^2, (NSA_ERR(DATA1,B))^2, (NSA_ERR(ELEV,B))^2; ...
1-((NSA_ERR(DATA,B))^2/(NSA_ERR(DATA,ZONE1))^2 )...
1-((NSA_ERR(DATA1,B))^2/(NSA_ERR(DATA1,ZONE1))^2 ) ...
1-((NSA_ERR(ELEV,B))^2/(NSA_ERR(ELEV,ZONE1))^2 )]

RSQINDV(3,1)*RSQINDV(3,2)*RSQINDV(3,3)*RSQINDV(3,3)

figure(4)
subplot(3,1,1);hist(ELEV(find(ELEV~=0)))
subplot(3,1,2);hist(DATA1(find(DATA~=0)))
subplot(3,1,3);hist(DATA(find(DATA~=0)))

figure(1)
view(2)
subplot (3,1,1); surf(LON,LAT,ELEV)
title('ELEV')
view([-9,80])
%colorbar
NSA_FIGURE()

figure(1)
subplot (3,1,2); surf(LON,LAT,DATA1)
title('sECa')
view([-9,80])
%colorbar
NSA_FIGURE()

figure(1)
subplot (3,1,3); surf(LON,LAT,DATA)
title('dECa')
view([-9,80])
%colorbar
NSA_FIGURE()

FZONE=B;

for i=1:1:max(FZONE(:)),
    NSA_STATS11(i,:)=[ (min(DATA(find(FZONE==i)))) (mean(DATA(find(FZONE==i))))... 
    (median(DATA(find(FZONE==i)))) (mode(DATA(find(FZONE==i))))...
    (max(DATA(find(FZONE==i)))) (range(DATA(find(FZONE==i))))... 
    (std(DATA(find(FZONE==i)))) (var(DATA(find(FZONE==i))))];

NSA_STATS21(i,:)=[ (min(DATA1(find(FZONE==i)))) (mean(DATA1(find(FZONE==i))))... 
    (median(DATA1(find(FZONE==i)))) (mode(DATA1(find(FZONE==i))))...
    (max(DATA1(find(FZONE==i)))) (range(DATA1(find(FZONE==i))))... 
    (std(DATA1(find(FZONE==i)))) (var(DATA1(find(FZONE==i))))];

NSA_STATS31(i,:)=[ (min(ELEV(find(FZONE==i)))) (mean(ELEV(find(FZONE==i))))... 
    (median(ELEV(find(FZONE==i)))) (mode(ELEV(find(FZONE==i))))...
    (max(ELEV(find(FZONE==i)))) (range(ELEV(find(FZONE==i))))... 
    (std(ELEV(find(FZONE==i)))) (var(ELEV(find(FZONE==i))))];

end
STAS11=[NSA_STATS31; NSA_STATS21; NSA_STATS11]
 
% 
% save('F1ZK.txt','LAT','-ascii', '-tabs', '-append')
% save('F1ZK.txt','LON','-ascii', '-tabs', '-append')
% 
% save('F1ZK.txt','RMSED','-ascii', '-tabs', '-append')
% save('F1ZK.txt','KZONE','-ascii', '-tabs', '-append')
% save('F1ZK.txt','LABEL','-ascii', '-tabs', '-append')
% save('F1ZK.txt','STATS1','-ascii', '-tabs', '-append')
% 
% save('F1ZK.txt','B','-ascii', '-tabs', '-append')
% save('F1ZK.txt','LABEL2','-ascii', '-tabs', '-append')
% save('F1ZK.txt','STATS2','-ascii', '-tabs', '-append')

% 
% [length(find(B>0)), length(find(KZONE>0))]
% figure(1)
% subplot(3,1,3); boxplot(KDATA3(find(B~=0)),B(find(B~=0)));
% ylabel('rELEV')
% subplot(3,1,2); boxplot(KDATA2(find(B~=0)),B(find(B~=0)));
% ylabel('sECa')
% subplot(3,1,1); boxplot(KDATA1(find(B~=0)),B(find(B~=0)));
% ylabel('dECa')
% 
% figure(2)
% subplot(3,1,3); boxplot(KDATA3(find(KZONE>0)),KZONE(find(KZONE>0)));
% ylabel('rELEV')
% subplot(3,1,2); boxplot(KDATA2(find(KZONE>0)),KZONE(find(KZONE>0)));
% ylabel('sECa')
% subplot(3,1,1); boxplot(KDATA1(find(KZONE>0)),KZONE(find(KZONE>0)));
% ylabel('dECa')
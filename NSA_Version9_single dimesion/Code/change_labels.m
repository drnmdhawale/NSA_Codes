
%1
BB=B;
T=BB(find(LON >= 510));
T(find(T==3))=5;
BB(find(LON >= 510))=T;
clear T

%2
T=BB(find(LON <= 250));
T(find(T==3))=6;
BB(find(LON <= 250))=T;
clear T

%3
BB(find(BB==3))=4;

%4
T=BB(find(LON <= 350));
T(find(T==2))=3;
BB(find(LON <= 350))=T;
clear T

% T=BB(find(LON >= 530));
% T(find(T==3))=2;
% BB(find(LON >= 530))=T;
% clear T

surf(LON,LAT, BB)
view([0,90])

RMSE3 = KMEAN_ERR(DATA,BB)*KMEAN_ERR(DATA1,BB)*(KMEAN_ERR(ELEV,BB))^2
RSQR3= (RMSED-RMSE3)/RMSED

FZONE=BB;

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

RSQINDV= [ (NSA_ERR(DATA,ZONE1))^2 (NSA_ERR(DATA1,ZONE1))^2 (NSA_ERR(ELEV,ZONE1))^2; ...
(NSA_ERR(DATA,FZONE))^2 (NSA_ERR(DATA1,FZONE))^2 (NSA_ERR(ELEV,FZONE))^2;  ...
1-((NSA_ERR(DATA,FZONE))^2/(NSA_ERR(DATA,ZONE1))^2 )...
1-((NSA_ERR(DATA1,FZONE))^2/(NSA_ERR(DATA1,ZONE1))^2 ) ...
1-((NSA_ERR(ELEV,FZONE))^2/(NSA_ERR(ELEV,ZONE1))^2 )] 

RSQINDV(3,1)*RSQINDV(3,2)*RSQINDV(3,3)*RSQINDV(3,3)
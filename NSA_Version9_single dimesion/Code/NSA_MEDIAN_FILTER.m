clc
FZONEM=FZONE;
% IDS=(find (DATA >0));
% Filt_Label = medfilt1(FZONE(IDS),3);
% FZONEM=FZONE;
% for j=1:1:length(IDS)
%     FZONEM(IDS(j)) =Filt_Label(j);
% end

% FZONEM = medfilt2(FZONE, 'zeros');
% FZONEM=ordfilt2(FZONE,6,true(3));

[row col] = size(DATA);
for ii=1:col
Filt_Label = medfilt1(FZONE(:,ii),3);
FZONEM(:,ii)= Filt_Label;
end
for ii=1:row
Filt_Label = medfilt1(FZONEM(ii,:),3);
FZONEM(ii,:)= Filt_Label;
end

figure(4)
surf(LON,LAT,FZONE)
view([0,90])
colormap(GRAY)
colorbar

figure(5)
surf(LON,LAT,FZONEM)
view([0,90])
colormap(GRAY)
colorbar

FZMRMSE = NSA_ERR(DATA,FZONEM);
NSA_RSQRM=(Z1RMSE-FZMRMSE)/Z1RMSE;

for i=1:1:max(FZONEM(:)),
    NSA_STATS11M(i,:)=[ (min(DATA(find(FZONEM==i)))) (mean(DATA(find(FZONEM==i))))... 
    (median(DATA(find(FZONEM==i)))) (mode(DATA(find(FZONEM==i))))...
    (max(DATA(find(FZONEM==i)))) (range(DATA(find(FZONEM==i))))... 
    (std(DATA(find(FZONEM==i)))) (var(DATA(find(FZONEM==i))))];
end
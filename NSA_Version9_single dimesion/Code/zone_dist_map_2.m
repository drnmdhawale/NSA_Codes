clc

FZONE2=FZONE;  % Clone the NSA derived zones
%# sample grayscale image
[ZH,ZW,~] = size(FZONE);
S=[ZH,ZW];
t = linspace(0, 2*pi, 50);   %# approximate circle 

 for NSA_ZONES=5:max(FZONE(:))    % to scan each independant zone
 ZIND1=[]; %clear variables on referenced memory
 ZIND1=find(FZONE==NSA_ZONES); % get the reference memory locations on all pixels inside the selected zone
COUNT3=[]; COUNT4=[];
 for r =1: 1: max(S); %loop to change circle radius
  
for CEN=1:length(ZIND1) % get the first original referenced position
%     COUNT=0;
    %# circle params
                    %# radius
[row,col]=ind2sub(S,ZIND1(CEN));
c = [col row];               %# center
%# get circular mask
BW = poly2mask(r*cos(t)+c(1), r*sin(t)+c(2), ZH, ZW);
COUNT1=length(find(FZONE(find(BW==1)) ~= NSA_ZONES))/length(find(FZONE(find(BW==1)) == NSA_ZONES));
COUNT3(CEN, r) = COUNT1;
COUNT2= length(find(FZONE(find(BW==1)) == NSA_ZONES));
COUNT4(CEN, r) = COUNT2;
 end

 end
 
 summary=[max(COUNT3);max(COUNT4);max(COUNT3)./max(COUNT4) ];
%  figure(1); plot(summary(3,:))
%  waitforbuttonpress
%  minsum=find(summary(3,:) == min(summary(3,:)));
 der =diff(summary(3,:))
 minsum1=find (der > 0 )
 minsum =minsum1(1);
 numb_cells =summary(2,minsum)
 PII(1: length(find(COUNT4(:,minsum) == numb_cells)),:) =find(COUNT4(:,minsum) == numb_cells)
 FZONE2(ZIND1(PII))=0;
 figure(2);
 surf(LON,LAT,FZONE2)
 view([0,90])
% clear  minsum num_cells PII;
% clear summary der minsum1
 end
%  plot(ans(3,:))
 
% %# show cropped image
% imshow( immultiply(img,BW) )
% axis on
% max(COUNT1)
% FZONE2=FZONE;  % Clone the NSA derived zones
% FZONE2(ZIND1(20))=0;
% FZONE2(ZIND1(21))=0;
% FZONE2=FZONE;  % Clone the NSA derived zones
% FZONE2(ZIND1(17))=0;
% surf(LON,LAT,FZONE2)
% view([0,90])

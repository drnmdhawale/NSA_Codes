clc
FZONE2=FZONE;  % Clone the NSA derived zones
%# sample grayscale image
[ZH,ZW,~] = size(FZONE);
S=[ZH,ZW];
t = linspace(0, 2*pi, 500);   %# approximate circle 

for NSA_ZONES=3%:max(FZONE(:))    % to scan each independant zone
X=[];Y=[];Z=[];
PPI1=[]; PPI2=[]; tp=[]; 
summary=[]; ZIND1=[]; %clear variables on referenced memory

ZIND1=find(FZONE==NSA_ZONES); % get the reference memory locations on all pixels inside the selected zone
COUNT3=[]; COUNT4=[];
for r =0.5:max(S-2.5); %loop to change circle radius
  
for CEN=1:length(ZIND1) % get the first original referenced position
    %# circle params
    
[row,col]=ind2sub(S,ZIND1(CEN)); %# radius
c = [col row];                   %# center

%# get circular mask
BW = poly2mask(r*cos(t)+c(1), r*sin(t)+c(2), ZH, ZW);
% BW(find(FZONE~= NSA_ZONES))=0;

COUNT1=length(find(FZONE(find(BW==1)) == NSA_ZONES))/length(find(FZONE(find(BW==1))));
COUNT3(CEN, r+0.5) = COUNT1;
COUNT2= length(find(FZONE(find(BW==1)) == NSA_ZONES));
COUNT4(CEN, r+0.5) = COUNT2;

end

end
 
summary=[max(COUNT3);max(COUNT4)];
tp=find(summary(1,:)==1);
cellcount = max(summary(2,tp(end)));   %%% perhaps not correct
PPI1= find(COUNT4(:,tp(end))==cellcount); %%% perhaps not correct
% cellcount = max(summary(1,tp(end)));
% PPI1= find(COUNT3(:,tp(end))==cellcount);

ii=1;

if length(PPI1) == 1 
   PPI=PPI1;
   ii=tp(end);
else
    PPI2= PPI1;
end

ii= tp(end);
jj=1;

while length(PPI2)>1,
    cellcount = max(COUNT4(PPI1,tp(end)+jj)); %%% perhaps not correct
    PPI= find(COUNT4(PPI1,tp(end)+jj)==cellcount); %%% perrhaps not correct
    PPI=PPI1(PPI); %%% perhaps not correct
    
%     PPI= COUNT3(PPI1,tp(end)+jj); 
%     PPI=PPI1(find(PPI==max(PPI)));
    PPI2=PPI;
    
    if (ii+jj) >= r-0.5,
        if length(PPI2)>1;
            PPI=PPI(1);
            jj=0;
        end
        break;
    end
    
jj = jj+1;
 
end
 
ii=ii+jj-1;
% if length(PPI1) > 1 
%     cellcount = max(COUNT4(PPI1,tp(end)+1));
%     PPI= find(COUNT4(PPI1,tp(end)+1)==cellcount);
%     PPI=PPI1(PPI);
% end   
% 
% if length(PPI) > 1 
%     cellcount = max(COUNT4(PPI1,tp(end)+2));
%     PPI= find(COUNT4(PPI1,tp(end)+2)==cellcount);
%     PPI=PPI1(PPI);
% end
%  
% if length(PPI) > 1 
%     cellcount = max(COUNT4(PPI1,tp(end)+3));
%     PPI= find(COUNT4(PPI1,tp(end)+3)==cellcount);
%     PPI=PPI1(PPI);
%  end

figure(2);
surf(LON,LAT,FZONE)
view([0,90])

figure(3);
FZONE2(ZIND1(PPI))=NSA_ZONES+1;
surf(LON,LAT,FZONE2)
axis([min(LON(:)) max(LON(:)) min(LAT(:)) ...
    max(LAT(:)) min(FZONE2(:)) max(FZONE2(:))])
view([0,90])
hold on
[row,col]=ind2sub(S,ZIND1(PPI)); %# radius
c = [col row];                   %# center
Y = (ii-0.5)*20*sin(t)+((row*20)-0.5);  
X = (ii-0.5)*20*cos(t)+((col*20)-0.5);
Z = Y;
Z(:) = NSA_ZONES;
fill3(X,Y,Z,NSA_ZONES)

clear Y X Z

end
 

 

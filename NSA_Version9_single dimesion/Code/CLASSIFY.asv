% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com% Function to convert GPS co-ordinates into metric units.
% Written by Nandkishor Dhawale,  August 2011

% The Main Algorithm

function [DATA FZONE NSA_RMSE NSA_CLS] = CLASSIFY()
clear ; clc % memory management
load NSA_DATA1 %load intermediatetly saved data
%DATA=DATA1; % to change the data layer to be used
zzz=1; % iteration index
Z1RMSE = NSA_ERR(DATA,ZONE1) % calculate  RMSE/MSE for the intial group
NSA_RMSE(1)=Z1RMSE; %save the initial RMSE/MSE value in memory.
NSA_CLS(1)=1; %save the initial k value in memory.
zzz=zzz+1; % increment the interation index

[rr cc]=size(DATA); % get row and col information from input data layer
S=[rr,cc]; I=1; % parameters used during conversion between matrix and vectors
ZONE=ZONE1; K=2; GG=0;
FZRMSE=Z1RMSE; BB=0;
ZGROWTH=0;GET_ZONE_VAL=0;

NSA_RSQR=(Z1RMSE-FZRMSE)/Z1RMSE; % calculate  R2 for the intial group

% figure to plot the initial error and performace values
figure(1) % MSE/RMSE and R2
subplot(2,1,1); plot(1,FZRMSE,'--rs','LineWidth',2,... 
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10);
grid on; hold on
ylabel (' MSE', 'FontWeight','bold' )

subplot(2,1,2); plot(1,NSA_RSQR,'--bs','LineWidth',2,... 
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',10);
grid on; hold on
ylabel (' R^2', 'FontWeight','bold' )

xlabel( 'Group number', 'FontWeight','bold')

% Surface plot for input data layer
view(2)
figure(2)
surf(LON,LAT,DATA)
view([-10,80])
colormap(GRAY)
colorbar
NSA_FIGURE() % predefined routine for  graphical display



while (GG~=1),
    j=1; 
    ELMT=find(ZONE<=K & ZONE~=0); % find all points in data that are not 0
    
%% code to find group centers resulting in lowest RMSE/MSE.
% this code is to search for a new uniform groups within the area of the 
% present zone and to establish it as the base. 

for i=1:1:length(ELMT)
    IND=ELMT(i); [row,col]=ind2sub(S,IND);
    
   ZWINDOW=ZONE(row-I:row+I,col-I:col+I); % window of 3 X 3 cells
%ZWINDOW=ZONE([IND-1 IND IND+1 IND-rr IND+rr]); % other method
    NHOOD_VALID = NSA_NHOOD_VALID(ZWINDOW);  % check for valid elements, 
                                             % if valid element then 1 else 0
    
    if NHOOD_VALID > 0,
        ZONE(row-I:row+I,col-I:col+I)=K;
        RMSE = NSA_ERR(DATA,ZONE);
        E(i,:)=[IND RMSE];
        ZONE(row-I:row+I,col-I:col+I)= ZWINDOW;
    end
end 

CAND=sortrows(E,2);clear E   % sort in order
CAND((find(CAND(:,1)==0)),:)=[];
IND=CAND(1);  % pick the first and smallest element
[row,col]=ind2sub(S,IND);
ZWINDOW1=ZONE(row-I:row+I,col-I:col+I);
ZONE(row-I:row+I,col-I:col+I)=K;
RMSE= NSA_ERR(DATA,ZONE);

if RMSE >= FZRMSE,
    disp([K RMSE FZRMSE])
    ZONE(row-I:row+I,col-I:col+I)= ZWINDOW1;
    break;
else
    disp('Opened a new group consisting of 3 x 3 cells')
    K
disp('ZONE NEWRMSE OLDRMSE')
disp([K RMSE FZRMSE])
end


%%
%The next part of the code is to find all the neighbourhood indices of the the new
%uniform group

ZGROW =1;  %Flag to let or not let to grow
while (ZGROW==1),
ZGROWTH=0;    % flag 
TEMP_IND=find(ZONE~=K & ZONE~=0); % get a indices of all cells
STR_NBRS=0; % flag

% code to selet only neighbour cell elements among all
for i=1:1:length(TEMP_IND)
    IND=TEMP_IND(i); 
    NBR_VALID = NSA_NBR_VALID(IND, ZONE);
    if NBR_VALID ==1,
        STR_NBRS(i)=IND;
    end
    
    STR_NBRS(STR_NBRS==0)=[]; % store potential neighbors
    
end

% the next part of the code is to check the value of stored neighbor
% indices and to decide the strategy to grow the cluster

%% now its time to define what are the strategies
for i=1:1:length(STR_NBRS)
    
 if ZONE(STR_NBRS(i))==1, 
 GS1RMSE=NSA_ERR(DATA,ZONE); %Error before zone growth
 ZONE(STR_NBRS(i))=K; 
 GS1E=NSA_ERR(DATA,ZONE); %Error after zone growth
 
 if GS1E > GS1RMSE
 ZONE(STR_NBRS(i))=1;
 FZRMSE=GS1RMSE;
 else
     FZRMSE=GS1E;
     ZGROWTH=ZGROWTH+1;
 end
 
  elseif ZONE(STR_NBRS(i))== K-1 & ZONE(STR_NBRS(i))~=1,
     GS2RMSE=NSA_ERR(DATA,ZONE); %Error before zone growth
     TEMPKS2=find(ZONE==K);
     ZONE(find(ZONE==K))=K-1;
     GS2E=NSA_ERR(DATA,ZONE); %Error after zone growth
     if  GS2E > GS2RMSE,
         ZONE(TEMPKS2)= K;
         FZRMSE=GS2RMSE;
     else
         FZRMSE=GS2E;
         ZGROWTH=ZGROWTH+1;
         K=K-1;
         break,
     end
     
  elseif ZONE(STR_NBRS(i))<K-1 & ZONE(STR_NBRS(i))~=1,
     GS3RMSE=NSA_ERR(DATA,ZONE); %Error before zone growth
     TEMPK=ZONE(STR_NBRS(i));
     TEMPKS3= find (ZONE == K);
     ZONE(find(ZONE==K))=TEMPK;
     GS3E=NSA_ERR(DATA,ZONE); %Error after zone growth
     if  GS3E > GS3RMSE,
          ZONE(TEMPKS3)= K;
          FZRMSE=GS3RMSE;
     else
         FZRMSE=GS3E;
         ZGROWTH=ZGROWTH+1;
         K=K-1;
         break
     end
 
 end
 
 if i==length(STR_NBRS),
                
            if ZGROWTH ==0,
                if length(ZONE(find(ZONE==K)))<10,
                ZONE(find(ZONE==K))=max(ZWINDOW1(:)); 
                BB=1; K=K-1;
                
            end
          ZGROW=0;
            end
 end

% Surface plot for output layer map
figure(3)
surf(LON,LAT,ZONE)
view([0,90])
colormap(GRAY)
colorbar
NSA_FIGURE()
end

end 
%%

% save values of the important variables in memory
NSA_RMSE(zzz,1)=FZRMSE;
NSA_RSQR=(Z1RMSE-FZRMSE)/Z1RMSE;
NSA_CLS(zzz,1)=K; 
zzz=zzz+1;

% figure to plot the runtime error and performace values
figure(1)
subplot(2,1,1); plot(K,FZRMSE,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10);
grid on; hold on
ylabel (' MSE', 'FontWeight','bold' )

subplot(2,1,2); plot(K,NSA_RSQR,'--bs','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',10);
grid on; hold on
ylabel (' R^2', 'FontWeight','bold' )

xlabel( 'Group number', 'FontWeight','bold')
%%
if BB==1,
    BB=0;
    GG=1;
else
K=K+1;
end

% waitforbuttonpress
end

% report the final output matrices
DATA; % input data layer
FZONE=ZONE; % the output map
NSA_RMSE; % the error values
NSA_CLS;% the number of groups


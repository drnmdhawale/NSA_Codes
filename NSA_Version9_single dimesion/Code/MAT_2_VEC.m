% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com
function MAT_2_VEC(FZONE, DATA)
clc

    
    %B4(nan_ind1)=NaN; % assign the remaining elements to NaN
    MSEE= NSA_ERR(DATA,FZONE)% show MSE
%%
load NSA_DATA1

Y=DATA(:);
Y(Y==0)=[];
 % choose variables on which we want to operate the clustering process 
for p=1:1:max(FZONE(:)),
v(p)=length(FZONE(FZONE==p));
end
for zz=1:1:30,

k=length(v(v~=0))
%k=3;
%kmedoids(Y,k);  % call the clustering function

IDX = kmeans(Y,k);
%% plotting cluster graphs after clustering operation
% label = ans;
label = IDX;
     
%B4(nan_ind1)=NaN; % assign the remaining elements to NaN
MSE(zz,1) = NSA_ERR(Y,label);% show MSE
end

waitforbuttonpress

Q=mean(MSE);

low_per=min(MSE);
quart= prctile(MSE,25);
med=median(MSE);
avg=mean(mean(MSE));
quarant=prctile(MSE,75);
up_per=max(MSE);
MSEE=MSEE;
[low_per;quart;avg;med;quarant;up_per;MSEE]

MSE=[MSE,MSE,MSE];
MSE(:,2)=Q; MSE(:,3)=MSEE;
figure(5);plot(MSE,'.-.')
grid on
Title('Comparison between Kmedoid and our spatial clustering')
xlabel('Trial Number')
ylabel('MSE')
legend MSE(Kmedoid) MSE(Average) MSE(Spatial)




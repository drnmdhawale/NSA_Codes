load NSA_DATA1
clc
CZONE=ZONE1; ppi(1)=0; % Clone the initial zone
FZONE2=FZONE;  % Clone the NSA derived zones

for NSA_ZONES=1:max(FZONE(:))    % to scan each independant zone

ZIND1=[]; ZIND2=[]; %clear variables on referenced memory
ZIND1=find(FZONE==NSA_ZONES); % get the reference memory locations on all pixels inside the selected zone
ZIND2=ZIND1; % Clone the references

for CEN=1:length(ZIND1) % get the first original referenced position
    DIST1=[];   DIST=0;
    for CEN1=1:length(ZIND2) % get the cloned reference position
%         DIST=(DATA(ZIND1(CEN))-DATA(ZIND2(CEN1)))^2; % if we use data
        DIST= sqrt ( (LAT(ZIND1(CEN))-LAT(ZIND2(CEN1)))^2 + (LON(ZIND1(CEN))-LON(ZIND2(CEN1)))^2); % calculate distances
        DIST1(CEN1)=DIST;
        
        if CEN1 >=length(ZIND2); % if end of cloned references positions
            DIST=sum(DIST1)/(length(ZIND1)-1);  % calculate the average of distances
            CZONE(ZIND1(CEN))=DIST; %assign the distance to the original referenced position
        end  % end of if
    
    end %end of for loop 3
    
end %end of for loop 2

mindist=find(CZONE == min(CZONE(find(FZONE==(NSA_ZONES)))));  % calculate the minimum of distances
ppi(NSA_ZONES)= mindist(1); % assign the minimum of all as the  potential point of interest

end % end of for loop 1

FZONE2(ppi)=0;
figure(5)
surf(LON,LAT,FZONE)
view([0,90])
figure(6)
surf(LON,LAT,FZONE2)
view([0,90])

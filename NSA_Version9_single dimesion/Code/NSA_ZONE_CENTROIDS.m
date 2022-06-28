%%% SOC
% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com
function NSA_ZONE_CENTROIDS(FZONE)
[rows cols] = size(FZONE);
y = 1:rows; x = 1:cols;
[X Y] = meshgrid(x,y);
for i=1:1:max(FZONE(:)),
    cY(i) = median(Y(FZONE==i));
    cX(i) = median(X(FZONE==i));
end
FIMG = label2rgb(FZONE); 

figure(4);
image(FIMG); %convert data into image
title('Final Classified Zones')
xlabel('Easting --->')
ylabel('<--- Northing')
for i=1:1:max(FZONE(:)),
    
figure(4); hold on;
plot(cX(i),cY(i),'s','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8)
            
end
[rr cc]=size(FZONE); S=[rr,cc]; I=1;

for i=1:1:max(FZONE(:)),
BBB=[ find(FZONE==i) ((DATA(find(FZONE==i))-mode(DATA(find(FZONE==i)))).^2)];
BBB=sortrows(BBB,2);
[row,col]=ind2sub(S,BBB(1))
cY(i)=row; cX(i)=col; clear BBB
end

FIMG = label2rgb(FZONE); 
figure(4);
image(FIMG); %convert data into image
title('Final Classified Zones')
xlabel('Easting --->')
ylabel('Northing ---> ')
for i=1:1:max(FZONE(:)),
    
figure(4); hold on;
plot(cX(i),cY(i),'s','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8)
            
end



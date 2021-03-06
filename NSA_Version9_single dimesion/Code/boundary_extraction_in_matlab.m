% A = label2rgb(LON);
% image(A);
% A=imread('test.jpg');
% C=rgb2gray(A);
% C(C<225)=0;
% s=strel('disk',4,0);%Structuring element
% D=~im2bw(C);%binary Image
% F=imerode(D,s);%Erode the image by structuring element
% figure,imshow(A);title('Original Image');
% figure,imshow(D);title('Binary Image');
% figure,imshow(D-F);title('Boundary extracted Image');


% I = imread('test.jpg');
% figure,imshow(A);title('Original Image');
% BW = im2bw(I, graythresh(I));
% figure,imshow(BW);title('Binary Image');
% [B,L] = bwboundaries(BW,'noholes');
% 
% figure, imshow(label2rgb(L, @jet, [.7 .7 .7]))
% hold on
% for k = 1:length(B)
%     boundary = B{k};
%     plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
% end

%% Read Image
a=imread('FIELD5-CNTD.png');
%% Show Image
imshow(a);
%% Gray-Scale Image
b= rgb2gray(a);    
imshow(b)
%% Median Filtered Image
Y=medfilt2(b,[5 5]);
figure(2);  
imshow(Y);
%% Bi-modal Histogram
imhist(Y)  
%% BW Image
subplot(1,2,1), imshow(Y); 
subplot(1,2,2), imshow(im2bw(Y))
%% Write Image
Z=im2bw(Y);
imshow(Z)
imwrite(Z,'pre.jpg','quality',10)
%% Morphological Opening
I = imread('pre.jpg');
se = strel('disk',10);
I_opened = imopen(I,se);
figure, imshow(I_opened,[])
imwrite(I,'open.jpg','quality',10)
%% Morphological Closing
originalBW = imread('open.jpg');
se = strel('disk',10);
closeBW = imclose(originalBW,se);
figure, imshow(closeBW)
imwrite(closeBW,'close.jpg','quality',10)
%% Image Boundary 
J = imread('close.jpg');
BW = im2bw(I, graythresh(I));
[B,L] = bwboundaries(BW,'noholes');
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
%% Boundary Extraction
I= imread('close.jpg');
dim = size(BW);
col = round(dim(2)/2)-90;
row = find(BW(:,col), 1 );
boundary = bwtraceboundary(BW,[row, col],'N');
imshow(I)
plot(boundary(:,2),boundary(:,1),'k','LineWidth',3);
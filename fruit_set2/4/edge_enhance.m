function [ I2 ] = edge_enhance( I )
% I = rgb2gray(I);
% imshow(I);
I2 = I;
BW1 = edge(I,'Canny',0.1,'horizontal',0.1);

se = strel('square',1);
BW1 = imdilate(BW1,se,2);
BW1 = imerode(BW1,se,2);
% BW1 = imdilate(BW1,se,2);

L = bwlabel(BW1);
S = regionprops(L, 'all');
BW2 = ismember(L, find([S.Area]>=100 ));




for i = 1:size(BW2,1)

for j = 1:size(BW2,2)

   pixel = BW2(i,j);
   if(pixel == 1)
    
       I2(i,j) = 0;


   end

end

end





% figure
% imshowpair(BW2,I2,'montage')


end


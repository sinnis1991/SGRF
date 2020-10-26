function [ bw,num,S ] = bi_process( im, threshold )

%the input im must be a gray-scale image
%the threshold ranges 0-255

j = im2bw(im,threshold/255);
se = strel('square',5);
j = imdilate(j,se);
j = imerode(j,se);
L = bwlabel(j);
S = regionprops(L, 'all');
bw = ismember(L, find([S.Area]>=20 ));
S = regionprops(bw, 'all');
[bw,num] = bwlabel(bw);



end


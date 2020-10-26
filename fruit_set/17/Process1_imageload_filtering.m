J=imread('17.jpg');
I = rgb2gray(J);
imsize = 400*300
imsize_real = size(I,1)*size(I,2);
alpha = sqrt(imsize_real/imsize);
I = imresize(I,[size(I,1)/alpha,size(I,2)/alpha]);
                                                       %to enhance the edge in order to seperate different obj 

I=double(I)/255;

%bilateral filter
w = 3;       % bilateral filter half-width
sigma = [10 1]; % bilateral filter standard deviations

% I = edge_enhance(I); 
 Is=bfilter2(I,w,sigma);
 Is = edge_enhance(Is); 

figure
imshow(Is);
%
bwSet = {};

maxNum = 0;
figure
imshow(rgb2gray(imresize(J,[size(J,1)/alpha,size(J,2)/alpha])));
step = 5;
color = [0,1,0];
 for i = 1:step:255
   
     Is2 = Is;
%      for x =1:size(Is,1)
%          for y = 1:size(Is,2)
%              if Is(x,y) == 0
%                  Is2(x,y) = i;
%              end
%          end
%      end
     
j = im2bw(Is2,i/255);
se = strel('square',5);
j = imdilate(j,se);
j = imerode(j,se);
L = bwlabel(j);
S = regionprops(L, 'all');
bw = ismember(L, find([S.Area]>=20 ));

%boundary = bwboundaries(bw);
[bw2,num] = bwlabel(bw);
S = regionprops(bw2, 'all');
boundary = bwboundaries(bw2,'noholes');
%boundary = bwboundaries(bw2);
if(num>maxNum)
    maxNum=num;
end

bwIm.bw = bw2;
bwIm.num = num;
bwIm.stats = S;
if num==0
    break
end
bwSet{length(bwSet)+1} = bwIm; 
% imshow(bw2);

   for h =1:size(boundary)

      B = boundary{h};
      hold on;
      plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
  
   end
   
   if(size(boundary,1)~=num)
       fprintf('B: %d N: %d \n',size(boundary,1),num);
   end
 end
 
filename = 'test_data';
origin_im = imresize(J,[size(J,1)/alpha,size(J,2)/alpha]);
filtered_im = Is;

save(filename,'bwSet','origin_im','filtered_im','step');
 
 
 
 
 
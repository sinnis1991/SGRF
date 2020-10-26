J=imread('test_im.jpg');
I = rgb2gray(J);
imsize = 400*300;
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
 imshow(Is);
%  Is = edge_enhance(Is); 
%{
% figure
% imshow(Is);
% figure
% imshow(rgb2gray(imresize(J,[size(J,1)/alpha,size(J,2)/alpha])));

% j = im2bw(Is,125/255);
% se = strel('square',5);
% j = imdilate(j,se);
% j = imerode(j,se);
% L = bwlabel(j);
% S = regionprops(L, 'all');
% bw = ismember(L, find([S.Area]>=20 ));
% S = regionprops(bw, 'all');
% [bw,num] = bwlabel(bw);
 %}
[bw,num,S] = bi_process(Is,125);
rgb = label2rgb(bw,'jet',[.5 .5 .5]);
figure 
imshow(rgb);


%{
j2 = im2bw(Is,130/255);
se = strel('square',5);
j2 = imdilate(j2,se);
j2 = imerode(j2,se);
L2 = bwlabel(j2);
S2 = regionprops(L2, 'all');
bw2 = ismember(L2, find([S2.Area]>=20 ));
S2 = regionprops(bw2, 'all');
[bw2,num2] = bwlabel(bw2);
%}
[bw2,num2,S2] = bi_process(Is,130);
rgb = label2rgb(bw2,'jet',[.5 .5 .5]);
figure 
imshow(rgb);

innerID = {};
num1 = num;
 for n = 1:num1
     innerID{length(innerID)+1} = [n];
 end
  check = ones(num2,1);
  while(sum(check)>0)
        for m = 1:size(bw2,1)
            for n = 1:size(bw2,2)
                
                numIn2 = bw2(m,n);
                numIn1 = bw(m,n);
                
                if(numIn2~=0 & numIn1~=0)
                    Nindex = innerID{1,numIn1};
                    if(ismember(numIn2,Nindex(2:end,1))==0)
                        innerID{numIn1} = [innerID{numIn1};numIn2];
                        check(numIn2)=0;
                    end
                end 
                
            end
        end
  end
 
  for n = 1:size(innerID,2)
      if length(innerID{n})==3
          index = innerID{n};
          % solve the problem of 2 regions mergin into 1
            mother_bw = S(index(1)).PixelList;
            child_1  = S2(index(2)).PixelList;
            child_2  = S2(index(3)).PixelList;  
            ridge =ridgeList(mother_bw,child_1,child_2,2);
            bw = PixelList2im(bw,ridge,0);
            
      elseif length(innerID{n})>3
           index = innerID{n};
           mother_bw = S(index(1)).PixelList;
           child_num = length(index)-1;
           child = {};
           for k = 1:child_num
               child{length(child)+1} = S2(index(k+1)).PixelList;
           end
           
           for a = 1:child_num-1
               for b = (a+1):child_num
                   child_1 = child{a};
                   child_2 = child{b};
                   ridge =ridgeList(mother_bw,child_1,child_2,2);
                   if_e = false;
                   for e = 1:child_num
                      child_check = child{e};
                      if_e = if_exist(ridge,child_check);
                         if if_e == true
                            break;
                         end
                   end
                   if if_e == false
                    bw = PixelList2im(bw,ridge,0);
                   end
               end
           end
               
      end
  end
  
%   mother_bw = S(13).PixelList;
%   child_1  = S2(28).PixelList;
%   child_2  = S2(22).PixelList;  
%   child_3  = S2(14).PixelList;
% 
%   bw_new = zeros(size(bw2,1),size(bw,2));
%   rgb = PixelList2im(bw_new,mother_bw,1);
%   rgb = PixelList2im(rgb,child_1,2);
%   rgb = PixelList2im(rgb,child_2,3);
%   rgb = PixelList2im(rgb,child_3,4);
%   rgb_im = label2rgb(rgb,'jet',[.5 .5 .5]);
%   figure;
%   imshow(rgb_im)
% 
%   
%   ridge =ridgeList(mother_bw,child_2,child_3,2);

%   rgb = PixelList2im(rgb,ridge,5);
%   rgb_im2 = label2rgb(rgb,'jet',[.5 .5 .5]);
%   figure;
%   imshow(rgb_im2)
  
  
  
[bw,num] = bwlabel(bw);
rgb = label2rgb(bw,'jet',[.5 .5 .5]);
figure 
imshow(rgb);
  
pause;
% clear;
  
  
  
  
  
  
J=imread('im.jpg');
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
%________________________________________________________________________________________________
bwSet = {};
index = {};

%record the first layer
[bw,num,S] = bi_process(Is,254);
InnerID = find_index(bw,zeros(size(bw)));
bwIm.bw = bw;
bwIm.num = num;
bwIm.stats = S;
bwSet{1} = bwIm;
index{1} = InnerID;

 for i = step:step:250
     
     threshold = 254-i;
     
     if i>100 && i<235
         [bw,num,S] = bi_process(Is,threshold);
         bw2 = bwSet{1,i/step}.bw;
         num2 = bwSet{1,i/step}.num;
         S2 = bwSet{1,i/step}.stats;
         
         [bw_new, InnerID] = seg_bw(bw,bw2,2);
         [bw,num] = bwlabel(bw_new);
         S = regionprops(bw, 'all');
         bwIm.bw = bw;
         bwIm.num = num;
         bwIm.stats = S;
         bwSet{i/step+1} = bwIm;
         index{i/step+1} = InnerID;
         
         boundary = bwboundaries(bw,'noholes');
     
     for h =1:size(boundary)

      B = boundary{h};
      hold on;
      plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
  
   end
         
         fprintf('layer:%d and it is segmenated \n',i/step+1);
         
     else
         [bw,num,S] = bi_process(Is,threshold);
         bwIm.bw = bw;
         bwIm.num = num;
         bwIm.stats = S;
         bwSet{i/step+1} = bwIm;
         
         bw2 = bwSet{1,i/step}.bw;
         num2 = bwSet{1,i/step}.num;
         S2 = bwSet{1,i/step}.stats;
         
         InnerID = find_index(bw,bw2);
         index{i/step+1} = InnerID;
         
         boundary = bwboundaries(bw,'noholes');
     
     for h =1:size(boundary)

      B = boundary{h};
      hold on;
      plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
  
   end
         fprintf('layer:%d \n',i/step+1);

     end  
     
 end
 
filename = 'data';
origin_im = imresize(J,[size(J,1)/alpha,size(J,2)/alpha]);
filtered_im = Is;
bwSet_new = {};
for i =1:51
bwSet_new{i}=bwSet{51-i+1};
end 
index_new = {};
for i =1:51
index_new{i} = index{51-i+1};
end
bwSet = bwSet_new;
index = index_new;
save(filename,'bwSet','origin_im','filtered_im','step','index');

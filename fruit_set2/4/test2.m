J=imread('18.jpg');
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
Is=bfilter2(I,w,sigma);
Is = edge_enhance(Is); 


[bw,num,S] = bi_process(Is,125);
rgb = label2rgb(bw,'jet',[.5 .5 .5]);
figure 
imshow(rgb);



[bw2,num2,S2] = bi_process(Is,130);
rgb = label2rgb(bw2,'jet',[.5 .5 .5]);
figure 
imshow(rgb);


[bw_new, ix] = seg_bw(bw,bw2,2);
[bw_new,num_] = bwlabel(bw_new);
rgb = label2rgb(bw_new,'jet',[.5 .5 .5]);
figure 
imshow(rgb);

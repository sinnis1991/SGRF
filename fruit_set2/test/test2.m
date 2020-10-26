filename = 'data';
load(filename);


% [bw,num,S] = bi_process(Is,125);
i = 17
bw = bwSet{i}.bw;
S = bwSet{i}.stats;
rgb = label2rgb(bw,'jet',[.5 .5 .5]);
figure 
imshow(rgb);



% [bw2,num2,S2] = bi_process(Is,130);
bw2 = bwSet{i+1}.bw;
S2 = bwSet{i+1}.stats;
rgb = label2rgb(bw2,'jet',[.5 .5 .5]);
figure 
imshow(rgb);

[bw3,num3,S3 ] = bi_process(Is,84);
rgb = label2rgb(bw3,'jet',[.5 .5 .5]);
figure 
imshow(rgb);

[bw_new, ix] = seg_bw(bw3,bw2,2);
[bw_new,num_] = bwlabel(bw_new);
rgb = label2rgb(bw_new,'jet',[.5 .5 .5]);
figure 
imshow(rgb);

load('test_data');
% load('lianziG_data');
% load('fruit4_data');
% draw contours
% subplot(1,2,1);
%  figure
%  imshow(rgb2gray(origin_im));
% for i = 1:size(bwSet,2)
%     
%     bwimage = bwSet{i}.bw;
%     boundary = bwboundaries(bwimage);
%     color = [0,1,0];
%     for j = 1 :size(boundary)
%     B = boundary{j};
%     hold on;
%     plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
%     
%     end
%      clear B boundary color;
% end

% figure
% imshow(rgb2gray(origin_im));

%draw lines
% for i = 1:size(index,2)
%     innerID = index{i};
%     for j = 1:size(innerID,2)
%     
%     conner =  innerID{j};
%     
%     if(size(conner,1)>1)
%         
%         num1 = conner(1);
%         centroid1 = bwSet{i}.stats(j).Centroid;
%         x1 = centroid1(1);
%         y1 = centroid1(2);
%         
%         for n = 1:size(conner,1)-1
%         num2 = conner(n+1);
%         centroid2 = bwSet{i+1}.stats(num2).Centroid;
%         x2 = centroid2(1);
%         y2 = centroid2(2);
%         if(size(conner,1)>2)
%             color = 'r';
%         else
%             color = 'g';
%             
%         end
%         hold on
% %         if( ((x1-x2)^2+(y1-y2)^2)<1000 )
%         plot([x1,x2], [y1,y2],color, 'LineWidth', 0.1);
% %         end
%         
%         end
%         
%     end
%         
%     end
% end
% 
% %draw points
% for i = 1:size(bwSet,2)
%   
%     struct = bwSet{i}.stats;  
%     
%     
%     
%     for j =1:size(struct,1)
%     
%        Point = struct(j).Centroid;
%        hold on
%        plot(Point(1),Point(2),'yo');
%     
%     end
%     
%     
%     
%     
%     
% end

% draw selected region
%  subplot(1,2,2);
% figure
% imshow(rgb2gray(origin_im));
figure
imshow(rgb2gray(origin_im));
min_Bi  = 1.2;
for i = 1:size(index,2)
    innerID = index{i};
    
    bwimage = bwSet{i}.bw;
    boundary = bwboundaries(bwimage);
%     color = hsv2rgb([(step*(i-1)+1)/255 1 1]); 
    color = [0,0.9,0];
    
    
    for j = 1:size(innerID,2)
    
    conner =  innerID{j};
    
    if(size(conner,1)==1)
        B = boundary{conner(1)};
        hold on;
        area1 = bwSet{i}.stats(j).Area;
%         if(area1>1)
       plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 1);
%         end
    else if(size(conner,1)<3)
        %check
        area1 = bwSet{i}.stats(j).Area;
        area2 = bwSet{i+1}.stats(conner(2)).Area;
        
%         if(area1/area2<min_Bi && area1 >1)
          B = boundary{conner(1)};
          hold on;
          plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 1);
%         end

    else
        centroid1 = bwSet{i}.stats(j).Centroid;
        area1 = bwSet{i}.stats(j).Area;
        
        min_dis = 100000000;                                                       % this may change
        max_dis = 0;
        min_bi = 100000000;
        
        for n = 1:(size(conner,1)-1)
        
        num2 = conner(n+1);
        centroid2 = bwSet{i+1}.stats(num2).Centroid;
        area2 = bwSet{i+1}.stats(num2).Area;
        
        dis = sqrt(sum((centroid1 - centroid2).^2));
        bi = area1/area2;
        
           if(dis<min_dis)
            min_dis = dis;
           end
           if(dis>max_dis)
            max_dis = dis;
           end
           if(bi<min_bi)
            min_bi = bi;
           end   
        end
        
%         if(min_dis < 10 && max_dis<10 && min_bi<min_Bi && area1>1)
        B = boundary{conner(1)};
        hold on;
        plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 1);
%         end
        
        
    end
    
    
    end
    
    
    end
end












load('lianziG_data');

imshow(rgb2gray(origin_im));

first_index = index{end};
draw_list = [];

for j = 1:size(first_index,2)

    conner = first_index{j};

             for n =2:size(conner,1)
%                  draw_list(length(draw_list)+1) =conner(n) ;
                   draw_list = [draw_list;conner(n)];
             end

end

draw_list = unique(draw_list);

   bwimage = bwSet{end}.bw;
   boundary = bwboundaries(bwimage);
%    color = hsv2rgb([(step*(size(index,2)-1)+1)/255 1 1]);
      color = [0,1,0];
   for i = 1:size(draw_list)
          B = boundary{draw_list(i)};
          hold on;
          plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);

        end
   
   
   
   
   
   for i = 1:size(index,2)-11

    innerID = index{size(index,2)+1-i};
    new_draw_list = [];

              for j = 1:size(innerID,2)

                    conner = innerID{j};
                             if(length([draw_list;conner(2:end)])~=length(unique([draw_list;conner(2:end)])))
                                 new_draw_list = [new_draw_list;conner(1)] 
                             end

              end

              new_draw_list = unique(new_draw_list);
              new_draw_list2 = new_draw_list; 
              %this process filter the outler boundary  
              for n =1:size(new_draw_list)
              
              num = new_draw_list(n);     
              centroid1 = bwSet{size(index,2)+1-i}.stats(num).Centroid;
              area1 = bwSet{size(index,2)+1-i}.stats(num).Area;
        
              min_dis = 100000000;                                                       
              max_dis = 0;
              min_bi = 100000000000000;
              min_Bi = 100000000000000;
                 %find the conner
                 for m =1:size(innerID,2)
                   if(num==innerID{m}(1))
                    conner = innerID{m};
                    break;
                   end
                  end
                 %------------
                       %check if it suits
                       for n = 1:(size(conner,1)-1)
                          num2 = conner(n+1);
                          centroid2 = bwSet{size(index,2)+2-i}.stats(num2).Centroid;
                          area2 = bwSet{size(index,2)+2-i}.stats(num2).Area;
        
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
                      %--------------------
                      if(min_dis >30 || min_bi>min_Bi)
                          new_draw_list2(new_draw_list2 == num) =[];
                      end
              end
              %--------------------------------------
           
       bwimage = bwSet{size(index,2)+1-i}.bw;
       boundary = bwboundaries(bwimage);
       %color = hsv2rgb([(step*(size(index,2)-1)+1)/255 1 1]); %****

         for i = 1:size(new_draw_list2)
              B = boundary{new_draw_list(i)};
              hold on;
              plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
         end
    
      draw_list = new_draw_list2;
   
   end



first_index = index{end-1};
draw_list = [];

for j = 1:size(first_index,2)

    conner = first_index{j};

             for n =2:size(conner,1)
%                  draw_list(length(draw_list)+1) =conner(n) ;
                   draw_list = [draw_list;conner(n)];
             end

end

draw_list = unique(draw_list);
  draw_list = [2;4;6;9;10];
   bwimage = bwSet{end-1}.bw;
   boundary = bwboundaries(bwimage);

      color = [0,1,0];
   for i = 1:size(draw_list)
          B = boundary{draw_list(i)};
          hold on;
          plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);

        end

for i = 1:size(index,2)-11

    innerID = index{size(index,2)-i};
    new_draw_list = [];

              for j = 1:size(innerID,2)

                    conner = innerID{j};
                             if(length([draw_list;conner(2:end)])~=length(unique([draw_list;conner(2:end)])))
                                 new_draw_list = [new_draw_list;conner(1)] 
                             end

              end

              new_draw_list = unique(new_draw_list);
              new_draw_list2 = new_draw_list; 
              %this process filter the outler boundary  
              for n =1:size(new_draw_list)
              
              num = new_draw_list(n);     
              centroid1 = bwSet{size(index,2)-i}.stats(num).Centroid;
              area1 = bwSet{size(index,2)-i}.stats(num).Area;
        
              min_dis = 100000000;                                                       
              max_dis = 0;
              min_bi = 100000000000000;
              min_Bi = 100000000000000;
                 %find the conner
                 for m =1:size(innerID,2)
                   if(num==innerID{m}(1))
                    conner = innerID{m};
                    break;
                   end
                  end
                 %------------
                       %check if it suits
                       for n = 1:(size(conner,1)-1)
                          num2 = conner(n+1);
                          centroid2 = bwSet{size(index,2)+1-i}.stats(num2).Centroid;
                          area2 = bwSet{size(index,2)+1-i}.stats(num2).Area;
        
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
                      %--------------------
                      if(min_dis >30 || min_bi>min_Bi)
                          new_draw_list2(new_draw_list2 == num) =[];
                      end
              end
              %--------------------------------------
           
       bwimage = bwSet{size(index,2)-i}.bw;
       boundary = bwboundaries(bwimage);
       %color = hsv2rgb([(step*(size(index,2)-1)+1)/255 1 1]); %****

         for i = 1:size(new_draw_list2)
              B = boundary{new_draw_list(i)};
              hold on;
              plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
         end
    
      draw_list = new_draw_list2;
   
end
% 
k =2;
first_index = index{end-2};
draw_list = [];

for j = 1:size(first_index,2)

    conner = first_index{j};

             for n =2:size(conner,1)
%                  draw_list(length(draw_list)+1) =conner(n) ;
                   draw_list = [draw_list;conner(n)];
             end

end

% draw_list = unique(draw_list);
draw_list = [11;14];
   bwimage = bwSet{end-2}.bw;
   boundary = bwboundaries(bwimage);
%    color = hsv2rgb([(step*(size(index,2)-1)+1)/255 1 1]);
      color = [0,1,0];
   for i = 1:size(draw_list)
          B = boundary{draw_list(i)};
          hold on;
          plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
   end
        
   for i = 1:size(index,2)-11

    innerID = index{size(index,2)+1-i-k};
    new_draw_list = [];

              for j = 1:size(innerID,2)

                    conner = innerID{j};
                             if(length([draw_list;conner(2:end)])~=length(unique([draw_list;conner(2:end)])))
                                 new_draw_list = [new_draw_list;conner(1)] 
                             end

              end

              new_draw_list = unique(new_draw_list);
              new_draw_list2 = new_draw_list; 
              %this process filter the outler boundary  
              for n =1:size(new_draw_list)
              
              num = new_draw_list(n);     
              centroid1 = bwSet{size(index,2)+1-i-k}.stats(num).Centroid;
              area1 = bwSet{size(index,2)+1-i-k}.stats(num).Area;
        
              min_dis = 100000000;                                                       
              max_dis = 0;
              min_bi = 100000000000000;
              min_Bi = 100000000000000;
                 %find the conner
                 for m =1:size(innerID,2)
                   if(num==innerID{m}(1))
                    conner = innerID{m};
                    break;
                   end
                  end
                 %------------
                       %check if it suits
                       for n = 1:(size(conner,1)-1)
                          num2 = conner(n+1);
                          centroid2 = bwSet{size(index,2)+2-i-k}.stats(num2).Centroid;
                          area2 = bwSet{size(index,2)+2-i-k}.stats(num2).Area;
        
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
                      %--------------------
                      if(min_dis >30 || min_bi>min_Bi)
                          new_draw_list2(new_draw_list2 == num) =[];
                      end
              end
              %--------------------------------------
           
       bwimage = bwSet{size(index,2)+1-i-k}.bw;
       boundary = bwboundaries(bwimage);
       %color = hsv2rgb([(step*(size(index,2)-1)+1)/255 1 1]); %****

         for i = 1:size(new_draw_list2)
              B = boundary{new_draw_list(i)};
              hold on;
              plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
         end
    
      draw_list = new_draw_list2;
   
   end
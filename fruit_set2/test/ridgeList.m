function [ output_args ] = ridgeList( m,c1,c2,dist )


  dist_1 = bw_dist(c1,m);
  dist_2 = bw_dist(c2,m);

 list =[];
 
  for i =1:size(m,1)
      if abs(dist_1(i,3)-dist_2(i,3))<dist %&& dist_1(i,3)<10 && dist_2(i,3)<10
          list = [list;m(i,:)];
      end
  end
    
  
  if isempty(list) == 0
       w = max(list(:,1));
       h = max(list(:,2));

       im = zeros([w,h]);
       im = PixelList2im(im,list,1);
       
       [L,num] = bwlabel(im);
       S = regionprops(L, 'all');
                   min_index = 1;
                   p_list = S(1).PixelList;
                   dist1 = bw_dist(c1,p_list);
                   dist2 = bw_dist(c2,p_list);
                   min_1 = min(dist1(:,3));
                   min_2 = min(dist2(:,3));
                   min_dist = min([min_1,min_2]);

                        for k = 1:num
                            p_list_k = S(k).PixelList;
                            dist1 = bw_dist(c1,p_list_k);
                            dist2 = bw_dist(c2,p_list_k);
                            min_1 = min(dist1(:,3));
                            min_2 = min(dist2(:,3));
                            min_dist_k = min([min_1,min_2]);

                            if min_dist_k < min_dist
                                min_index = k;
                                min_dist = min_dist_k;
                            end

            %                 if (min_1 >5 || min_2 >5) && isempty(p_list) == 0
            %                     list = setdiff(list,p_list,'rows');
            %                 end

                        end
       list = S(min_index).PixelList;
  end
  
 
  
  
  output_args = list;
end


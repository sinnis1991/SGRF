filename = 'data';
load(filename);


figure
%  subplot(1,3,1);
% im = imread('2.jpg') ;
color = [0,1,0];

imshow(rgb2gray(origin_im));

% use the mouse to isolate the restircted zone
%{
[mouse_x, mouse_y] = ginput;
if mod(size(mouse_x,1),2) == 0
    zone = zeros(size(mouse_x,1)/2,4);
    for i = 1:size(mouse_x,1)/2
        x = mouse_x(i*2-1);
        y = mouse_y(i*2-1);
        x2 = mouse_x(i*2);
        y2 = mouse_y(i*2);
        w = x2-x;
        h = y2-y;
        hold on;
        rectangle('Position',[x,y,w,h]);
        zone(i,1) = x;
        zone(i,2) = x2;
        zone(i,3) = y;
        zone(i,4) = y2;
        
    end
else
    fprintf('wrong! \n');
end

pause;

% imshow(zeros(size(im)));



%find the independent countour

for i = 1:size(index,2)
    
    innerID = index{i};
    
    for j =1:size(innerID,2)
        
        relation =  innerID{j};
        if size(relation,1)==1 || i == size(index,2)
            fprintf('i:%d, j:%d \n',i,j);
            bwlist = bwSet{i}.stats(j).PixelList;
            
            % this code check if bwlist is in the zone
            if_zone = true; 
         
            for bwlist_n =1:size(bwlist,1)
                b_x = bwlist(bwlist_n,1);
                b_y = bwlist(bwlist_n,2);
                for zone_n =1:size(zone,1)
                    if b_x<zone(zone_n,1) || b_x>zone(zone_n,2) || b_y<zone(zone_n,3) || b_y>zone(zone_n,4)
                        if_zone = false;
                    end
                end
                
            end
            
            if if_zone == true
                fprintf('got it!\n');
            end
            
            iteration = 0;

                while(if_zone)
                     hold on;
                     imshow(rgb2gray(origin_im));
                     draw_contour_chain(i,j,iteration,[0,1,0],bwSet,index,true);
                     
                     k = waitforbuttonpress;
                     click = get(gcf,'selectiontype');
                  if (strcmp(click,'normal'))
                    iteration = iteration + 1;
                  elseif (strcmp(click,'alt'))
                    iteration = iteration - 1;
                  end
                  
                  fprintf('i:%d,j:%d, iter:%d \n',i,j,iteration - 1);

                     value = get(gcf,'CurrentCharacter');
                     if (value == 'e' || iteration >= i)
                         fprintf('stop \n');
                        break;
                     end
                end
                
%                 value = get(gcf,'CurrentCharacter'); if (value == 'e' |
%                 iteration >= i-2)
%                     break;
%                 end
        end
    end
end
%}

%
for i = 1:size(index,2)
    innerID = index{i};
    
    bwimage = bwSet{i}.bw;
    boundary = bwboundaries(bwimage);
    color = [1,0,1];
       
    for j = 1:size(innerID,2)
            B = boundary{j};
            hold on;
            plot(B(:,2), B(:,1),'Color',color, 'LineWidth', 0.1);
    end
end


 list = [50,2,21;...
         50,5,22;...
        
        ];
% C = [rand 1 1];
% color = hsv2rgb(C);
  color = [0,1,0];  
 for ind = 1:size(list,1)
     i =list(ind,1); j =list(ind,2); iter = list(ind,3);   
     draw_contour_chain(i,j,iter,color,bwSet,index,true);     
 end
%}
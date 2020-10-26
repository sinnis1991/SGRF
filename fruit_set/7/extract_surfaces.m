filename = 'test_data';
load(filename);


figure
%  subplot(1,3,1);
% im = imread('2.jpg') ;
color = [0,1,0];

imshow(rgb2gray(origin_im));
% imshow(zeros(size(im)));
%{
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
%}


%find the independent countour
%{
for i = 1:size(index,2)
    
    innerID = index{i};
    
    for j =1:size(innerID,2)
        
        relation =  innerID{j};
        if size(relation,1)==1 || i == size(index,2)
            fprintf('i:%d, j:%d \n',i,j);
            iteration = 0;

                while(1)
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

 list = [49,1,1
        ];
% C = [rand 1 1];
% color = hsv2rgb(C);
  color = [0,1,0]  
 for ind = 1:size(list,1)
     i =list(ind,1); j =list(ind,2); iter = list(ind,3);   
     draw_contour_chain(i,j,iter,color,bwSet,index,true);     
 end


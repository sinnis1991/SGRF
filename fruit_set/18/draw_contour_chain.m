function [  ] = draw_contour_chain( i,j,n,c,bwSet,index,if_color )
filename = [num2str(i),'_',num2str(j)];




R = [i,j];
while 1
C = [rand 1 1];
color = hsv2rgb(C);
 if C(1)<0.3 || C(1)>0.4
    break;
 end

end

%  C = [rand 1 1];
%  color = hsv2rgb(C);

bwimage = bwSet{i}.bw;
boundary = bwboundaries(bwimage,'noholes');
B = boundary{j};
hold on;
p=plot(B(:,2), B(:,1),'Color',color,'LineWidth', 0.1); 
color = p.Color;

if if_color == true
 p.Color = c;
 color = c;
end

for k=1:n
     
 bwimage = bwSet{i-k}.bw;
 boundary = bwboundaries(bwimage,'noholes');

 inner_index = index{i-k};
   for h =1:size(inner_index,2)
    relation = inner_index{h};
       if length([j;relation(2:end)]) > length(unique([j;relation(2:end)]))
           j = relation(1);
           break;
       end
   end
    B = boundary{j};
    R = [R;i-k,j];
    hold on;
    plot(B(:,2), B(:,1), 'Color',color,'LineWidth', 0.1);  
%     fill(B(:,2), B(:,1), color);
    
    
end

% eval([filename,'=R']);

   
%  save(filename,'R');





end


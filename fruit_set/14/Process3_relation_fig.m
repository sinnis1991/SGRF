load('test_data');

maxNum = 0;

for i = 1:size(bwSet,2)

if(bwSet{i}.num>maxNum)
    maxNum = bwSet{i}.num;
end

end

 figure
 hold on

 
for i = 1:size(index,2)
    
ID = index{i};

    for j = 1:size(ID,2)
        
        conec = ID{1,j};
        num1 = conec(1,1);
        for n = 1:size(conec,1)-1
            if(size(conec,1)==2)
                color = [0,.8,0];
            else
                color = 'r';
            end
        
            num2 = conec(1+n,1);
            
            x1 = 5*i;
            y1 = -(size(ID,2)-1)+2*(num1-1);
            
            x2 = 5*(i+1);
            y2 = -(bwSet{i+1}.num-1)+2*(num2-1);
            
            p = plot([x1,x2], [y1,y2], 'LineWidth', 2)
            p.Color = color;
        end
        
        
    end
    
    
end

 for i =1:size(bwSet,2)
     
 num = bwSet{i}.num;
 
 Dis = 2*(maxNum-1);
 
 c = i/size(bwSet,2); 
 
 for j = 1:num
     p = plot(5*i, -(num-1)+2*(j-1), 'r');
     p.Marker = 'o';
     p.LineStyle = 'none';
     p.MarkerFaceColor =[c,c,c];
     p.MarkerEdgeColor = 'k';
     p.MarkerSize = 10;
 end
     
     
     
 end
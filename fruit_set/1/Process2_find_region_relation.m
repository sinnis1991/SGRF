filename = 'test_data';
load(filename);

index = {};
 
 for i = 1:size(bwSet,2)-1
 
 num1 = bwSet{i}.num;    
 bw1 = bwSet{i}.bw;
 
 innerID = {};
 for n = 1:num1
     innerID{length(innerID)+1} = [n];
 end
 
 num2 = bwSet{i+1}.num;    
 bw2 = bwSet{i+1}.bw; 
     
%  for j = 1:num2
     
  check = ones(num2,1);
    
  while(sum(check)>0)
        for m = 1:size(bw2,1)
            for n = 1:size(bw2,2)
                
                numIn2 = bw2(m,n);
                numIn1 = bw1(m,n);
                
                if(numIn2~=0 & numIn1~=0)
                    Nindex = innerID{1,numIn1};
                    if(ismember(numIn2,Nindex(2:end,1))==0)
                        innerID{numIn1} = [innerID{numIn1};numIn2];
                         check(numIn2)=0;
                    end
                end 
                
            end
        end
 end
%  end  
     
    
  index{length(index)+1} =innerID ;   
  fprintf('%d\n',length(index));    
 end

 save(filename,'index','-append');
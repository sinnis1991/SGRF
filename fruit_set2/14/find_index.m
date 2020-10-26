function [ output_args ] = find_index( bw1,bw2 )

S = regionprops(bw1, 'all');
[bw1,num1] = bwlabel(bw1);
S2 = regionprops(bw2, 'all');
[bw2,num2] = bwlabel(bw2);

innerID = {};
 for n = 1:num1
     innerID{length(innerID)+1} = [n];
 end
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

output_args = innerID;
end


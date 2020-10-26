function [ output_bw,o_innerID ] = seg_bw( bw_a,bw_b,dist )

S = regionprops(bw_a, 'all');
[bw1,num1] = bwlabel(bw_a);
S2 = regionprops(bw_b, 'all');
[bw2,num2] = bwlabel(bw_b);

innerID = find_index(bw1,bw2);

%innerID = {};
%{
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
%}
  for n = 1:size(innerID,2)
      if length(innerID{n})==3
          index = innerID{n};
          % solve the problem of 2 regions mergin into 1
            mother_bw = S(index(1)).PixelList;
            child_1  = S2(index(2)).PixelList;
            child_2  = S2(index(3)).PixelList;  
            mother_bw = setdiff(mother_bw,child_1,'rows');
            mother_bw = setdiff(mother_bw,child_2,'rows');
            ridge =ridgeList(mother_bw,child_1,child_2,dist);
            bw1 = PixelList2im(bw1,ridge,0);
            
      elseif length(innerID{n})>3
           index = innerID{n};
           mother_bw = S(index(1)).PixelList;
           child_num = length(index)-1;
           child = {};
           for k = 1:child_num
               ch = S2(index(k+1)).PixelList;
               child{length(child)+1} = ch;
           end
           

           for a = 1:child_num-1
               for b = (a+1):child_num
                   child_1 = child{a};
                   child_2 = child{b};
                   ridge = ridgeList(mother_bw,child_1,child_2,dist);
                   ridge = setdiff(ridge,child_1,'rows');
                   ridge = setdiff(ridge,child_2,'rows');
                   if_e = false;
                   for e = 1:child_num
                       if e ~= a && e ~= b
                          child_check = child{e};
                          if isempty(child_check)==0 && isempty(ridge) == 0
                            if_e = if_exist(ridge,child_check);
                          end
                             if if_e == true
                                break;
                             end
                       end
                      
                   end
                      if if_e == false
                         bw1 = PixelList2im(bw1,ridge,0);
                      end
               end
               
               
               
               
           end
               
      end
  end 
  
  output_bw = bw1;
  
  S = regionprops(bw1, 'all');
  [bw1,num1] = bwlabel(bw1);
  
  clear  innerID ;
  
  o_innerID = find_index(bw1,bw2);
  %{
 for n = 1:num1
     o_innerID{length(o_innerID)+1} = [n];
 end
  check = ones(num2,1);
  while(sum(check)>0)
        for m = 1:size(bw2,1)
            for n = 1:size(bw2,2)
                
                numIn2 = bw2(m,n);
                numIn1 = bw1(m,n);
                
                if(numIn2~=0 & numIn1~=0)
                    Nindex = o_innerID{1,numIn1};
                    if(ismember(numIn2,Nindex(2:end,1))==0)
                        o_innerID{numIn1} = [o_innerID{numIn1};numIn2];
                        check(numIn2)=0;
                    end
                end 
                
            end
        end
  end
  %}
  
end


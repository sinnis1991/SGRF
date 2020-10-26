function [ output_args ] = if_exist( m1,m2 )
% to find out whether the some row in m1 existed in m2

output_args = false;

% for i =1:size(m1,1)
%  row1 = m1(i,:);
%    for j = 1:size(m2,1)
%     row2 = m2(j,:);
% 
%             if row1(1)==row2(1) && row1(2)==row2(2)
%                 output_args = true;
%                 break;
%             end  
%    end
%    
%  if output_args == true;
%   break;
%  end
%  
% end


Lia = ismember(m1,m2,'rows');
if sum(Lia) > 0
 output_args = true;
end



end


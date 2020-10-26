function [ output_args ] = ridgeList( m,c1,c2,dist )

  dist_1 = bw_dist(c1,m);
  dist_2 = bw_dist(c2,m);

 output_args =[];
  for i =1:size(m,1)
      if abs(dist_1(i,3)-dist_2(i,3))<dist
          output_args = [output_args;m(i,:)];
      end
  end
    
end


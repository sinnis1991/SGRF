function [ output_args ] = bw_dist( foreground, background )

output_args = [background,zeros(size(background,1),1)];

for i = 1:size(background,1)
    
    pixel = background(i,:);
    a = foreground-pixel(ones(size(foreground,1),1),:);
    dist_min = sqrt(min(sum(a.^2,2)));
    output_args(i,3) = dist_min;
    
end



end


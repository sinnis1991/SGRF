m1 = randi(1000000,20000,2);
m2 = randi(1000000,30000,2);

result = bw_dist(m1,m2);

% m1_g= gpuArray(m1);
% % m2_g= gpuArray(m2);
% result = [m2,zeros(size(m2,1),1)];
% 
% for i = 1:size(m2,1)
%     
%     pixel = m2(i,:);
%     p_gpu = gpuArray(pixel(ones(size(m1,1),1),:));
%     a = m1_g-p_gpu;
%     dist_2 = sum(a.^2,2);
%     dist2 = gather(dist_2);
%     dist_min = min(dist2);
% %     dist_min = sqrt(min(sum(a.^2,2)));
% %     d_min = gather(dist_min);
%     result(i,3) = sqrt(dist_min);
%     
% end
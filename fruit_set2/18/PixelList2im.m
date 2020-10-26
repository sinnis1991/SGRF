function [ output ] = PixelList2im( im, PixelList, number )

output = im;
for i = 1:size(PixelList,1)
    x = PixelList(i,2);
    y = PixelList(i,1);
    output(x,y) = number;
end


end


function [image_mean] = get_image_mean(network)
%author sherwood
%input matconv network 
%get image_mean
image_size = network.meta.normalization.imageSize;
mean_size = size(network.meta.normalization.averageImage);
if image_size(1:2) == mean_size(1:2)
    image_mean = network.meta.normalization.averageImage;
else if prod(mean_size) == 3
    image_mean = reshape(network.meta.normalization.averageImage,[1,1,3]);
    image_mean = repmat(image_mean,image_size(1:2));
end

end


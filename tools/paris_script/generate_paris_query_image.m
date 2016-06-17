root_image_path = 'data/paris_images/';
query_data = importdata('feature/paris/query_crop.mat');
save_path = 'data/paris_query_images/';
for i=1:numel(query_data.query_filename)
    query_image_name = query_data.query_filename{1,i};
    query_image_name = query_image_name(1:end);
    query_image_name = [query_image_name,'.jpg'];
    query_img = imread([root_image_path,query_image_name]);
    point = query_data.query_point(i:i,:);
    point_zero_ind = find(point==0);
    point(point_zero_ind) = point(point_zero_ind)+1;
    query_img = query_img(point(2):point(4),point(1):point(3),:);
    imwrite(query_img,[save_path,query_image_name]);
end

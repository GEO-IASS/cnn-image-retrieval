root_path = 'data/paris_images/';
save_path = 'feature/paris/file_name.mat';
image_path_list = dir(strcat(root_path,'*.jpg'));
file_name = {};
for i = 1:numel(image_path_list)
    file_name{end+1} = image_path_list(i).name;
end
save(save_path,'file_name');
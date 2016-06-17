file_name = importdata('feature/paris/file_name.mat');
for i=1:numel(file_name)
    fprintf(['data/paris_images/',file_name{1,i},'\n']);
    a = imread(['data/paris_images/',file_name{1,i}]);
    
end
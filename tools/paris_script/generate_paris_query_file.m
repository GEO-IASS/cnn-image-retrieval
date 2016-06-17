%generate query file with no crop
add_path();
save_name = 'feature/oxford_building/query.mat';
query = struct('gt',[],'ignore_list',[],'file_name',[],'is_query',[]);
query_data = importdata('feature/oxford_building/query_crop.mat');
file_name = query_data.file_name;
query_file_name = query_data.query_filename;
for i=1:numel(query_file_name)
    query_file_name{1,i} = [query_file_name{1,i}(6:end),'.jpg'];
end
for i=1:numel(file_name)
    for j=1:numel(query_file_name)
        if strcmp(file_name{1,i},query_file_name{1,j})
            query_data.is_query(i) = 1;
        end
    end
end
query.gt = query_data.gt;
query.ignore_list = query_data.ignore_list;
query.file_name = query_data.file_name;
query.is_query = query_data.is_query;
save(save_name,'query');
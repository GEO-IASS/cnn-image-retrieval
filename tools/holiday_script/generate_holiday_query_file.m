save_name = 'feature/holiday/query.mat';
file_name = importdata('feature/holiday/file_name.mat');
query = struct('gt',[],'ignore_list',[],'file_name',[],'is_query',[]);
query.file_name = file_name;
gt = zeros(500,1491);
ignore_list = zeros(500,1491);
is_query = zeros(1491,1); 
for i=1:numel(file_name)
    image_name = file_name{1,i};
    ind_num = str2num(image_name(1:end-4));
    if rem(ind_num,100)==0
        query_num = ((ind_num-100000)/100)+1;
        is_query(i) = 1;
        ignore_list(query_num:query_num,i:i) = 1;
        gt(query_num:query_num,i:i) = 1;
    else
        gt(query_num:query_num,i:i) = 1;
    end
end
query.gt = logical(gt);
query.ignore_list = logical(ignore_list);
query.is_query = logical(is_query);
save(save_name,'query');
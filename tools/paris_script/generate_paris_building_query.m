%exact the message in txt and storage in query_crop.mat
save_file = 'feature/paris/query_crop.mat';
file_name = importdata('feature/paris/file_name.mat');
query = struct('gt',[],'ignore_list',[],'file_name',[],'is_query',[],'query_filename',[],'query_point',[]);
query.file_name = file_name;
root_path = 'data/paris_files/';
gt = zeros(55,5063);
ignore_list = zeros(55,5063);
is_query = zeros(5063,1); 
query_filename = {};
query_point = [];
txt_path_list = dir(strcat(root_path,'*.txt'));
for i=1:numel(txt_path_list)
    query_num = floor((i-1)/4) + 1;
    txt_file_name = [root_path,txt_path_list(i).name];
    text_content = importdata(txt_file_name);
    if strfind(txt_file_name,'good')
        match_index = round(str_cell_match(file_name,text_content));
        gt(query_num:query_num,match_index) = 1;
    end
    if strfind(txt_file_name,'ok')
        match_index = round(str_cell_match(file_name,text_content));
        gt(query_num:query_num,match_index) = 1;
    end
    if strfind(txt_file_name,'junk')
        match_index = round(str_cell_match(file_name,text_content));
        ignore_list(query_num:query_num,match_index) = 1;
    end
    if strfind(txt_file_name,'query')
        query_filename{end+1} = text_content.textdata{1,1};
        query_point = [query_point;round(text_content.data)];
    end
    i
end
query.file_name = file_name;
query.gt = logical(gt);
query.ignore_list = logical(ignore_list);
query.query_filename = query_filename;
query.query_point = query_point;
query.is_query = logical(is_query);
save(save_file,'query');
add_path();
model_name = 'imagenet-vgg-m ';
save_prefix = ['feature/oxford_building/query_',model_name,'_'];
query_data = importdata('feature/oxford_building/query_crop.mat');
file_name = query_data.query_filename;
for i=1:numel(file_name)
    file_name{1,i} = ['data/oxbuild_query_images/',file_name{1,i}(6:end),'.jpg'];
end
range = [5 9 16 17 19 21];
network = load(['model/',model_name,'.mat']);
if isfield(network,'vars')
    network = dagnn.DagNN.loadobj(network);
    network.mode = 'test';
    network.conserveMemory = false;
end
get_feature(file_name,range,save_prefix,network);


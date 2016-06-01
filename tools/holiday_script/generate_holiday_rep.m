add_path();
model_name = 'imagenet-matconvnet-alex';
save_prefix = ['feature/holiday/',model_name,'_'];
file_name = importdata('feature/holiday/file_name.mat');
for i=1:numel(file_name)
    file_name{1,i} = ['data/holiday/',file_name{1,i}];
end
range = [19];
network = load(['model/',model_name,'.mat']);
if isfield(network,'vars')
    network = dagnn.DagNN.loadobj(network);
    network.mode = 'test';
    network.conserveMemory = false;
end
get_feature(file_name,range,save_prefix,network);


rep = importdata('feature/holiday/imagenet-matconvnet-alex_15.mat');
query = importdata('feature/holiday/query.mat');
input_rep = {};
input_rep{end+1} = rep';
PCA_range = [32 64 128 256 512,1024];
[~,map] = retrieval_pipeline(query,input_rep,PCA_range);
plot(PCA_range,map);
xlabel('PCA dimensions');
ylabel('map');

add_path();
rep_range = [14];
input_rep = {};
rep = [];
for i=rep_range
    pre_rep = importdata(['feature/oxford_building/imagenet-matconvnet-alex_',int2str(i),'.mat']);
    rep = [pre_rep rep];   
end
input_rep{end+1} = rep';
query = importdata('feature/oxford_building/query.mat');
%PCA_range = [32 64 128 256 512];
[~,map] = retrieval_pipeline(query,input_rep);
plot(PCA_range,map);
xlabel('PCA dimensions');
ylabel('map');

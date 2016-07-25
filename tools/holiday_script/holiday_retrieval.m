add_path();
rep_range = [15 17];
input_rep = {};
rep = [];
%caculate_method ==1 means sum 
caculate_method = 0;
for i=rep_range
    pre_rep = importdata(['feature/holiday/imagenet-matconvnet-alex_',int2str(i),'.mat']);
    if caculate_method ==0
        input_rep{end+1} = pre_rep';
    else
        rep = [pre_rep rep];
        if i==rep_range(end)
           input_rep{end+1} = rep'; 
        end
    end
end
input_rep = {};
pre_rep = importdata('feature/holiday/tensor_image-matconvnet-alex_14_36mat.mat');
input_rep{end+1} = pre_rep';
query = importdata('feature/holiday/query.mat');
PCA_range = [32 64 128 256 512];
[~,map] = retrieval_pipeline(query,input_rep);
plot(PCA_range,map);
xlabel('PCA dimensions');
ylabel('map');

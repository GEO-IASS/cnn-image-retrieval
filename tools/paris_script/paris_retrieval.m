query = importdata('feature/paris/query_crop.mat');
query_rep = {};
input_rep = {};
rep_range = [17];
rep = [];
query_mat = [];
%caculate_method ==0 means sum 
caculate_method = 0;
for i=rep_range
    pre_rep = importdata(['feature/paris/imagenet-matconvnet-alex_',int2str(i),'.mat']);
    pre_query_mat = importdata(['feature/paris/query_imagenet-matconvnet-alex_',int2str(i),'.mat']);
    if caculate_method ==0
        input_rep{end+1} = pre_rep';
        query_rep{end+1} = pre_query_mat';
    else
        rep = [rep pre_rep];
        query_mat = [query_mat pre_query_mat];
        if i==rep_range(end)
            input_rep{end+1} = rep';
            query_rep{end+1} = query_mat';
        end
    end
end
query.query_mat = query_rep;
PCA_range = [32 64 128 256 512,1024];
[~,map] = retrieval_pipeline(query,input_rep);
plot(PCA_range,map);
xlabel('PCA dimensions');
ylabel('map');

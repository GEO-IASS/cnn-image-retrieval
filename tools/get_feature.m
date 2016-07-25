function get_feature(file_name,range,save_prefix,network,is_squeeze)
%use network to get feature
%range:the layer_num in the network
%file_name:the input file name
%save_prefix:the save prefix 
%network: the network type

%if is network a dag class
is_dag = 0;
if isa(network,'dagnn.DagNN')
    is_dag = 1;
end
%initail the feature mat
feature_mat = cell(size(range));
for i=1:numel(file_name)
    image = imread(file_name{1,i});
    image = single(image);
    image = imresize(image,network.meta.normalization.imageSize(1:2));
    image_mean = get_image_mean(network);
    image = image - image_mean;
    if is_dag
        network.eval({network.layers(1).inputs,image});
        for j=1:numel(range)
            vector = network.vars(range(j)).value;
            if nargin == 4
                vector = reshape(vector,[1,prod(size(vector))]);
            else
                vector = reshape(vector,[1,size(vector)]);
            end
            feature_mat{1,j} = [feature_mat{1,j};vector];
        end
        fprintf('total is %d and now is %d \n',numel(file_name),i);
    else
        res = vl_simplenn(network,image);
        for j=1:numel(range)
            vector = res(range(j)).x;
            if nargin == 4
                vector = reshape(vector,[1,prod(size(vector))]);
            end
            feature_mat{1,j} = [feature_mat{1,j};vector];
        end
        fprintf('total is %d and now is %d \n',numel(file_name),i);
    end
end
for i=1:numel(feature_mat)
    save_mat = feature_mat{1,i};
    save([save_prefix,int2str(range(i)),'.mat'],'save_mat');
end
end


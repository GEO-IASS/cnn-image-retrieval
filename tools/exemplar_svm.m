function [w,b] = exemplar_svm(query,rep)
%EXAMPLAR_SVM Summary of this function goes here
%   Detailed explanation goes here
rand_num = 1000;
group = repmat({'0'},rand_num+1,1);
group{1} = '1';
[query_n,query_m] = size(query);
[rep_n,rep_m] = size(rep);
w = zeros(query_n,query_m);
b = zeros(query_n,1);
for i=1:query_n
    rand_ind = randperm(rep_n,rand_num);
    svm_pos_set = query(i:i,:);
    svm_neg_set = rep(rand_ind,:);
    svm_struct = svmtrain([svm_pos_set;svm_neg_set],group);
    w(i:i,:) = svm_struct.Alpha'*svm_struct.SupportVectors;
    b(i:i,:) = svm_struct.Bias;
end
end


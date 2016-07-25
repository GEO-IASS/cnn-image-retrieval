function [PCA_range,map] = svm_retrieval_pipeline(query,rep,PCA_range)
%function retrieval pipeline
%input: gt ground truth
%rep: the rep cell
%if want PCA input PCA and dimention range
hdSim = [];
if nargin == 2
    PCA_range = 0;
    %no PCA
    for i = 1:numel(rep)
        hdRep = rep{1,i};
        hdRPowerNorm = sign(hdRep).*(abs(hdRep).^2);
        hdRPNL2 = hdRPowerNorm ./ repmat(sqrt(sum(hdRPowerNorm.^2))+1e-6,[size(hdRPowerNorm,1),1]);
        if isfield(query,'query_mat')
            query_mat = query.query_mat{1,i};
            hdQRPowerNorm = sign(query_mat).*(abs(query_mat).^2);
            hdQRPNL2 = hdQRPowerNorm ./ repmat(sqrt(sum(hdQRPowerNorm.^2))+1e-6,[size(hdQRPowerNorm,1),1]);
        else
            hdQRPNL2 = hdRPNL2(:,query.is_query>0);
        end
        %get svm w and b
        [w,b] = exemplar_svm(hdQRPNL2',hdRPNL2');
        hdSim = w*hdRPNL2 + repmat(b,[1 size(hdRPNL2,2)]);
        %for j=1:size(w,1)
            %hdSim = [hdSim;(hdQRPNL2(:,j:j)'.*w(j:j,:)+b(j))*(hdRPNL2.*repmat(w(j:j,:)',[1 size(hdRPNL2,2)]))];
        %end
        %hdSim = hdQRPNL2'*hdRPNL2;
        if i==1
            hdSimSumMax = zeros(size(hdSim));
            hdSimMax = zeros(size(hdSim));
        end
        hdSimMax = max(hdSimMax, hdSim);
        hdSimSumMax = (hdSimSumMax+hdSimMax);
        fprintf('total is %d and now is %d \n',numel(rep),i);
    end
    map = mAP(hdSimSumMax,query.gt,query.ignore_list);
elseif nargin == 3
    %witch PCA
    result = zeros(size(PCA_range));
    for k=PCA_range
        for i = 1:numel(rep)
            hdRep = rep{1,i};
            hdRPowerNorm = sign(hdRep).*(abs(hdRep).^2);
            hdRPNL2 = hdRPowerNorm ./ repmat(sqrt(sum(hdRPowerNorm.^2))+1e-6,[size(hdRPowerNorm,1),1]);
            hdRPNL2C = hdRPNL2 - repmat(mean(hdRPNL2,1),size(hdRPNL2, 1), 1);
            [U,S,~] = svd(hdRPNL2C * hdRPNL2C' / size(hdRPNL2C,2));
            hdWhite = diag(1./sqrt(diag(S) + 1e-6)) * U' * hdRPNL2;
            if isfield(query,'query_mat')
                query_mat = query.query_mat{1,i};
                hdQRPowerNorm = sign(query_mat).*(abs(query_mat).^2);
                hdQRPNL2 = hdQRPowerNorm ./ repmat(sqrt(sum(hdQRPowerNorm.^2))+1e-6,[size(hdQRPowerNorm,1),1]);
                hdQWhite = diag(1./sqrt(diag(S) + 1e-6)) * U' * hdQRPNL2;
            else
                hdQRPNL2 = hdRPNL2(:,query.is_query>0);
                hdQWhite = diag(1./sqrt(diag(S) + 1e-6)) * U' * hdQRPNL2;
            end
            hdWk = hdWhite(1:k,:);
            hdQWk = hdQWhite(1:k,:);
            hdWkL2 = hdWk ./ repmat(sqrt(sum(hdWk.^2))+1e-6,[size(hdWk,1),1]);
            hdQWkL2 = hdQWk ./ repmat(sqrt(sum(hdQWk.^2))+1e-6,[size(hdQWk,1),1]);
            hdSim = hdQWkL2'*hdWkL2;
            if i==1
                hdSimSumMax = zeros(size(hdSim));
                hdSimMax = zeros(size(hdSim));
            end
            hdSimMax = max(hdSimMax, hdSim);
            hdSimSumMax = (hdSimSumMax+hdSimMax);
            fprintf('total is %d and now is %d \n',numel(PCA_range),i);
        end
        result(PCA_range==k) = mAP(hdSimSumMax,query.gt,query.ignore_list);
    end
    map = result;
end
end

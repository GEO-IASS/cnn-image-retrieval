function map = mAP( sim ,labs,ignoreList)
    
    for i=1:size(sim,1)
        s = sim(i,~ignoreList(i,:));
        l = labs(i,~ignoreList(i,:));
        ap(i) = AveragePrec(s,l);
    end
    map = mean(ap(~isnan(ap)));
end

function ap = AveragePrec(score,labels)

    [~,si] = sort(-score);
    tp = cumsum(labels(si)>0);
    fp = cumsum(labels(si)<=0);
    
    rec = tp/sum(labels>0);
    prec = tp./(tp+fp);
    
    ap = VOCap(rec,prec);

end

function ap = VOCap(rec,prec)

mrec=[0 , rec , 1];
mpre=[0 , prec , 0];
%for i=numel(mpre)-1:-1:1
%    mpre(i)=max(mpre(i),mpre(i+1));
%end
i=find(mrec(2:end)~=mrec(1:end-1))+1;
ap=sum((mrec(i)-mrec(i-1)).*mpre(i));
end

function gridsam=gridsample(sample,edges1,edges2)
%edges does not contain 0,
edges1=[-1 edges1 Inf];
edges2=[-1 edges2 Inf];
rownum=numel(edges1);
colnum=numel(edges2);
gridsam=[];
for i=2:numel(edges1)
    i
    for j=2:numel(edges2)
        j
        ind=intersect(find(edges1(i-1)<sample(:,1)&sample(:,1)<=edges1(i)),find(edges2(j-1)<sample(:,2)&sample(:,2)<=edges2(j)));
        subsample=sample(ind,:);
        number=size(subsample,1);
        if number>0
            meanr=mean(subsample(:,1));
            meanc=mean(subsample(:,2));
            meandist=mean(subsample(:,3));
            gridsam=[gridsam;meanr meanc meandist];
        end
    
    end
end
save('gridsam.mat','gridsam')
end
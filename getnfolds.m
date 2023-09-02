%separate R into n folds
function fold= getnfolds( R, n )

    [usernum, itemnum]=size(R);
    [r,c,v]=find(R);
    nzeronum=nnz(R);
    nzeroele=[reshape(r,nzeronum,1),reshape(c,nzeronum,1),reshape(v,nzeronum,1)];%nonzero elements of R, with their indices

    i=1;
    
    index=1:nzeronum;
    samindex=[];
    number=floor(nzeronum/n);
    
    while(i<n)

        index=setdiff(index,samindex);
        samindex=randsample(index,number);
        sam=nzeroele(samindex,:);
        fold{i}=sparse(sam(:,1),sam(:,2),sam(:,3),usernum,itemnum);
        i=i+1;
    end
    index=setdiff(index,samindex);
    sam=nzeroele(index,:);
    fold{n}=sparse(sam(:,1),sam(:,2),sam(:,3),usernum,itemnum);
    
end


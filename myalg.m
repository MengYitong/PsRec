function [ U,V,min ] = myalg( trainR, W, testR, latentnum, lambda, alpha, steps )
        [usernum, itemnum]=size(trainR);
    U=normrnd(0,0.1,[usernum,latentnum]);
    V=normrnd(0,0.1,[itemnum,latentnum]);
    
    [I,J]=find(trainR);%subscripts of nonzero elements of W

   
    num1=nnz(trainR);%number of nonzero elements of W
    tempcoef=(zeros(1,num1));
    
    scaleR=spfun(@rescaling,trainR);

%update
    min=[0,Inf,inf];
    i=0;
    while(i<steps)
        i=i+1
        if(i==8)
            alpha=alpha/5;
        end
        tic
        for k=1:num1
            tempcoef(k)= der_h( U(I(k),:)*V(J(k),:).' ) * ( h(U(I(k),:)*V(J(k),:).')-scaleR(I(k),J(k)) );
        end
        toc
        
        coef=sparse(I,J,tempcoef,usernum, itemnum);
        coef=W.*coef;
        
        grad_U=coef*V+lambda*U;
        U=U-alpha*(grad_U)/sqrt(sumsqr(grad_U));
        grad_V=coef.'*U+lambda*V;
        V=V-alpha*(grad_V)/sqrt(sumsqr(grad_V));

        accuracyTrain = evalu2( trainR, U,V,W )
        accuracyTest = evalu1( testR, U,V )
        if isnan(accuracyTest)
            min(1)=i;
            break
        end
        if accuracyTest<min(3)
            min([2 3])=[accuracyTrain,accuracyTest];
        end
    end

end
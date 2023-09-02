%this function is used to evaluate the performance of the factorization
%model R=U*V.'
function accuracy = evalu( testR, U,V )
    [usernum, itemnum]=size(testR);
    [I,J]=find(testR);%subscripts of nonzero elements of testR
   
    num=nnz(testR);%number of nonzero elements of W
    temp=zeros(1,num);
    for k=1:num
            temp(k)=U(I(k),:)*V(J(k),:).';
    end

    M=sparse(I,J,temp,usernum, itemnum);
    E=testR-M;
   
    dif=abs(E); %the difference between the real data (testR) and our model
    accuracy=sum(dif(:))/nnz(testR);
end


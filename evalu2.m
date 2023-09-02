%this function is used to evaluate the performance of the factorization
%model R=U*V.'
function accuracy = evalu2( testR, U,V,W )
    [usernum, itemnum]=size(testR);
    [I,J]=find(testR);%subscripts of nonzero elements of testR
   
    num=nnz(testR);%number of nonzero elements of W
    temp=zeros(1,num);
    for k=1:num
            temp(k)=inv_rescaling(h(U(I(k),:)*V(J(k),:).'));
    end

    M=sparse(I,J,temp,usernum, itemnum);
    E=abs((testR-M).*W);
    sumW=sum(W(:));
   
    accuracy=sum(E(:))/sumW;
end


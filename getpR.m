%get the pseudo rating matrix and the corresponding weight.
%return the pseudo rating matrix pR(not include the original rating), and the corresponding weight matrix.(weight of original ratings are 1s.)
function [pR,W]=getpR(dist_threshold,R,frinumrated,frivar,frimean,w0,w,b1,v1,b2,v2)
%Input: frinumrated is a matrix of the same size as R, so are frivar and frimean
%Output: pR, W are matrices of the same size as R. The entry (k,i) that are
%nonzero in pR or W has to satisfy: 1. it correspond to a missing value of
%R; 2. frinumrated(k,i)>0; 3. dist value of (k,i) should be less than the
%threshold.

    usernum=size(R,1);
    itemnum=size(R,2);

    w0_=exp(w0); % the exp() function takes lots of time. To ease computation, we get the exp of all parameters in advance such that there is no need to do exp() in the ff2 function.
    w_=exp(w);
    v1_=exp(v1);
    v2_=exp(v2);

    ind=setdiff(find(frinumrated>4),find(R));%frinumrated>1 and also a missing value
    ind=ind.';
    ratenum=sum(spones(R).');
    cold_start=5
    
    num=size(ind,2)
    temp=zeros(1,num);

   	s=[usernum,itemnum];
    %parfor
    for i=1:num %get the f value
        i;
        k=ind(i);
        [I,J] = ind2sub(s,k);
        tempvalue=f_without_exp(frinumrated(k),frivar(k),w0_,w_,b1,v1_,b2,v2_ );
        if (ratenum(I)<=cold_start)
            
            if tempvalue < 1.3*dist_threshold % for clod start users, we elevate the threshold by 1.3*dist_threshold
                temp(i)=tempvalue;
            end
        else
            
            if tempvalue < dist_threshold
                temp(i)=tempvalue;
            end
        end

    end
    temp=sparse(temp);
    temp=spfun(@exp,-temp);
    [I,J] = ind2sub(s,ind);
    W=sparse(I,J,temp,usernum,itemnum);
    Wones=spones(W);
    pR=Wones.*frimean;
end
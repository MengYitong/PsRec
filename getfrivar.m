%get the variation the user's friends rating.
%input: R is the original rating matrix; T is the trust matrix; frimean is
%a matrix the same size as R, where frimean(k,i) is the mean of user k's
%friends' rating on item i; frinumrated is a matrix the same size as R,
%where frinumrated (k,i) is the number of user k's friends who gave a
%rating  to item i.
% return: return a usernum-by-itemnum matrix M. M[3,4]=5 means that the variation of the rating values of user 3's freinds on item 4 is 5.
function frivar=getfrivar(R,T,frimean,frinumrated)
    usernum=size(R,1);
    itemnum=size(R,2);
    frivar=sparse(usernum,itemnum);
    tic;
    %parfor
    for k=1:usernum
        k;
        Tk=(diag(T(k,:)));
        Rk=spones(Tk)*R ;%only retain k's friend's rating in R
        Rkones=spones(Rk);
        meank=Rkones*(diag(frimean(k,:)));% only retain frimean on the locations where Rk is nonzero.
        frivar(k,:)=sum(Tk*((Rk-meank).^2));
    end
    runtime=toc;
    fprintf(1, '\n parfor Finish! runtime: %6.4f seconds \n', runtime);
    inv_frinumrated=spfun(@inverse1,frinumrated);%take inverse of the nonzero elements in frinumrated
    runtime=toc;
    fprintf(1, '\n inverse Finish! runtime: %6.4f seconds \n', runtime);
    frivar=sqrt(frivar.*inv_frinumrated);
    runtime=toc;
    fprintf(1, '\n sqrt Finish! runtime: %6.4f seconds \n', runtime);
end
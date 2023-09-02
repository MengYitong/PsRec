%get the mean of each user's friends' rating on item i(exclude those who didn't give a rate.)
% return a usernum-by-itemnum matrix M.
% M[3,4]=5 means that the average rating value of user 3's freinds on item 4 is 5.
function frimean=getfrimean(R,T,frinumrated)
    inv_frinumrated=spfun(@inverse1,frinumrated);
    frimean=(T*R).*inv_frinumrated;
end

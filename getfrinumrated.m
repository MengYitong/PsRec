% returns a usernum-by-itemnum matrix M.
% M[3,4]=5 means there are 5 people among all the friends of user 3 that have rated item 4.
function frinumrated=getfrinumrated(R,T)  
    Rones = spones(R);
    frinumrated = T*Rones;
end
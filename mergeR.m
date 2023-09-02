%get the merged rating matrix mR (mR=R+pR, R is the original rating matrix, and pR is the pseudo rating matrix) and corresponding weights.
function [ mR, mW ] = mergeR( tR, tW, pR, pW )
    %the weight for original ratings are set to be 1.
    mR=tR+pR;
    mW=tW+pW;
    
    


end


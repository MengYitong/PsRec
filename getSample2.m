% get the sample used to train the dist surface
function sample = getSample2( frinumrated, frimean, frivar, R )
%this four matrices are of the same size
frinumratedones=spones(frinumrated);
Rones=spones(R);
available=frinumratedones.*Rones;
% frimean=available.*frimean;
% frivar=available.*frivar;
ind=find(available);
sample(:,1)=frinumrated(ind);
sample(:,2)=frivar(ind);
sample(:,3)=abs(frimean(ind)-R(ind)); %MAE as dist value

end

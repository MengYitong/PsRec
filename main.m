% load the original rating matrix of Ciao datasent. Rows refer to users, and columns refer to items.
load('./data/ciaoR.mat')
% split the rating matrix into 5 folds
foldR = getnfolds( ciaoR, 5 )
% use 4 folds as train sets and 1 fold as test set. 
% You can do cross validation by changing the indices.
trainR=foldR{1}+foldR{2}+foldR{4}+foldR{3};
testR=foldR{5};

% load the social network of Ciao datasent. 
% T[3,4]=1 means user3 and user4 are friends.
load('./data/ciaoT.mat')

% frinumrated, frimean and frivar are all of shape [usernum, itemnum], which is the same as the original rating matrix.
% frinumrated, frimean and frivar correspond to F, M and S matrix in our paper respecctively.
frinumrated=getfrinumrated(trainR,ciaoT);
frimean=getfrimean(trainR,ciaoT,frinumrated);
frivar=getfrivar(trainR,ciaoT,frimean,frinumrated);


% get samples to train the neural network f. sample is a list of triples which is used to train the nueral network.
sample=getSample2(frinumrated, frimean, frivar, trainR );

% Usually, there are so many triples in the list of sample, which means there is a huge computational cost while training the nueral network, especially on cpu. The following step can reduce training time by a large extent, but is not necessary when you have sufficient computational resouces.
% To reduce training time, we reduce the number of triples by taking the average value of adjacent ones. For example, I replace (3, 0.4, 0.9), (3, 0.41, 1.0) and (3, 0.42, 1.1) with a single triple (3, 0.41, 1.0).
% More specifically, I split the 2D "the number of friends - the variation of friends' ratings" surface by the intervals on each axis (edges1 and edges2). Then I average the triples in each grid.
edges1=[1:20,22,25,30]; % the intervals of the number of friends.
edges2=[0:0.1:2]; % the intervals of the variation of friends' ratings.
gridsam=gridsample(sample,edges1,edges2);

% train the neural network f. The parameter hn, w0, w, b1, v1, b2 and v2 can fully describe f. 
hn=4 % the number of hidden nureons
rate=0.05 % learning rate
steps=60 % stop criteria 1
threshold=0.065 % stop criteria 1
[w0,w,b1,v1,b2,v2]=SGD2(hn,gridsam,rate,steps,threshold); % We use SGD to train f.

%plot the neural network and gridsample
plotf(w0,w,b1,v1,b2,v2,edges1,edges2,gridsam);

% theta_ps in our paper
theta_ps=0.39
% get the pseudo rating matrix pR (exclude the original ratings), and its corresponding weights pW.
[pR,pW]=getpR(theta_ps,trainR,frinumrated,frivar,frimean,w0,w,b1,v1,b2,v2);
% merge the pseudo ratings and the original ratings.
[ mR, mW ] = mergeR( trainR, spones(trainR), pR, pW );

% matrix factorization
latentnum=10; %num of cols of U or V
lambda=0.001; % regularization
alpha=10; %learning rate(spead)
steps=250; %stop criterion
[U,V]= myalg( mR, mW, testR, latentnum, lambda, alpha, steps );
% save(strcat(path,'UV.mat'),'U','V')

% evaluate the result
accuracy = evalu1( testR, U,V )


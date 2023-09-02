function plotf(w0,w,b1,v1,b2,v2,edges1,edges2,sample)
%plot the surface of ff2, together with the scattered points used to train
%it
%X is numfrirated, Y is var
[Y,X] = meshgrid(edges2,edges1);

rownum=size(X,1);
colnum=size(X,2);
Z=zeros(rownum,colnum);
for r=1:rownum

    for c=1:colnum
        Z(r,c)=f([X(r,c) Y(r,c)],w0,w,b1,v1,b2,v2);
    end

end

clf;

surf(X,Y,Z);
hold on;
scatter3(sample(:,1),sample(:,2),sample(:,3),'filled');
end
function [w0,w,b1,v1,b2,v2]=SGD2(hn,sample,rate,steps,threshold)
%hn is the number of hidden neurons
%the first two columns of sample is x1 and x2, the third column of sample is y
%steps is the itteration criterion.

    
%initialization,all the parameters are organized as column vectors
    scale=5;
    w0=rand*scale-scale/2;
    w=rand(hn,1)*scale-scale/2;
    b1=rand(hn,1)*scale-scale/2;
    v1=rand(hn,1)*scale-scale/2;
    b2=rand(hn,1)*scale-scale/2;
    v2=rand(hn,1)*scale-scale/2;
    x=sample(:,[1 2]);
    y=sample(:,3);
    
%compute the total error at initial stage
    rownum=size(sample,1);
%     te=0%total error
%     for k=1:rownum
%         te=te+abs(y(k)-ff2(x(k,:),w0,w,b1,v1,b2,v2));
%         
%     end
    
            f_=table2array(  rowfun(@(x) f(x,w0,w,b1,v1,b2,v2 ),table(sample(:,[1 2])))   );
         dist=f_-sample(:,3);
         loss=sum(dist.^2)/numel(dist)
    
    loss=Inf;
    i=0
    while( i<steps & loss>threshold)
        %upgrade the parameter based on all smples
        i=i+1
        
        if (i==100)
           rate=rate/2 
        end
        
        if (i==200)
           rate=rate/2 
        end
        
        if (i==400)
           rate=rate/2 
        end
        
        for k=1: rownum
            k;
            z1=b1-(exp(1).^v1)*x(k,1);
            z2=b2+(exp(1).^v2)*x(k,2);
            u=(exp(1).^w).*sp(z1).*h(z2);
            f_=exp(1)^w0+sum(u);
            
            
            der_w0=exp(1)^w0;
            der_w=u;
            der_b1=u.*h(z1)./sp(z1);
            der_v1=((-exp(1).^v1)*x(k,1)).*der_b1;
            der_b2=u.*(1.-h(z2));
            der_v2=((exp(1).^v2)*x(k,2)).*der_b2;
            
            grad=-(f_-y(k))*[der_w0;der_w;der_b1;der_v1;der_b2;der_v2];
            step=rate*normc(grad);
            new_par=[w0;w;b1;v1;b2;v2]+step;%[w0,w(1:hn),b(1:hn),v(1:hn)]
            w0=new_par(1);
            new_par=reshape(new_par(2:end),hn,numel(new_par(2:end))/hn);
            w=new_par(:,1);
            b1=new_par(:,2);
            v1=new_par(:,3);
            b2=new_par(:,4);
            v2=new_par(:,5);
        end
         f_=table2array(  rowfun(@(x) f(x,w0,w,b1,v1,b2,v2 ),table(sample(:,[1 2])))   );
         dist=f_-sample(:,3);
         loss=sum(dist.^2)/numel(dist)
    end
    
end
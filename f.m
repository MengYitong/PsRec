% This is the f function in the "Modeling the f function" section of our paper.
function y=f(x,w0,w,b1,v1,b2,v2)
        x1=x(1);
        if x1<1
            y=0;
        else
            x2=x(2);
            y=exp(w0)+sum(  exp(w).*sp(b1-exp(v1).*x1).*h(b2+exp(v2).*x2) );
        end
end
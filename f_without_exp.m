% For speed up purpose, we take all the exp() out of f and do it in advance.
function y = f_without_exp( x1,x2,w0,w,b1,v1,b2,v2 )
            y=w0+sum(  w.*sp(b1-v1*x1).*h(b2+v2*x2) );
end


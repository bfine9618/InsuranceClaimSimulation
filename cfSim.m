function [X,T] = cfSim(lambda,beta, alpha, X0, c, d, Xr, Xmax, Tmax)

i = 1;
T(i) = 0;
X(i) = X0;
add = [1, -c, -d];

while T(i) < Tmax
    x=X(i);
    tp = exprnd(1/lambda);
    tc = exprnd(1/alpha);
    td = exprnd(1/beta);
    
    if x==0
        T(i+1) = T(i) + tp;
        X(i+1)=x+1;
    elseif  0<x && x<Xr
        [m, ind]=min([tp,tc]);
        T(i+1) = T(i) + m;
        X(i+1) = x + add(ind);
    elseif Xr <= x && x < Xmax
        [m, ind]=min([tp,tc,td]);
        T(i+1) = T(i) + m;
        X(i+1) = x + add(ind);
    elseif x==Xmax
        [m, ind] = min([realmax,tc,td]);
        T(i+1) = T(i) + m;
        X(i+1) = x + add(ind);
    else
        break;
    end
    
    i=i+1;
end


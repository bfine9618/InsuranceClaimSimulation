function [R]=Kolm(lambda,alpha,beta,c,d,Xr,Xmax)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
R=zeros(Xmax+1);
R(1, 1) = -lambda;
R(Xmax+1, Xmax)=lambda;
R(Xmax+1, Xmax+1)=-(alpha+beta);

for i=1:Xmax+1
    if i>=2 && i <=Xr-d
        R(i,i)=-(lambda+alpha);
        R(i, i-1) = lambda;
        R(i, i+c) = alpha;
    elseif i>=Xr-d+1 && i<=Xmax-d+1
        R(i, i-1) = lambda;
        R(i,i+c)=alpha;
        R(i,i+d)=beta;
        if i>= Xr+1
            R(i,i)=-(lambda+alpha+beta);
        else
            R(i,i)=-(lambda+alpha);
        end
    elseif i >= Xmax-d+2 && i<= Xmax-c+1
        R(i,i-1)=lambda;
        R(i,i+c)=alpha;
        R(i,i)=-(lambda+alpha+beta);
    elseif i>= Xmax-c+2 && i<=Xmax
        R(i,i-1)=lambda;
        R(i,i)=-(lambda+alpha+beta);
    end  
end
end


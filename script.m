close all; clear; clc;
X0 = 200;N = 200;r = .04;c = 20;
d = 30;Xr = 200;Xmax = 300;Tmax = 5;

lambda=N;
alpha=r*N;
beta=4;

[X,T] = cfSim(lambda,beta, alpha, X0, c, d, Xr, Xmax, Tmax);

hold on
grid on
xlabel('time','Fontsize',14)
ylabel('Cash','Fontsize',14)
title('Cash on hand over 5 years','Fontsize',14)
xlim([0,5]);
xticklabels(0:.5:5);
stairs(T,X);
saveas(gcf, './figures/Cashflow.png');

%%
R=Kolm(lambda,alpha,beta,c,d,Xr,Xmax);

p0=zeros(Xmax+1,1);
p0(X0+1,1)=1;
T=0:0.25:5;
figure
hold on
xlabel('X','Fontsize',14)
ylabel('pmf','Fontsize',14)
title('Probability of states between 0 and 5','Fontsize',14)
axis([0 300 0 0.016])
for tm=T
    mf=expm(R.*tm)*p0;
    plot(0:Xmax,mf, 'b')
end
saveas(gcf, './figures/pmf.png');

%%
s = 0;
for i=1:1000
    [x,~] = cfSim(lambda,beta, alpha, X0, c, d, Xr, Xmax, Tmax);
    a = x(2:end);
    diff = a-x(1:end-1);
    if ~isempty(find(diff == -d, 1))
        s = s+1;
    end
end
disp(s/100);

%%
pmf = zeros(100, 21);
for i=1:100
    [x,t] = cfSim(lambda,beta, alpha, X0, c, d, Xr, Xmax, Tmax);
    a = x(2:end);
    diff = a-x(1:end-1);

    T = .25:.25:5;
    edges = zeros(1, length(T));
    for tm = 1:length(T)
            [~,ind] = find(t<=T(tm), 1, 'last');
            edges(tm) = ind;
    end
    
    edges(edges > length(diff)) = length(diff);

    edges = [1,edges];
    p = zeros(1, 21);
    for e=2:21
        p(e-1) = length(find(diff(edges(e-1):edges(e)) == -d));
    end
    pmf(i, :) = p/sum(p);
end
pmf(any(isnan(pmf), 2),:)=[];
avg = mean(pmf);
stairs(0:20, avg);
grid on;
title('average pmf of paying a dividend at in quarter q (100 trials)');
xlabel('q');
ylabel('pmf');
saveas(gcf, './figures/pmfDividend.png');

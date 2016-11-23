function [X,Xkj_sk]=distance_longseries_shortseries(series_long,series_short,alpha)        
mL=length(series_long);
mS=length(series_short);
num_seg=mL-mS+1;
D1=[];
D2=[];
for q=1:num_seg
    seg=series_long(q:q+mS-1);% the q-th segment of the long series
    D2(q,1)=1/mS*norm(series_short-seg)^2;
    D1_p=1/mS*(series_short-seg);
    D1=[D1;D1_p];
end
X_up=sum(D2.*exp(alpha*D2));
X_down=sum(exp(alpha*D2));
X=X_up/X_down; % the distance between the series_long and series_short;

for l=1:mS 
    part1=1/X_down^2;
    part2=D1(:,l);
    part3=exp(alpha*D2).*(X_down*(1+alpha*D2)-alpha*X_up);
    Xkj_sk(l)=part1*sum(part2.*part3); % the derivative of X_(kj) on S_(kl)
end


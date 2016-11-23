function [D_T_S Xkj_skl]=distance_timeseries_shapelet(T,S,alpha)
[mT,nT]=size(T);
DT=T(:,2:end);
[mS,nS]=size(S);
DS=S(:,2:end);

Xkj_skl=zeros(mS,mT,nS-1);
for j=1:mT % the j-th time series
    for k=1:mS
        len=S(k,1);% the length of k-th shapelet
        shapelet=DS(k,1:len); % the k-th shapelet
        Q_j=T(j,1); %the length of time series
        time_series=DT(j,1:Q_j); % the j-th time series
        [X(k,j),Xkj_sk]=distance_longseries_shortseries(time_series,shapelet,alpha); %calculate the distance;
        Xkj_skl(k,j,1:len)=Xkj_sk;
    end
end
D_T_S=X;
            

function [W_star,Y_star,S_star,S_0,F_tp1,wh_time] = SSSL(labled_TS,unlabled_TS,labled_Y,Parameter)

labled_S_0 = initialization_s(labled_TS,Parameter); % initialize labled s_0;
unlabled_S_0 = initialization_s(unlabled_TS,Parameter); % initialize unlabled s_0;
[labled_X_0 labled_Xkj_0_skl] = distance_timeseries_shapelet(labled_TS,labled_S_0,Parameter.alpha);% calculate the distance matrix X_0 between time series and shapelets S_0.
[unlabled_X_0 unlabled_Xkj_0_skl] = distance_timeseries_shapelet(unlabled_TS,unlabled_S_0,Parameter.alpha);
[Centroid,unlabled_Y_0] = EM(unlabled_X_0,Parameter.C); % initialize unlabled_Y_0;
W_0 = Parameter.w*[-Centroid(1,:);Centroid(2:end,:)]; % initialize W_0;

W_tp1 = W_0;
labled_S_tp1 = labled_S_0;
unlabled_S_tp1 = unlabled_S_0;
unlabled_Y_tp1 = unlabled_Y_0;
gap = 100;
F_tp1=10000;
F_t=F_tp1+10^10;

wh_time=0;
while F_tp1>100

%%%%%%Calculation matrix
[unlabled_X_tp1 unlabled_Xkj_tp1_skl] = distance_timeseries_shapelet(unlabled_TS,unlabled_S_tp1,Parameter.alpha);% update unlabled_X_tp1;
[labled_X_tp1 labled_Xkj_tp1_skl] = distance_timeseries_shapelet(labled_TS,labled_S_tp1,Parameter.alpha);% update unlabled_X_tp1;
[L_G_tp1 G_tp1]=Spectral_timeseries_similarity(unlabled_X_tp1,Parameter.sigma);% update L_G_tp1, the Laplacian matrix of similarity matrix G of time series. 
[unlabled_SS_tp1 unXS_tp1 unSSij_tp1_sil]=shapelet_similarity(unlabled_S_tp1,Parameter.alpha,Parameter.sigma);% update shapelets similarity matrix H_tp1;
[labled_SS_tp1 lXS_tp1 lSSij_tp1_sil]=shapelet_similarity(labled_S_tp1,Parameter.alpha,Parameter.sigma);% update shapelets similarity matrix H_tp1;
SS_tp1 = [labled_SS_tp1;unlabled_SS_tp1];
F_tp1=function_value(labled_X_tp1,unlabled_X_tp1,unlabled_Y_tp1,labled_Y,L_G_tp1,unlabled_SS_tp1,W_tp1,Parameter); % calculate the value of objective function;
gap=F_t-F_tp1;

if gap<-10000
    break;
end
if isnan(F_tp1)
    break;
end
% gap
W_tp1=update_W(labled_X_tp1,unlabled_X_tp1,unlabled_Y_tp1,labled_Y,Parameter) %update W_tp1;
%W_tp1=RLS(unlabled_X_tp1,labled_X_tp1, unlabled_Y_tp1,labled_Y, W_0,unlabled_S_tp1,Parameter);
W_tp1=z_regularization(W_tp1); % regularize W_tp1;
unlabled_Y_tp1=update_Y(W_tp1,unlabled_X_tp1,L_G_tp1,Parameter); %update Y_tp1;
unlabled_S_tp1=update_S(unlabled_Y_tp1,unlabled_X_tp1,W_tp1,G_tp1,unlabled_S_tp1,unlabled_Xkj_tp1_skl,unSSij_tp1_sil,unlabled_SS_tp1,Parameter); % update S_tp1;
labled_S_tp1=update_lS(labled_Y,labled_X_tp1,W_tp1,labled_S_tp1,labled_Xkj_tp1_skl,lSSij_tp1_sil,labled_SS_tp1,Parameter); % update S_tp1;
unlabled_S_tp1=[unlabled_S_tp1(:,1), z_regularization(unlabled_S_tp1(:,2:end))]; % regularize S_tp1; The first column is the length of the shapelet in the corresponding row;
labled_S_tp1=[labled_S_tp1(:,1), z_regularization(labled_S_tp1(:,2:end))];
%test_accuracy(W_tp1,unlabled_S_tp1,Parameter);
F_t=F_tp1;
wh_time=wh_time+1;
if wh_time==15
    break;
end
end

W_star=W_tp1; % the ultimate W_star;
%S_star=[unlabled_S_tp1;labled_S_tp1]; % the ultimate S_star;
S_star=unlabled_S_tp1;

[mY,nY]=size(unlabled_Y_tp1);
Y_star=zeros(mY,nY);
y_max=max(unlabled_Y_tp1);

for j=1:nY
    y_index=find(unlabled_Y_tp1(:,j)==y_max(j));
    Y_star(y_index,j)=1; % the ultimate Y_star;
end
S_0 = [labled_S_0;unlabled_S_0];

function [RI Part] = test_accuracy(W,S,Parameter)

Data=read_file('CBF_TEST');
%load('ECG200.mat');
[mD,nD]=size(Data);
Y_true=Data(:,1);
DT=Data(:,2:end);
DT=z_regularization(DT);% regularize time series data;
T=[(nD-1)*ones(mD,1),DT]; % Each element in first column of time series matrix is the length of the time series in that row;
Y_true_matrix=reshape_y_ture(Y_true,Parameter.C);
[X Xkj_0_skl]=distance_timeseries_shapelet(T,S,Parameter.alpha);

TEMP = W'*X;
[mY,nY]=size(TEMP);
Y_star=zeros(mY,nY);
y_max=max(TEMP);

for j=1:nY
    y_index=find(TEMP(:,j)==y_max(j));
    Y_star(y_index,j)=1; % the ultimate Y_star;
end

[RI Part] = RandIndex(Y_star,Y_true_matrix)

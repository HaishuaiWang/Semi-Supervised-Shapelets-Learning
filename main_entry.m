clear;
clc;

%% Parameters ilitialization
Parameter.Lmin=5; % the minimum length of shapelets we plan to learn
Parameter.k=1;% the number of shapelets in equal length 
Parameter.R=3;% the number of scales of shapelets length 
Parameter.C=2;% the number of clusters
Parameter.alpha=-100; % parameter in Soft Minimum Function
Parameter.sigma=10; % parameter in RBF kernel
Parameter.lambda_1=-8; % regularization parameter
Parameter.lambda_2=-8;% regularization parameter
Parameter.lambda_3=-8; % regularization parameter
Parameter.lambda_4=-8; % regularization parameter
Parameter.Imax=25; % the number of internal iterations
Parameter.eta=0.1; % learning rate
Parameter.epsilon=0.1; % internal convergence parameter
Parameter.w=10^-2;
labeled_ratio = 0.2; % percents of labled data

%% time series to matrix
Data = read_file('ItalyPowerDemand_TRAIN');
[mD,nD] = size(Data)
labled_number = fix(labeled_ratio * mD);
Y_true = Data(:,1);
labled_Y = zeros(labled_number,Parameter.C);
for i = 1:labled_number
    labled_Y(i,Y_true(1:labled_number,1)) = 1;
end
labled_DT = Data(1:labled_number,2:end);
unlabled_DT = Data(labled_number+1:end,2:end);
labled_DT = z_regularization(labled_DT);
unlabled_DT = z_regularization(unlabled_DT);
labled_TS = [(nD-1)*ones(labled_number,1),labled_DT]; % the first element in each row is the length of time series
unlabled_TS = [(nD-1)*ones(mD-labled_number,1),unlabled_DT]; % the first element in each row is the length of time series
N = mD; % the number of time series

%% Semi-supervised shapelets learning
tic;
[W_star,Y_star,S_star,S_0,F_tp1,wh_time] = SSSL(labled_TS,unlabled_TS,labled_Y,Parameter);
time = toc;
test_accuracy(W_star,S_star,Parameter);
%% output parameters
time
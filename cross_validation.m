clear;
clc;

%% time series to matrix
Data = read_file('CBF_TRAIN');
%load('ECG200.mat');
[mD,nD] = size(Data)
labeled_ratio = 0.9; % percents of labled data
labled_number = fix(labeled_ratio * mD);
Y_truee = Data(:,1);

labled_DT = Data(1:labled_number,2:end);
unlabled_DT = Data(labled_number+1:end,2:end);
labled_DT = z_regularization(labled_DT);
unlabled_DT = z_regularization(unlabled_DT);
labled_TS = [(nD-1)*ones(labled_number,1),labled_DT]; % the first element in each row is the length of time series
unlabled_TS = [(nD-1)*ones(mD-labled_number,1),unlabled_DT]; % the first element in each row is the length of time series
%N = mD; % the number of time series

%% Parameters ilitialization
C=6;
N=mD;
round=6;
epsilon=0.1;

k=1;
PL_min=[0.05 0.3];
L_min=ceil(PL_min*nD);
R=[1 2];
eta=[0.01 0.1];
Imax=[10 30];
alpha=[-20 -100];
sigma=10.^[-2:4:2];
lambda_1=10.^[-8:4:8];
lambda_2=10.^[-8:4:8];
lambda_3=10.^[-8:4:8];
lambda_4=10.^[-8:4:8];
W=10.^[-2:2:8];

%% Semi-supervised shapelets learning
Y_true = Data(labled_number+1:end,1);
Y_true_matrix=reshape_y_ture(Y_true,C);
result=[];
for l=1:length(L_min)
    for r=1:length(R)
        for e=1:length(eta)
            for i=1:length(Imax)
                for a=1:length(alpha)
                    for s=1:length(sigma)
                        for l1=1:length(lambda_1)
                            for l2=1:length(lambda_2)
                                for l3=1:length(lambda_3)
                                    for l4=length(lambda_4)
                                        time=0;
                                        for rou=1:round
                                            for w=1:length(W)
                                            tic;
                                            Parameter.k=k;
                                            Parameter.R=R(r);
                                            Parameter.Lmin=L_min(l);
                                            Parameter.C=C;
                                            Parameter.alpha=alpha(a);
                                            Parameter.sigma=sigma(s);
                                            Parameter.lambda_1=lambda_1(l1);
                                            Parameter.lambda_2=lambda_2(l2);
                                            Parameter.lambda_3=lambda_3(l3);
                                            Parameter.lambda_4=lambda_4(l4);
                                            Parameter.Imax=Imax(i);
                                            Parameter.epsilon=epsilon;
                                            Parameter.eta=eta(e);
                                            Parameter.w=W(w);
                                            labled_Y = zeros(labled_number,Parameter.C);
                                            for i = 1:labled_number
                                                labled_Y(i,Y_true(1:labled_number,1)) = 1;
                                            end
%                                             for ii = 1:labled_number
%                                                 temp = 1;
%                                                 if Y_truee(1:labled_number,1) == -1
%                                                     temp = 2;
%                                                 end
%                                                 
%                                                 labled_Y(ii,temp) = 1;
%                                             end
                                            [W_star, Y_star, S_star,gap]=SSSL(labled_TS,unlabled_TS,labled_Y,Parameter);
                                            time1=toc;
                                            time=time+time1;
                                            W_star;
                                            %[RI(rou,w) Part] = RandIndex(Y_star,Y_true_matrix);
                                            [RI(rou,w) Part] = test_accuracy(W_star,S_star,Parameter);
                                            end
                                        end
                                        re=[max(max(RI)) time L_min(l) R(r) eta(e) Imax(i) alpha(a) sigma(s) lambda_1(l1) lambda_2(l2) lambda_3(l3) lambda_4(l4) W(w)];
                                        result=[result;re];
                                        save result;
                                        RI=[];
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


%% output parameters
time
% Alzheimer's Classifier (Extra Credit problem)
% Date: 4/4/13
% Written by: Zifan Zhang
% Description:
%   This m-file is used for the data file 'hl_pauses_11.csv'
%
% Date: Apr 3rd, 2013
% Zifan Zhang

close all
clear all
clc

%% Data Preparation
filename = 'hl_pauses_11.xlsx';

Dx = xlsread(filename,'B:B');
raw_feat = xlsread(filename,'C2:X103'); 

N = length(Dx);
[l,m] = size(raw_feat);

raw_feat_norm = zscore(raw_feat);

LDA_feat = zeros(N,m);
for j = 1:m
    LDA_feat(:,j) = scatter_plot(raw_feat(:,j)',Dx');
end

inputs = LDA_feat';
targets = Dx';

%% Set up the Network


epochs = 200;

%% Create the Network
ratio_trn = zeros(1,25);
ratio_tst = zeros(1,25);
for i = 1:25
    net = patternnet([20 20]);
    net.performFcn = 'mse';
    net.trainParam.goal = 0.0000000005;
    net.trainParam.epochs = epochs;
    net.trainParam.min_grad = 1e-100000;
    net.divideParam.trainRatio = 0.7;
    net.divideParam.testRatio = 0.2;
    net.divideParam.valRatio = 0.1;

    %% Train and Test
    [net tr] = train(net,inputs,targets);
    outputs = net(inputs);

    inputs_trn = inputs(:,tr.trainInd);
    targets_trn = targets(:,tr.trainInd);
    inputs_tst = inputs(:,tr.testInd);
    targets_tst = targets(:,tr.testInd);
    outputs_trn = outputs(tr.trainInd);
    outputs_tst = outputs(tr.testInd);

    [c,cm] = confusion(targets_trn,outputs_trn);

    fprintf('Percentage Correct Classification(Train)   : %f%%\n', 100*(1-c));
    ratio_trn(i) = 100*(1-c);
    
    [c,cm] = confusion(targets_tst,outputs_tst);

    fprintf('Percentage Correct Classification(Test)   : %f%%\n', 100*(1-c));
    disp('-----------------------------------------------------------')
    ratio_tst(i) = 100*(1-c);

end
mean_train = mean(ratio_trn)
figure(1990)
hist(ratio_trn,20);
title('Average Training Error Rate Histogram')
xlabel('Error Rate')
ylabel('Counts')

pause

mean_test = mean(ratio_tst)
figure(0528)
hist(ratio_tst,20);
title('Average Test Error Rate Histogram')
xlabel('Error Rate')
ylabel('Counts')

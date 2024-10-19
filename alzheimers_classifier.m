% Alzheimer's Classifier (Extra Credit problem)
% Date: 4/4/13
% Written by: Zifan Zhang
% Description:
%   This m-file is used for the data file 'hl_pauses_11.csv'
%   It required 'scatter_plot' function 
%   And 'mahalanobttis_classifier' and 'scatter_mat' functions
%
% Date: Apr 3rd, 2013
% Zifan Zhang

close all
clear all
clc

disp('Input 1: use "data_pauses.xlsx" (11 Features)')
disp('Input 2: use "hl_pauses_11.xlsx" (22 Features)')
file_num = input('Please input a valid number: ');
if file_num == 1
    filename = 'data_pauses.xlsx';
elseif file_num == 2
    filename = 'hl_pauses_11.xlsx';
end

global i
i = 1;

Dx = xlsread(filename,'B:B');
raw_feat = xlsread(filename,'C2:X103'); 

raw_feat_norm = zscore(raw_feat);

N = length(Dx);
[l,m] = size(raw_feat);

LDA_feat = zeros(N,m);
for j = 1:m
    LDA_feat(:,j) = scatter_plot(raw_feat(:,j)',Dx');
end
feat_ind = [2 6 22];
LDA_feat_norm = LDA_feat(:,feat_ind);

err_trn = zeros(1,100);
err_tst = zeros(1,100);
iter = 1000; % iteration number


disp(' ')
rate = input('Please input percent of the training set:(from 0.2 to 0.99) ');


for k = 1:iter
    ind = 1:N;
    ind1 = randperm(N,round(N*rate));
    ind2 = setdiff(ind,ind1);

    dataset1 = LDA_feat_norm(ind1,:);
    dataset2 = LDA_feat_norm(ind2,:);
    Dx1 = Dx(ind1)+1;
    Dx2 = Dx(ind2)+1;
    
    count = hist(Dx1,unique(Dx1));

    n = length(Dx1);
    n1 = length(dataset1(Dx1 == 1));
    n2 = length(dataset1(Dx1 == 2));
    
    m_hat = [mean(dataset1(Dx1 == 1,:))' mean(dataset1(Dx1 == 2,:))'];

    S_hat = count(1)/length(Dx1)*cov(dataset1(Dx1 == 1,:)) ...
        + count(2)/length(Dx1)*cov(dataset1(Dx1 == 2,:));

    z_mahalanobis1 = mahalanobis_classifier(m_hat,S_hat,dataset1')';
    err_trn(k) = (1-length(find(Dx1==z_mahalanobis1))/length(Dx1));


    z_mahalanobis2 = mahalanobis_classifier(m_hat,S_hat,dataset2')';
    err_tst(k) = (1-length(find(Dx2 == z_mahalanobis2))/length(Dx2));
end

err_trn_mean = mean(err_trn)
figure(1990)
hist(err_trn,20);
title('Average Training Error Rate Histogram')
xlabel('Error Rate')
ylabel('Counts')

pause

err2_tst_mean = mean(err_tst)
figure(0528)
hist(err_tst,20);
title('Average Test Error Rate Histogram')
xlabel('Error Rate')
ylabel('Counts')


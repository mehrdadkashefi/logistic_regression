% Purpose: This program loads a sample dataset from matlab. The idea is to
% use linear regression as a classifier.
%
% record of revisions :
%      date           programmer          description of change
%      ====           ==========          =====================
%    6/12/2019      Mehrdad Kashefi           original code 
% ...................................................................
% define variables:
%.............................................
clear;
clc;
close all;
% Load the dataset
[X,y] = cancer_dataset;
%[X,y] = glass_dataset;  
% Transposing the data
X = X';
y = y(1,:)';
% Count number of data in order to separate the Test and Train set
num_train = floor(length(X)*0.7);
X = [ones(length(X),1),X];

X_train = X(1:num_train,:);
X_test = X(num_train:end,:);

y_train = y(1:num_train,:);
y_test = y(num_train:end,:);
% Scatter plot of data using to features
index_1 = y_train==0;
index_2 = y_train==1;
scatter(X_train(index_1,4),X_train(index_1,7),'r');
hold on 
scatter(X_train(index_2,4),X_train(index_2, 7),'b');
% Classify the samples using linear regression
beta = inv(X_train'*X_train)*X_train'*y_train;

y_test_pred =  X_test*beta;
y_test_pred(y_test_pred>=0.5) = 1;  % Use 0.5 as a thereshold
y_test_pred(y_test_pred<0.5) = 0;
acc_test = sum(y_test==y_test_pred)/length(y_test);
% Display the accuracy
disp(['Test accuracy is ', num2str(acc_test)]);
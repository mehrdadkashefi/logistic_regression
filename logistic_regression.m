% Purpose: This program loads a sample dataset from matlab. The idea is to
% use Logistic Regression to classify the samples.
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
% Load Cancer dataset
[X,y] = cancer_dataset;
% Transpose the data 
X = X';
y = y(1,:)';
% Count number of data to form the Test adn Train dataset
num_train = floor(length(X)*0.7);
X = [ones(length(X),1),X];

X_train = X(1:num_train,:);
X_test = X(num_train:end,:);

y_train = y(1:num_train,:);
y_test = y(num_train:end,:);
% Define functions
sig = @(x) (1./(1+exp(-x))); % Sigmoid Function
loss = @(y,y_pred) -y.*log(y_pred) - (1-y).*log(1-y_pred); % Logistic Loss

%% Logistic Regression
% Initialization
max_iter = 1000;
cost_hist = zeros(max_iter,1);
w_ini = randn(10,1);
lambda = 0.1; % learning rate

for i = 1:max_iter
    z = X_train * w_ini;
    y_pred = sig(z);
    Cost = mean(loss(y_train,y_pred));
    cost_hist(i) = Cost;
    grad = (y_train - y_pred).*X_train;
    Grad = mean(grad,1);
    w_ini = w_ini + lambda *Grad';
end
% Plot the learning curve
figure(1)
plot(cost_hist,'LineWidth',2)
xlabel('iteration')
ylabel('Cost')


% Validation with Train set
z = X_train * w_ini;
y_train_pred = sig(z);

y_train_pred(y_train_pred>=0.5) = 1;
y_train_pred(y_train_pred<0.5) = 0;

acc_train = sum(y_train==y_train_pred)/length(y_train);
disp(['Train accuracy is ', num2str(acc_train)]);

% Validation with test set
z = X_test * w_ini;
y_test_pred = sig(z);

y_test_pred(y_test_pred>=0.5) = 1;
y_test_pred(y_test_pred<0.5) = 0;

acc_test = sum(y_test==y_test_pred)/length(y_test);
disp(['Test accuracy is ', num2str(acc_test)]);
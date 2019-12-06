% Gradient Descent
% Purpose: This is a sample program to illustrate how Gradient Descent will
% calculate the minimum value of a simple sphere function.
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
% Define a meshgrid
[X1,X2] = meshgrid(-2:0.1:2,-2:0.1:2);
Y = X1.^2 + X2.^2;

figure(1)
surface(X1,X2,Y)
view(3)
figure(2)
contour(X1,X2,Y,20) % plot the contour of the sphere (equipotential lines)

% Intializing
x_intial = [-2 ;-2];
x_min = x_intial;
lambda = 0.1; % learning rate
num_iter = 50;
x_hist = zeros(2, num_iter); % A history of potential minimum values

for i=1:num_iter
    x_min = x_min - lambda*[2*x_min(1); 2*x_min(2)];
    x_hist(:,i) = x_min;
    figure(2)
    hold on
    scatter(x_hist(1,i),x_hist(2,i),'x','r')
    pause(0.1)
    disp(['Iteration: ',num2str(i),' Cost: ',num2str(x_min(1)^2+ x_min(2)^2)])
end
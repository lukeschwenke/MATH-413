% Lab 5 - Luke Schwenke - 11/16/18
% Least Squares Using Modified Gram-Schmidt Orthogonalization

x = BuoyData(:,[5]); % Column 5 - temperature in degrees C - Independent 
y = BuoyData(:,[6]); % Column 6 - pC02 in uatm (micro atmospheres) - Dependent

%% Problem 1 (Linear Model)

% Create A matrix
h = size(x);
A = ones(h);
A = [A, x]; % A = 2063 x 2

C = eye(length(A), length(A) -2); % Add linearly indep. columns from Identity matrix
A = [A, C]; % A = 2063 x 2063 <-- Size of the matrix we want

n = length(x);
% Get Q & R
[Q,R] = gram_schmidt(A);

% Get Coefficients
b_linear = Q'*y;
c_linear = R(1:2,1:2)\b_linear(1:2) % n = 2 for Linear (Method from textbook pg.218)

% Coefficients: 
% 343.6178 --> b
% 3.2003   --> m

% Linear Residual: 
lin_resid = norm(R*c_linear - Q'*y)% VALUE: 1.3501e+04

% Plot fit line over actual data set:
x_temp = 2:0.1:22; %1x201
y_new = 3.2003*x_temp + 343.6178; %1x201

plot(x,y,'.');
hold on
plot(x_temp,y_new);
hold on

%% Problem 2 (Quadratic Model)

x_data = BuoyData(:,[5]); % Column 5 - temperature in degrees C - Independent 
y_data = BuoyData(:,[6]); % Column 6 - pC02 in uatm (micro atmospheres) - Dependent

p = size(x_data);
A_2 = ones(p);
A_2 = [A_2, x_data, x_data.^2];

D = eye(length(A_2), length(A_2) -2); % Add linearly indep. columns from Identity matrix
A_2 = [A_2, D]; % A = 2063 x 2063 

k = length(x_data);
[Q_new,R_new] = gram_schmidt(A_2);
R_new = R_new(:,1:n); % Trim last column off <-- Won't trim off in gram_schmidt code for some reason.

b_quadratic = Q_new'*y_data;
c_quadratic = R_new(1:3,1:3)\b_quadratic(1:3) % n = 3 for Quadratic (Method from textbook pg.218)

% Coefficients:
% 357.7263 --> b
% -0.3796  --> m
%  0.1613  --> c

% Quadratic Residual:
quad_resid = norm(R_new*x - Q_new'*y_data) % VALUE: 4.8181e+04

% Plot fit line over the linear line and actual data set:
x_temp = 2:0.1:22;
y_quad = 0.1613*x_temp.^2 + -0.3796*x_temp + 357.7263;

plot(x_temp,y_quad);
title('Plots of Linear & Quadratic Models through Buoy Data')
xlabel('Temperature (C)') 
ylabel('pCO2 (uatm)')
legend({'Actual Data', 'y = mx+b (Linear Model)','y = cx^2 + mx + b (Quadratic Model)'})
hold off

%% Problem 3 (Evaluating Error w/ Chi-Sqr. Statistic)

% n = number of data points
% O = observational data point (actual data)
% E = expected value (from model)
% Sigma = variance of data <-- Ignore
% v = degrees of freedom (number of data points minus number of parameters being fit)

% Chi-Sqr Linear: 
y_eval_lin = 3.2003*x + 343.6178; 
(sum(abs(y - y_eval_lin).^2)) / 2062 % 953.5064

% Chi-Sqr Quadratic:
y_eval_quad = 0.1613*x.^2 + -0.3796*x + 357.7263;
(sum(abs(y - y_eval_quad).^2)) / 2061 % 935.8910 

% NOTE: Residuals calculated above in Problem 1 and 2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conclusion: Based on the reported Chi-Sqr statistics, our Quadratic Model
% is better at fitting the Buoy Data. These results agree with what we
% concluded from the Residuals (calculated in problems 1 and 2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FUNCTION

% QR Decomposition - Gram Schmidt Orthogonalization

function [Q,R] = gram_schmidt(A)
[m,n] = size(A);
Q = zeros(m,m); % We want Q to be mxm
R = zeros(m,n); % We want R to be nxn - 2 for Linear case , 3 for Quadratic

% Based off of Pseudo code from class 11/13
for j = 1:m % 1, 2, m...
    y = A(:,j); % y = Aj
    for i = 1: j-1 % i = 1, 2, ..., j-1
        R(i,j) = Q(:,i)'*y; % A was replaced as y for computational purposes
        y = y-R(i,j)*Q(:,i); % y = y-rijqi
    end
    R(j,j) = norm(y); % rjj = ||y||2 (2 norm)
    Q(:,j) = y/R(j,j); % qj = y/rjj
end
R = R(:,1:n); % Chop off the columns you do not need
end



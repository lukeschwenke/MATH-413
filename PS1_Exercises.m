% Luke Schwenke - Problem Set #1 - 9/7/18

clear all

%% Problem 1 
w = 5;
x = sqrt(2);
y = 4^3;
z = randi([1 20],1,1) %random int
a = x * y * z;
b = (w+y) / (x+z);

%% Problem 2 
g = 1+rand(1,1)*(100-1) %random number
if g > 50
    g = g / 2;
end
if g >= 50
    g = g * 2;
end

%% Problem 3 
x = 10;
while x > 0
    x = x / 2
end % It does terminate at 0, but it technically shouldn't. 

%% Problem 4 
x = 1:3
while sum(x < 20)
    x(1) = x(2);
    x(2) = [];
    x(3) = sum(x);
end
x

%% Problem 5 
A = zeros(3,3);
A(:,1) = [1 2 3];
A(:,2) = [2 -1 0];
A(:,3) = [3 1 -1];

b = [9 
     8 
     3];

Transpose = A' * b;
Transpose

%% Problem 6 (function at bottom of page)

%Test Values
A = [1 2 3 
    4 5 6
    7 8 9 ];
B = [11 12 13
    14 15 16
    17 18 19];

[A, B] = Problem6function(A, B);

%function [A, B] = Problem6function(A, B);
%    a = A(end,:);
%    b = B(end,:);
%    A(end,:) = b;
%    B(end,:) = a;
%end

%% Problem 7 (function at bottom of page)

%Test values
data = [1 3 5 7 10 32 44 45 60 90];
minval = 44;

data_new_values = Problem7function(data, minval);

%function data_new_values = Problem7function(data, minval)
%    data_new = find(data < minval);
%    data_new_values = 2* (data(data_new));  
%end

%% Problem 8
x = 0:.01:10; % Start : Step : End
y = sin(x);
plot(x,y);
title('Graph of Sine');
xlabel('0 < x < 10');
ylabel('Sine Values'); 

%% Problem 9
z = cos(x);
plot(x,y)
title('Graph of Sine & Cosine')
hold on
plot(x,z,'--')
legend('y = sin(x)','z = cos(x)');
xlabel('0 < x < 10');
ylabel('Sine & Cosine Values');

%% Problem 10
x = linspace(-3,3,100);
y = x;
[X,Y] = meshgrid(x,y); % 2-D grid coordinates based on the coordinates contained in vectors x and y
Z = (1000 / sqrt(2*pi)) * exp((-X.^2)/2 - (Y.^2)/2);
surf(Z);
shading interp; % Gets rid of grid lines
title('3D Gaussian');

%% FUNCTION OUTPUTS

function [A, B] = Problem6function(A, B);
    a = A(end,:);
    b = B(end,:);
    A(end,:) = b;
    B(end,:) = a;
end


function data_new_values = Problem7function(data, minval)
    data_new = find(data < minval);
    data_new_values = 2* (data(data_new));  
end








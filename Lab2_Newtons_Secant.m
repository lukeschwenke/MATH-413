% Luke Schwenke - Lab Project #2 Newton's and Secant Method

%% Problem 1 

fun = @(x) (4*pi)*(100-(x-10).^2);
fun2 = @(x) integral(fun, 0, x) - 5000;

a=0;
b=20; % Initial range given

[root, count] = bisect(fun2, a, b)

% ANSWER: In an emergency, the water height needs to be 7.242307662963867 meters for the
% water to last 5 days. It took 20 iterations to converge to this answer.

% FUNCTION LOCATED AT BOTTOM OF FILE

%% Problem 2
% Newton's Method

x0 = 2*root; % Where root is the answer from Problem 1 (7.24230...)
cap =10 ^ -5; % Error

fun_two = @(x) integral(fun, 0, x) - 10000;
fun_prime = @(x) (4*pi)*(100-(x-10).^2);


[root2, count] = Newtons(x0, fun_two, fun_prime, cap)

% ANSWER: In an emergency, the water height needs to be 11.298376416962114 meters for the
% water to last 10 days. It took 4 iterations to converge to this answer.

% FUNCTION LOCATED AT BOTTOM OF FILE


%% Problem 3
% Secant Method

x0 = root; % Where root is the answer from Problem 1 (7.24230...)
x1 = root2; % Where root2 is the answer from Problem 2 (11.298376...)
cap = 10 ^ -5; % Error

fun3 = @(x) integral(fun, 0, x) - 7000;

[root3, count] = Secant(fun3, x0, x1, cap)

% ANSWER: In an emergency, the water height needs to be 8.899311336840569 meters for the
% water to last 7 days. It took 4 iterations to converge to this answer.

% FUNCTION LOCATED AT BOTTOM OF FILE

%% FUNCTIONS (Bisection, Newton's, Secant)

% Bisection

function [root, count] = bisect(f, a, b)
if f(a)*f(b) > 0
        error('f(a)*f(b) < 0 Not True!')
end

count = 0;
while (b-a) / 2 > (10 ^ -5)
    c = (a + b) / 2;
    if f(a)*f(c) < 0
        b = c;
    else
        a = c;
    end
    count = count + 1; %Count
end
root = (a+b) / 2;
end

% Newton's

function [root2, count] = Newtons(x0, fun_two, fun_prime, cap)
imaximum = 10000;
count = 0;
for i = 1:imaximum
    xi = x0 - feval(fun_two, x0) / feval(fun_prime, x0);
    count = count + 1;
    if abs(xi - x0) < cap
        root2 = xi;
        break
    end
    x0 = xi; 
end

if i == imaximum
   fprintf('No Soultion')
   root2 = ('NA')
end

% Secant

function [root3, count] = Secant(fun3, x0, x1, cap)
imaximum = 10000;
count = 0;
for i = 1:imaximum
    funx1 = feval(fun3, x1);
    xi = x1 - funx1.*(x0-x1)/(feval(fun3,x0)-funx1); 
    count = count + 1;
    if abs((xi - x1)/x1) < cap
        root3 = xi;
        break
    end
    x0 = x1;
    x1 = xi;
end
if i == imaximum
   fprintf('No Soultion')
   root2 = ('NA')
end





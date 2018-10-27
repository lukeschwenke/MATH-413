% Lab 4 Interpolation - Luke Schwenke - 10/26/18

%% Vandermonde Interpolation

% Years
x = (1920:10:2010)';
x = (x - 1965)/45;

% Population
y = [106.5, 123.1, 132.1, 152.3, 180.7, 205.1, 226.5, 249.6, 282.2, 309.3]';
n = length(x);

% Create vandermonde matrix
V = Vandermonde(x, n);
V = fliplr(V);

c = V(:,n-9:n)\y; %Using degree of 9. NOTE: This is also the default
c = flipud(c);

a = c;
years = (1920:10:2020);
years = (years-1965)/45;
x = years';
pVal = HornerV(a,x)

% ANSWER PART 1:
% -24.8000 people
% I do not believe this answer is accurate because 1) it is negative and 2)
% interpolation overfits the data (captures all the errors and anomolies).


c = V(:,n-4:n)\y % Using degree of 4 (manually chop off part of Vandermonde)
c = flipud(c)

a = c;
years = (1920:10:2020);
years = (years-1965)/45;
x = years';
pVal = HornerV(a,x) % Evaluate using this function

%ANSWER PART 2:
% 343.9250 million people
% I believe this answer is more accurate because reducing the order of the
% polynomial gives a better fit. This number is also much more realistic.

% Vandermonde Function
%function V = Vandermonde(x, n) % n is # cols and d is degree
%x = x(:);  % Column vector since we want to take it in columns
%V = ones(length(x), n);
%for i = 2:n
%  V(:, i) = x .* V(:, i-1); 
%end

% Evaluate Function
%function pVal = HornerV(a,z)
%n = length(a);
%m = length(z);
%pVal = a(n)*ones(size(z));
%for k=n-1:-1:1
%    pVal = z.*pVal + a(k);
%end

%% Newton's Interpolation

x = (1920:10:2010)';
x = (x - 1965)/45;

% Population
y = [106.5, 123.1, 132.1, 152.3, 180.7, 205.1, 226.5, 249.6, 282.2, 309.3]';
n = length(x); % Number of data points

c = newtondd(x,y,n)' % Array of d+1 coefficients

% Evaluate
x = (1920:10:2010)';
x = (x - 1965)/45;
years = (1920:10:2020);
years = (years-1965)/45;
z = years';
pVal = HornerN(c,x,z)

%ANSWER PART 3:
% -24.8000 million people
% This is the same as PART 1 since it is degree 9

% Newton's DD Function
%function c = newtondd(x,y,n)
%for j=1:n
%  v(j,1)=y(j);
%end
%for i=2:n
%  for j=1:n+1-i
%v(j,i)=(v(j+1,i-1)-v(j,i-1))/(x(j+i-1)-x(j));
%  end
%end
%for i=1:n
%  c(i)=v(1,i);        
%end

% Evaluation Function:
%function pVal = HornerN(c,x,z)
%n = length(c);
%pVal = c(n)*ones(size(z));
%for k=n-1:-1:1
%pVal = (z-x(k)).*pVal + c(k);
%end


%% Piecewise Interpolation

% PART 4: Creating the function [COMPLETE]

for N = [2, 4, 8, 16, 32, 64, 128, 256, 512]
x1 = linspace(-1, 1, N);
y1 = 1./(1+25.*x1.^2)';
end

for N = [2, 4, 8, 16, 32, 64, 128, 256, 512]
    x2 = linspace(-1, 1, 10*N);
    v = piecewise(x1,y1,x2); % Using piecewise function
    Max_error = max(y1) - max(v(1:10:end)) % Calculate the max difference between interpolation and actual function.
end

% ANSWER PART 5:
% Max_error =
% 0.0545 -- N=2
% 0.0061 -- N=4
%-0.0091 -- N=8
%-0.0115 -- N=16
%-0.0110 -- N=32
%-0.0116 -- N=64
%-0.0119 -- N=128
%-0.0108 -- N=256
%-0.0127 -- N=512
% From this, it appears as N increases our error decreases

% Alternative (I am not exactly sure which method is correct)
for N = [2, 4, 8, 16, 32, 64, 128, 256, 512]
x1 = linspace(-1, 1, N);
y1 = 1./(1+25.*x1.^2)';
x2 = linspace(-1, 1, 10*N);
v = piecewise(x1,y1,x2); % Using piecewise function
Max_error = max(y1) - max(v(1:10:end))
end

% 0.0000 -- N=2
%-0.2088 -- N=4
%-0.4466 -- N=8
%-0.3925 -- N=16
%-0.2031 -- N=32
%-0.0984 -- N=64
%-0.0508 -- N=128
%-0.0254 -- N=256
%-0.0127 -- N=512

% Piecewise function:
%function v = piecewise(x1,y1,x2)
%delta = diff(y1)./diff(x1);
%n = length(x1);
%k = ones(size(x2));
%for j = 2:n-1
%k(x1(j) <= x2) = j;
%end
% Evaluate interpolant
%s = x2 - x1(k);
%v = y1(k) + s.*delta(k);


%% FUNCTIONS

% Vandermonde:
function V = Vandermonde(x, n) % n is # cols
x = x(:);  % Column vector since we want to take it in columns
V = ones(length(x), n);
for i = 2:n
  V(:, i) = x .* V(:, i-1); 
end

% Evaluate Polynomial --> HornerV:
function pVal = HornerV(a,z)
n = length(a);
m = length(z);
pVal = a(n)*ones(size(z));
for k=n-1:-1:1
    pVal = z.*pVal + a(k);
end

% Newton's Divided Difference:
function c = newtondd(x,y,n)
for j=1:n
  v(j,1)=y(j);
end
for i=2:n
  for j=1:n+1-i

v(j,i)=(v(j+1,i-1)-v(j,i-1))/(x(j+i-1)-x(j));
  end
end
for i=1:n
  c(i)=v(1,i);        
end

% Evaluate Newton's DD --> HornerN:
function pVal = HornerN(c,x,z)
n = length(c);
pVal = c(n)*ones(size(z));
for k=n-1:-1:1
pVal = (z-x(k)).*pVal + c(k);
end

% Piecewise Interpolation:
function v = piecewise(x,y,u)
delta = diff(y)./diff(x);
n = length(x);
k = ones(size(u));
for j = 2:n-1
k(x(j) <= u) = j;
end
s = u - x(k);
v = y(k) + s.*delta(k);



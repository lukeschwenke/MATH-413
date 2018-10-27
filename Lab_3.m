% Luke Schwenke - Lab #3 Solving Systems of Equations (LU Decomposition) 
% 9/28/18

%% Question 1 - 2.3

a = (1 / sqrt(2)); % 0.7071

% f: 1 2 3 4 5 6 7 8 9 10 11 12 13
A_old = [0 1 0 0 0 -1 0 0 0 0 0 0 0;
     0 0 1 0 0 0 0 0 0 0 0 0 0;
     a 0 0 -1 -a 0 0 0 0 0 0 0 0;
     a 0 1 0 a 0 0 0 0 0 0 0 0;
     0 0 0 1 0 0 0 -1 0 0 0 0 0;
     0 0 0 0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 a 1 0 0 -a -1 0 0 0;
     0 0 0 0 a 0 1 0 a 0 0 0 0;
     0 0 0 0 0 0 0 0 0 1 0 0 -1;
     0 0 0 0 0 0 0 0 0 0 1 0 0;
     0 0 0 0 0 0 0 1 a 0 0 -a 0;
     0 0 0 0 0 0 0 1 a 0 1 a 0;
     0 0 0 0 0 0 0 0 0 0 0 a 1];
 
 % Re-order Matrix with the following pattern since there are 0's in diagonal of A_old
 % Pattern: 3, 1, 2, 5, 4, 7, 6, 11, 8, 9, 10, 12, 13
 
 A = [a 0 0 -1 -a 0 0 0 0 0 0 0 0;
     0 1 0 0 0 -1 0 0 0 0 0 0 0;
     0 0 1 0 0 0 0 0 0 0 0 0 0;
     0 0 0 1 0 0 0 -1 0 0 0 0 0;
     a 0 1 0 a 0 0 0 0 0 0 0 0;
     0 0 0 0 a 1 0 0 -a -1 0 0 0;
     0 0 0 0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 0 0 0 1 a 0 0 -a 0;
     0 0 0 0 a 0 1 0 a 0 0 0 0;
     0 0 0 0 0 0 0 0 0 1 0 0 -1;
     0 0 0 0 0 0 0 0 0 0 1 0 0;
     0 0 0 0 0 0 0 1 a 0 1 a 0;
     0 0 0 0 0 0 0 0 0 0 0 a 1];

B = [0;
     10;
     0;
     0;
     0;
     0;
     0;
     15;
     0;
     20;
     0;
     0;
     0];
 
% Note: Functions are located at the bottom of this file
[L,U,x] = lu_decomp(A, B)
x = forward(A, B)
x = backward(A, B)

% OUTPUTS / ANSWERS:
% LU Decomp OUTPUT:
% I did not print out L and U since they were very large
% x =
%         0
%         0
%         0
%         0
%         0
%         0
%         0
%  540.0000
%  189.2164
%  640.0000
%         0
% -108.6396
%   45.0000

% Forward Subtitution OUTPUT:

% x =
%         0
%   10.0000
%         0
%         0
%         0
%         0
%         0
%   15.0000
%         0
%   20.0000
%         0
%  -21.2132
%   15.0000

% Backward Substitution OUTPUT:

%x =
%   21.2132
%   30.0000
%         0
%   15.0000
%         0
%   20.0000
%         0
%   15.0000
%         0
%   20.0000
%         0
%         0
%         0


%% ----------------------------------------------------------------------

% Question 2 - 2.4

%Define these:
r12 = 12;
r13 = 13;
r14 = 14;
r23 = 23;
r25 = 25;
r34 = 34;
r35 = 35;
r45 = 45;

vs = 25; %Source Voltage

B = [0
     0
     0
     vs]; %b

A = [r25+r12+r14+r45, -r12, -r14, -r45;
     -r12, r23+r12+r13, -r13, 0;
     -r14, -r13, r14+r13+r34, -r34;
     -r45, 0, -r34, r35+r45+r34]; %R

% Solve for unknown using these 3 methods (i = R\b)
% Note: Functions are located at the bottom of this file
x = forward(A, B) %i
x = backward(A , B) %i
[L,U,x] = lu_decomp(A, B) %i

%OUTPUTS/ANSWERS:

%Forward Subtitution OUTPUT:
%x =
%         0
%         0
%         0
%    0.2193

%Backward Subtitution OUPUT:
%x =
%    0.1248
%    0.0331
%    0.1222
%    0.2193

%LU Decomp OUTPUT:
%L =
%    1.0000         0         0         0
%   -0.1250    1.0000         0         0
%   -0.1458   -0.3172    1.0000         0
%   -0.4688   -0.1210   -0.7802    1.0000

%U =
%   96.0000  -12.0000  -14.0000  -45.0000
%         0   46.5000  -14.7500   -5.6250
%         0         0   54.2796  -42.3468
%         0         0         0   59.1885

%x =
%         0
%         0
%         0
%    0.8448

% ----- 

%Values of g are 1/r as stated in the problem
g12 = 1/r12;
g13 = 1/r13;
g14 = 1/r14;
g23 = 1/r23;
g25 = 1/r25;
g34 = 1/r34;
g35 = 1/r35;
g45 = 1/r45;

B = [0;
     0;
     g35*vs;
     0]; %c

A = [g12+g13+g14, -g12, -g13, -g14;
    -g12, g12+g23+g25, -g23, 0;
    -g13, -g23, g13+g23+g34+g35, -g34;
    -g14, 0, -g34, g14+g34+g45]; %G

% Solve for unknown using these 3 methods (v = G\c)
% Note: Functions are located at the bottom of this file
x = forward(A, B) %v
x = backward(A , B) %v
[L,U,x] = lu_decomp(A, B) %v

%OUTPUTS/ANSWERS:

%Forward Substitution OUPUT:
%x =
%         0
%         0
%    4.0042
%    0.9570

%Backward Substitution OUTPUT:
%x =
%    1.7048
%    1.0437
%    4.0042
%         0

%LU Decomp OUTPUT:
%L =
%    1.0000         0         0         0
%   -0.3597    1.0000         0         0
%   -0.3320   -0.5199    1.0000         0
%   -0.3083   -0.1878   -0.5739    1.0000

%U =
%    0.2317   -0.0833   -0.0769   -0.0714
%         0    0.1368   -0.0711   -0.0257
%         0         0    0.1159   -0.0665
%         0         0         0    0.0581

%x =
%         0
%         0
%   59.3826
%    7.0596

%% Functions

%LU Decomp
function [L,U,x] = lu_decomp(A,B)

% Is A square?
[m, n]=size(A);
if (m ~= n ) 
error( 'Need Square Matrix' );
end
  % Decompose matrix into L and U
  L=zeros(m,m);
  U=zeros(m,m);
  for i=1:m
  % Find L
  for k=1:i-1
  L(i,k)=A(i,k);
  for j=1:k-1
  L(i,k)= L(i,k)-L(i,j)*U(j,k);
  end
  L(i,k) = L(i,k)/U(k,k);
  end
  % Find U
  for k=i:m
  U(i,k) = A(i,k);
  for j=1:i-1
  U(i,k)= U(i,k)-L(i,j)*U(j,k);
  end
  end
  end
  for i=1:m
  L(i,i)=1;
  end
  % Report them
  U;
  L;
  % Now use vector y to solve Ly=b
  y=zeros(m,1);
  y(1)=B(1)/L(1,1);
  for i=2:m
  y(i)=-L(i,1)*y(1);
  for k=2:i-1
  y(i)=y(i)-L(i,k)*y(k);
  y(i)=(B(i)+y(i))/L(i,i);
  end
  end
% Now use y to solve Ux = y
x=zeros(m,1);
x(1)=y(1)/U(1,1);
for i=2:m
x(i)=-U(i,1)*x(1);
for k=i:m
      x(i)=x(i)-U(i,k)*x(k);
      x(i)=(y(i)+x(i))/U(i,i);
end
end

%-------------------------
%Forward
function x = forward(A, B)

% Is A square?
[m,n] = size(A);
if m ~= n
error('A must be square')
end

% Forward sub
x(1) = B(1)/A(1,1);
for i = 2:1:m 
x(i) = (B(i)-A(i,1:i-1)*x(1:i-1)')/A(i,i);
end
x = x';

%-------------------------
%Backward
function x = backward(A, B);

% Is A square?
[n, m]=size(A);
if n~=m
error('A must be square');
end

% Back sub
x=zeros(n,1);
x(n)=B(n)/A(n,n);
for i=n-1:-1:1
x(i)=(B(i)-A(i,i+1:n)*x(i+1:n))/A(i,i);
end
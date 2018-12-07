% Luke Schwenke
% Lab 6 - Numerical Integration
% 12/07/2018

load IcebergDataLab6.mat

xTilt = xTilt';
zTilt = zTilt';

xNoTilt = xNoTilt';
zNoTilt = zNoTilt';

%% Problem 1

% Calculate bouyant force for titled and untilted iceberg strips
% There will be 4 calculated forces in total
% Formula: Fb = Vpg where V = volume, p = 1030kg/m^3 (water density),
% g = 9.81m/s^2 (gravity)
% Note: y = 1 so the Volumes = Areas 

%  f = vector containing equally spaced values of the function to be
%  integrated (z in iceberg case)
%  a= Initial point of interval
%  b= Last point of interval
%  n= # of sub-intervals

p = 1030;
g = 9.81;
n = 32;

%%%%%%%%%%%%%%%%%%%%%%%%% Titled Iceberg %%%%%%%%%%%%%%%%%%%%%%%%%
zTilt = zTilt;
xTilt = xTilt;

a = xTilt(1);
b = xTilt(end);

%%%%%%%%%%%%%%%%%%%%%%%%% Trapezoid:
f = zTilt;
integral_trap_tilt = final_trap(f,a,b,n)
% My Area = 803.9437
% MATLAB Trapz = 803.9437

Buoyant_Force_trap_tilt = integral_trap_tilt * 1 * p * g
% ANSWER = 8.1233e+06

%%%%%%%%%%%%%%%%%%%%%%%%% Simpsons:
f = zTilt;
integral_simp_tilt = simpsons(f,a,b,n)
f = zTilt(end-1:end);
a = xTilt(end-1);
b = xTilt(end);
n = 2;
add_on_simp_tilt = final_trap(f,a,b,n)
final_simpson_tilt = integral_simp_tilt + add_on_simp_tilt 
% Area = 802.9426 
Buoyant_Force_simp_tilt = final_simpson_tilt *1 * p * g
% ANSWER: 8.1132e+06


%%%%%%%%%%%%%%%%%%%%%%%%% Non-Titled Iceberg %%%%%%%%%%%%%%%%%%%%%%%%%
zNoTilt = zNoTilt;
xNoTilt = xNoTilt;

n = 32;
a = xNoTilt(1);
b = xNoTilt(end);

%%%%%%%%%%%%%%%%%%%%%%%%% Trapezoid:
f = zNoTilt;
integral_trap_NO_tilt = final_trap(f,a,b,n)
% My value = 800.8230
% MATLAB Trapz = 800.8230
Buoyant_Force_trap_no_tilt = integral_trap_NO_tilt *1 * p * g
% ANSWER: 8.0918e+06

%%%%%%%%%%%%%%%%%%%%%%%%% Simpsons:
f = zNoTilt;
integral_simp_NO_tilt = simpsons(f,a,b,n)
f = zNoTilt(end-1:end);
a = xNoTilt(end-1);
b = xNoTilt(end);
n = 2;
add_on_simp_NO_tilt = final_trap(f,a,b,n)
final_simpson_NO_tilt = integral_simp_NO_tilt + add_on_simp_NO_tilt 
% Area = 801.6831
Buoyant_Force_simp_no_tilt = final_simpson_NO_tilt *1 * p * g
% ANSWER: 8.1004e+06

%% Problem 2

%%%%%%%%%%%%%%%%%%%%%%%%% Titled Iceberg %%%%%%%%%%%%%%%%%%%%%%%%%
z = zTilt;
x = xTilt;
n = 32;
a = x(1);
b = x(end);

% Feed x*z into the f here
f = x.*z;

%%%%%%%%%%%%%%%%%%%%%%%%% Trapezoid
answer1 = final_trap(f,a,b,n)
center1 = answer1 / integral_trap_tilt
% ANSWER: 27.2646

%%%%%%%%%%%%%%%%%%%%%%%%% Simpsons
answer2 = simpsons(f,a,b,n)
center2 = answer2 / final_simpson_tilt
% ANSWER: 27.1123

%%%%%%%%%%%%%%%%%%%%%%%%% Non-Titled Iceberg %%%%%%%%%%%%%%%%%%%%%%%%%
z = zNoTilt;
x = xNoTilt;
n = 32;
a = x(1);
b = x(end);

% Feed x*z into the f here
f = x.*z;

%%%%%%%%%%%%%%%%%%%%%%%%% Trapeziod
answer3 = final_trap(f,a,b,n);
center3 = answer3 / integral_trap_NO_tilt
% ANSWER: 27.9056

%%%%%%%%%%%%%%%%%%%%%%%%% Simpsons
answer4 = simpsons(f,a,b,n);
center4 = answer4 / final_simpson_NO_tilt
% ANSWER: 27.7120

%% Problem 3

% Fb|dnotilt ? dtilt| = micsgxics

%%%%%%%%%%%%%%%%%%%%%%%%% Trapezoid
% For Fb here, I will use my Trapezoid NO tilt value: 8.0918e+06
% dnotilt from Trapezoid = 27.9056
% dtilt from Trapezoid = 27.2646

xics = 1:25;
Fb = Buoyant_Force_trap_no_tilt;
dnotilt = center3;
dtilt = center1;
g = 9.81;

left_side = Fb*(abs(dnotilt-dtilt));
right_side = g*xics;

mics = left_side./right_side

plot(xics, mics)
hold on

%%%%%%%%%%%%%%%%%%%%%%%%% Simpsons
% For Fb here, I will use my Simpsons NO tilt value: 8.1004e+06
% dnotilt from Simpsons = 27.7120
% dtilt from Simpsons = 27.1123
% 8.1082e+06

xics = 1:25;
Fb = Buoyant_Force_simp_no_tilt;
dnotilt = center4;
dtilt = center2;
g = 9.81;

left_side_new = Fb*(abs(dnotilt-dtilt));
right_side_new = g*xics;

mics = left_side_new./right_side_new

p=plot(xics, mics)
title('Mass of Ice Coring Station')
xlabel('Horizontal Location (1 to 25m)') 
ylabel('Mass') 
legend({'Trapezoid','Simpsons'})
ax = gca;
ax.FontSize = 13;

%% Overall Conclusion:

% I believe simpsons provides the overall more accurate answer
% because the degree 1 interpolant in the trapezioid rule is replaced by a parabola with simpsons. 
% The Trapezoid Rule is simply the average of the left-hand Riemann Sum and the righthand Riemann Sum.
% Because Simpson?s rule uses parabolas, it is exact for any quadratic (or
% lower) polynomial.

% NOTE: In general we usually assume h is small but in this specific problem it's
% actually quite large which makes the error worse for Simpson's! But usually the rational in the 
% paragraph above is true.

% I think this gain in accuracy is definitely meaningful for placing an ice
% coring station on an iceberg because improvements in accuracy can have
% a much larger effect on a scale such as icebergs. 


%% FUNCTIONS

% Trapezoid Rule Function:
function integral = final_trap(f,a,b,n)
h = (b-a)/(n-1);
integral = 0;
s = 0;
for i = 2:n-1
    s = s + 2*f(i);
end
integral = (h/2)*(f(1) + s + f(end));

% Simspson's Rule Function:
function integral = simpsons(f,a,b,n)
if numel(f)>1 % numel = number of elements
    h=(b-a)/(n-1);
    integral = h/3*(f(1)+2*sum(f(3:2:end-2))+4*sum(f(2:2:end-1))+f(end));
end
end
end

% End of file


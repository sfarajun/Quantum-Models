%% Infinite Well

%% Simulation 1
%In this simulation I am simulating the energy levels of an electron in an infinite 
%potential energy well of length L that has infinitely high barriers.
%Note, the folowing equations are used:
%   En = ((n^2)*(hbar^2)*(pi^2))/(2*m*(L^2));

l1 = 1*10^-9;
l2 = 2*10^-9;

%calculate energy values
for i = 1:4
    En_l1(i) = energy_val(i,l1);
    En_l2(i) = energy_val(i,l2);
end

%print values
fprintf("\t L1=1nm\t\t L2=2nm\t\n");
for i = 1:4
    fprintf("n=%d\t %d \t %d\n", i, En_l1(i), En_l2(i));
end


%% Simulation 2
%In this simulation I am graphing the probability density for electrons in the 
%1st to 4th energy states for a well of Length L=2nm.
%Note, the folowing equations are used:
%   wave_func = (sqrt(2/L))*sin((n*pi*x)/L);
%   prob_density = wave_func.^2;

%the probability density of a wave function is the wave function squared
%create position points for probability density at those points
syms x
x = 0:1e-12:2e-9;
figure(150)
probdens1 = ProbDensity(1, x, 2e-9);
probdens2 = ProbDensity(2, x, 2e-9);
probdens3 = ProbDensity(3, x, 2e-9);
probdens4 = ProbDensity(4, x, 2e-9);
subplot(2,2,1)
plot(x,probdens1)
title('n=1: x vs prob-dens')
subplot(2,2,2)
plot(x,probdens2)
title('n=2: x vs prob-dens')
subplot(2,2,3)
plot(x,probdens3)
title('n=3: x vs prob-dens')
subplot(2,2,4)
plot(x,probdens4)
title('n=4: x vs prob-dens')



%% Simulation 3
%In this simulation I am calculate the probability of finding an electron between two
%points in the well L1 and L2, for an infinite well of length L.
%Note, the folowing equations are used:
%   wave_func = (sqrt(2/L))*sin((n*pi*x)/L);
%   prob_density = wave_func.^2;
%   prob = int(prob_density, x, L1, L2);

prob1 = Prob(1, 0, .2e-9);
prob2 = Prob(2, 0, .2e-9);
prob3 = Prob(1, .9e-9, 1.1e-9);
prob4 = Prob(2, .9e-9, 1.1e-9);

roundn = @(x,n) round(x.*10.^n)./10.^n;
prob1 = roundn(prob1, 5);
prob2 = roundn(prob2, 5);
prob3 = roundn(prob3, 5);
prob4 = roundn(prob4, 5);
fprintf("\nn=1, L1=0 (nm), L2=.2 (nm): prob = %.3f%%\n\n", prob1*100);
fprintf("n=2, L1=0 (nm), L2=.2 (nm): prob = %.3f%%\n\n", prob2*100);
fprintf("n=1, L1=.9 (nm), L2=1.1 (nm): prob = %.3f%%\n\n", prob3*100);
fprintf("n=2, L1=.9 (nm), L2=1.1 (nm): prob = %.3f%%\n\n", prob4*100);


syms d
prob4 = Prob(d, 0, .25*10^-9)

%% Simulation 4
%For this simulation I designed a quantum well that can be used as the photon 
%detector at the end of the fiber by calculating the length L of the quantum 
%well.
%Note, the folowing equations are used:
%   L = sqrt(((hbar^2)*(pi^2)*((n2^2)-(n1^2)))/(2*m*Ediff));

%photon energy (eV)
ph_e = 1.0*1.6e-19;

%expected length is L = 3e-9;
%return well length
L = well_length(1, 5, ph_e)

%I tested different transitions of energy levels, and found that for an
%energy level to be 1eV and the length of the infinite quantum well to be
%about 3nm, the electron transition caused by the absorption of the 
%photon's energy for is from energy level 1 to 5.






%% Functions
%Part 3
function [En] = energy_val(n, L)
    h = 6.62607004e-34; %Planck's Constant in Joule-sec
    hbar = h/(2*pi); %h-bar: Planck's Constant / 2pi
    m = 9.1094e-31; %Mass of a free electron

    %return radius
    En = ((n^2)*(hbar^2)*(pi^2))/(2*m*(L^2));
end
function [prob_density] = ProbDensity(n, x, L)
    wave_func = (sqrt(2/L))*sin((n*pi*x)/L);
    prob_density = wave_func.^2;
end
function prob = Prob(n, L1, L2)
    syms x;
    L = 2e-9;
    wave_func = (sqrt(2/L))*sin((n*pi*x)/L);
    prob_density = wave_func.^2;
    prob = int(prob_density, x, L1, L2);
end
function L = well_length(n1, n2, Ediff)
    h = 6.62607004e-34; %Planck's Constant in Joule-sec
    hbar = h/(2*pi); %h-bar: Planck's Constant / 2pi
    m = 9.1094e-31; %Mass of a free electron

    %return radius
    L = sqrt(((hbar^2)*(pi^2)*((n2^2)-(n1^2)))/(2*m*Ediff));
end
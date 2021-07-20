%% Radii
%% Question 1
%In this problem I am simulating the radii of atoms and ions when their
%electrons are at energy states 1-4. 
%For this problem, I used the equation r = (K*(n^2)*(hbar^2))/(atomic_number*(q^2)*m)

%H
for i = 1:4
    r_H(i) = radius(i,1);
end

%He+
for i = 1:4
    r_He(i) = radius(i,2);
end

%Li+2
for i = 1:4
    r_Li(i) = radius(i,3);
end

fprintf("\t H\t\t He+\t\t Li2+\n");
for i = 1:4
    fprintf("n=%d\t %d \t %d \t %d\n", i, r_H(i), r_He(i), r_Li(i));
end

%note this print for some reason is showing up at the end of the document


%% Functions for hw1
%Part 1
function [r] = radius(n, atomic_num)
    E0 = 8.85e-12; %permittivity of free space Farads/cm
    K = 4*pi*E0; %Converting to MKS
    q = 1.602e-19; %electronic charge in Coulombs
    h = 6.62607004e-34; %Planck's Constant in Joule-sec
    hbar = h/(2*pi); %h-bar: Planck's Constant / 2pi
    m = 9.1094e-31; %Mass of a free electron

    %return radius
    r = (K*(n^2)*(hbar^2))/(atomic_num*(q^2)*m);
end
%% Energy Diff and Wavelength Emitted
%In this problem I am simulating the energy difference between energy/orbital levels in
%hydrogen, and the wavelength of the light emitted when an electron
%transitions from a higher energy level to a lower one.
%For this problem, I used the folowing equations:
%   Energy_diff = ( ((q^4 * m)/(2* K^2 * hbar^2)) * ((1/(n1^2)) - (1/(n2^2))))/1.6e-19
%   lambda = ((2*pi*hbar*c)/(1.6e-19 * Ediff)) * 1e9
    
%compute Ediff and lambda for 10-9, 10-8, ...
for x = 9:-1:1
    [E_diff(x), lambda(x)] = energy_lambda(x,10);
    figure(100)
    bar(x,E_diff(x));
    hold on
    figure(200)
    bar(x,lambda(x));
    hold on
end

figure(100)
title("Energy of Electron Transition from n = 10 to n = x");
xlabel('Energy Level n') 
ylabel('Energy (eV)') 
hold off;
figure(200)
title("Wavelength Emitted of Electron Transition from n = 10 to n = x");
xlabel('n') 
ylabel('Lambda (nm)') 
hold off;
fprintf("UV light: <400nm \nVisible light: 400nm - 700n \nIR: >700nm\n")




function [Energy_diff, lambda] = energy_lambda(n1,n2)
    E0 = 8.85e-12; %permittivity of free space Farads/cm
    K = 4*pi*E0; %Converting to MKS
    q = 1.602e-19; %electronic charge in Coulombs
    h = 6.62607004e-34; %Planck's Constant in Joule-sec
    hbar = h/(2*pi); %h-bar: Planck's Constant / 2pi
    m = 9.1094e-31; %Mass of a free electron
    c = 3.0e8 ; %speed of light in meters/sec
    
    %return energy difference in eV
    Energy_diff = ( ((q^4 * m)/(2* K^2 * hbar^2)) * ((1/(n1^2)) - (1/(n2^2))))/1.6e-19;
    
    %return emitted wavelength
    lambda = ((2*pi*hbar*c)/(1.6e-19 * Energy_diff)) * 1e9;
end








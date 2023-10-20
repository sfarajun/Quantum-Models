%% Photoelectric effect

%% Simulation 1
%In this simulation I am simulating the energy of electrons that are emitted from 
%metal surfaces that are hit by light ranging from 3000nm (IR) to 100nm (UVC). 
%Note, the folowing equations are used:
%   freq(i) = c/(lambda(i));
%   Electron_energy(j, i) = (h*freq(i) - E0*(1.6e-19))/1.6e-19;

%E0 for metals (eV)
AlminE = 4.08;
AuminE = 5.1;
PtminE = 6.35;
NiminE = 5.01;
CuminE = 4.7;

%constants
c = 3.0e8 ; %speed of light in meters/sec
h = 6.63e-34;
list_of_elements = [AlminE AuminE PtminE NiminE CuminE];
list_of_element_names = ['Al';'Au';'Pt';'Ni';'Cu'];

%lambdas range from 100nm - 3000nm 
lambda = (100e-9:100e-9:3000e-9);

figure()
hold on
for j = 1:5
%     figure(j)
    E0 = list_of_elements(j);
    for i = 1:30
        freq(i) = c/(lambda(i));
        Electron_energy(j, i) = (h*freq(i) - E0*(1.6e-19))/1.6e-19;
    end
    plot(freq, Electron_energy(j, :))
%     title(["Energy of Emitted Electron " list_of_element_names(j, :) ""]);

    title(["Energy of Emitted Electron"])

    xlabel("Photon Frequency (Hz)");
    ylabel("Emitted Electron Energy (eV)");
end

hold off
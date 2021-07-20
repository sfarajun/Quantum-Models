%% Finite Well
%For this question I am using newtons method in order to find the kn
%value and the allowed energy values for a finite well of desired potential
%energy depth, length, and energy level

%range from x = 1e-9:1e-11:10e-9;
%depth from 1eV to 50eV
%tan(Kn*L/2) = sqrt((B/Kn)^2 - 1); n = 1,3,5,...
%-cot(Kn*L/2) = sqrt((B/Kn)^2 - 1); n = 2,4,6,...

% Assign V Physical Constants
Kb=1.38065e-23; %Boltzmann Constant in Joules/degree K
Epso = 8.85419e-14; %permittivity of free space Farads/cm
kk=4*pi*Epso*1e2; % Converting to MKS
q=1.602e-19; %electronic charge in Coulombs
h=6.62607004e-34; %Planck's Constant in Joule-sec
hbar=h/(2*pi); %h-bar: Planck's Constant / 2pi
mo=9.1094e-31; %Mass of a free electron
C=3.0e8 ; %speed of light in meters/sec


% Input Well Depth
fprintf('\n');
prompt = 'Enter Energy Well Depth (eV): ';
V_ev = input(prompt);
V = V_ev * q;
prompt = 'Enter Energy level value of potent Energy Level (n): ';
n = input(prompt);

%find out if energy_level = odd or even
my_num = (-1)^n;

%Length of well (change to input)
prompt = 'Enter Energy Well Length (m) (for example 2e-9): ';
L = input(prompt);


%infinite well allowed energy value
En_inf = hbar^2 * pi^2 * n^2 / (2*mo*(L^2));
En_inf_ev = En_inf/q;
kn_inf = ((2*mo*En_inf)^0.5) / hbar;


%finite well allowed energy values
knf = kn_inf * .9; %initial guess for kn_finite
j = 1; %initial iteration counter
Dknf = 1e9; %Initialize Dx
beta = ((2*mo*V)^0.5) / hbar;


%for even parity, n = odd
if my_num == -1
    while abs(Dknf) > 1e0
        fk = knf*tan(knf*L/2) - ((beta^2 - knf^2)^0.5);
        dfdk = tan(knf*L/2) + knf*(L/2)*(1/cos(knf*L/2))^2 + knf/((beta^2 - knf^2)^0.5);
        Dknf = -fk/dfdk;
        knf = knf + Dknf;
        j = j+1; %iteration counter
    end
    
%for odd parity, n = even
else
    while abs(Dknf) > 1e0
        fk = -knf*cot(knf*L/2) - ((beta^2 - knf^2)^0.5);
        dfdk = -cot(knf*L/2) + knf*(L/2)*(1/sin(knf*L/2))^2 + knf/((beta^2 - knf^2)^0.5);
        Dknf = -fk/dfdk;
        knf = knf + Dknf;
        j = j+1; %iteration counter
    end
end


Enf = (hbar^2 * knf^2) / (2*mo);
Enf_ev = Enf / q;

    
fprintf('\n')
fprintf('Iterations = %d\n\n', j);
fprintf('  Well    n-value   Energy(eV)   k-Value(1/m)    Length L(m)    Depth(eV)\n');
fprintf('-------------------------------------------------------------------------\n');
fprintf('Finite:      %d        %.3f       %1.3d       %.3d       %.1f\n', n, Enf_ev, knf, L, V_ev);
fprintf('Infinite:    %d        %.3f       %1.3d       %.3d       Inf\n', n, En_inf_ev, kn_inf, L);



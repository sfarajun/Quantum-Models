%% Part 4

%Part 1
fprintf('\n\nIntrinsic Carrier Concentration\n')
%Constants
K = 1.38e-23;
h = 6.626e-34;
q = 1.6e-19;
m0 = 9.11e-31;

%User inputs
T = input('Enter Temperature: ');
Eg = input('Enter bandgap: ');
mass_n_eff = input('Enter hole effective mass: ');
mass_p_eff = input('Enter electron effective mass: ');

% %for matlab pdf
% T = 300;
% Eg =1.1*q;
% mass_n_eff = .82*m0;
% mass_p_eff = 1.08*m0;

%Intrinsic Carrier Concentration
Nc = 2 * (((2*pi*mass_n_eff*K*T)/h^2)^(3/2));
Nv = 2 * (((2*pi*mass_p_eff*K*T)/h^2)^(3/2));
ni = sqrt(Nc*Nv)*exp(-Eg/(2*K*T));
%ni in cm^-3
ni_cm = ni / (100)^3




%Part 2 with Va
fprintf('\n\nBuilt in Potential of PN Junction and Depletion Region Length\n')
%Constants
VT = .026;
e0 = 8.854e-12; %in cm
q = 1.6e-19;
ND = input('Enter Donor concentration on N side:');
NA = input('Enter Acceptor concentration on P side:');
% %for pdf
% ND = 1e16;
% NA = 5e16;
ND = ND *(100^3);
NA = NA *(100^3);
er = input('Enter material relative permitivity (Epsilon):');
% %for pdf
% er = 11.7;
eps = e0*er;
Va = input('Enter Applied Bias (VA):');
% Va = 0.6;
Phi0 = VT * log((ND*NA)/ni^2)
xn = sqrt( ((2*(eps)*(Phi0-Va))/q) * (NA/(ND*(NA+ND))) )
xp = sqrt( ((2*(eps)*(Phi0-Va))/q) * (ND/(NA*(NA+ND))) )
Wd = xp + xn



%Part 3 with Va
%regions 1 and 4
syms t
E1 = 0;
E4 = 0;
Phi1 = VT*log(ND/ni);
Phi4 = -VT*log(NA/ni);
rho1 = 0;
rho4 = 0;
%regions 2 and 3
E2 = (q/eps)*ND*(t+xn);
E3 = (q/eps)*NA*(xp-t);
Phi2 = Phi1 - (q/(2*eps))*ND*(t+xn).^2;
Phi3 = Phi4 + (q/(2*eps))*NA*(xp-t).^2;
rho2 = ND;
rho3 = -NA;
%put functions together
syms E(t) rho(t) Phi(t)
E(t) = piecewise(-xn>t, E1, -xn<=t<=0, E2, 0<t<xp, E3, t>=xp ,E4);
Phi(t) = piecewise(-xn>t, Phi1, -xn<=t<=0, Phi2, 0<t<xp, Phi3, t>=xp ,Phi4);
rho(t) = piecewise(-xn>t, rho1, -xn<=t<=0, rho2, 0<t<xp, rho3, t>=xp ,rho4);

%Input choices
fprintf('\n\nGraphing the Internal Electric Field, Potential and Charge Concentration:');
fprintf('Choose what to graph:\n 1. Internal E field\n 2. Electrostatic potential\n 3. Charge Concentration\n');
fprintf(' 4. 1 and 2\n 5. 2 and 3\n 6. 1 and 3\n 7. 1, 2, and 3\n');
user = input('Enter selection:');
% %for pdf
% user = 7;
if (user == 1) || (user == 4) || (user == 6) || (user == 7)  
    %plot E's in V/cm
    figure()
    fplot(E,[-1e-6,1e-6])
    title('E vs x')
    xlabel('x(cm)')
    ylabel('E(V/cm)')
end
if (user == 2) || (user == 4) || (user == 5) || (user == 7)  
    %plot Phi's in V
    figure()
    fplot(Phi,[-1e-6,1e-6])
    title('Phi vs x')
    xlabel('x(cm)')
    ylabel('Phi(V)')
end
if (user == 3) || (user == 5) || (user == 6) || (user == 7)  
    %plot rho's in C^-1
    figure()
    fplot(rho,[-1e-6,1e-6])
    title('rho vs x')
    xlabel('x(cm)')
    ylabel('rho(C^-1)')
end



%% Part 5
fprintf('\n\nDiode Carrier Concentration and Current\n')
%constants
K = 1.38e-23;
h = 6.626e-34;
q = 1.6e-19;
m0 = 9.11e-31;
T = 300;

%in m
NA = 1e17*(100^3);
ND = 1e16*(100^3);

Va = input('Enter Applied Voltage:');
% %for pdf
% Va = .6;

Ln = 10e-6;
Lp = 10e-6;
Mu_n = 1000/(100^2);
Mu_p = 500/(100^2);
Dn = Mu_n*K*T/q
Dp = Mu_p*K*T/q


pn0 = (ni^2)/ND;
np0 = (ni^2)/NA;

x_1 = -.02e-2:1e-6:-xn;
x_2 = -xn:1e-4:xp;
x_3 = xp:1e-6:.02e-2;

%electron minority carrier concentration
np = np0*(exp(Va/VT) - 1)*exp((xp-x_3)./Ln) + np0;
figure()
plot(x_3, np)
title('electron minority carrier concentration')
xlabel('x(m)')
ylabel('e minority carrier concentration')

%hole minority carrier concentration
pn = pn0*(exp(Va/VT) - 1)*exp((xn+x_1)./Lp) + pn0;
figure()
plot(x_1, pn)
title('hole minority carrier concentration')
xlabel('x(m)')
ylabel('e minority carrier concentration')


%----------------------------------------
%regions
x1 = xp:1e-7:1e-4;
x_dep = -xn:1e-9:xp;
x2 = -1e-4:1e-7:-xn;

%electron minority and deplection current
Jnp = (-q*Dn*np0/Ln)*(exp(Va/VT) - 1)*exp((xp-x1)./Ln);
Jn_xp = (-q*Dn*np0/Ln)*(exp(Va/VT) - 1);

%hole minority and deplection current
Jpn = (-q*Dp*pn0/Lp)*(exp(Va/VT) - 1)*exp((xn+x2)./Lp);
Jp_neg_xn = (-q*Dp*pn0/Lp)*(exp(Va/VT) - 1);

%Total and majority currents
JTot = Jn_xp + Jp_neg_xn;
Jnn = JTot - Jpn;
Jpp = JTot - Jnp;

A = (100e-6)^2;

%electron current
figure()
plot(x1, abs(Jnp))
title('electron current vs xtest ')
xlabel('x(m)')
ylabel('electron current (A/m^2)')
hold on
plot(x_dep, abs(Jn_xp + (x_dep*0)))
plot(x2, abs(Jnn))
hold off

% %hole current 
figure(4)
plot(x2, abs(Jpn))
title('hole current vs x')
xlabel('x(m)')
ylabel('electron current (A/m^2)')
hold on
plot(x_dep, abs(Jp_neg_xn + (x_dep*0)))
plot(x1, abs(Jpp))
hold off



%current across diode
A = (100e-6)^2;
J0 = (q*Dp*(ni^2)/(ND*Lp)) + (q*Dn*(ni^2)/(NA*Ln));
I0 = A*J0;
ID = I0 * (exp(Va/VT) - 1)




%% Part 6
fprintf('\n\nDiode Current versus Voltage\n')

Va_min = input('Enter Applied Voltage Min:');
Va_max = input('Enter Applied Voltage Max:');
% %for pdf
% Va_min = .2;
% Va_max = .8;

Va = Va_min:.01:Va_max;


J0 = (q*Dp*(ni^2)/(ND*Lp)) + (q*Dn*(ni^2)/(NA*Ln));
I0 = A*J0;

ID = I0 * (exp(Va/VT) - 1);
figure()
plot(Va, ID)
title('ID vs VA')
xlabel('Applied Voltage (V)')
ylabel('electron current (A)')



%% Part 7
fprintf('\n\nNumerical Integration\n')
xl = input("Enter lower limit: ");
xu = input("Enter upper limit: ");
% %for pdf
% xl = -xn;
% xu = xp;


jmax = 100; %number of iterations
dx = (xu - xl)/jmax;
int = 0;
x = [];
x(1) = xl;
for i = 1:jmax
   x(i+1) = x(i) + dx; 
end


for i = 1:jmax
   fx1 = E([x(i)]);
   fx2 = E([x(i+1)]);
   favg = (fx1+fx2)/2;
   int = int + favg;
end
int = int*dx;
double(int)
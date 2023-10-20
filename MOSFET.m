%% Part 1
%MOSFET

%This code simulates a MOSFET

%ask for inputs
NA = input('Enter Substrate Doping: ');
L = input('Enter Gate Length: ');
if ((L<.8e-4) || (L>100e-4))
    disp 'Error: Length Must Be Between .8e-4 and 100e-4 cm';   
   return
end
W = input('Enter Gate Width: ');
if ((W<2e-4) || (W>100e-4))
    disp 'Error: Length Must Be Between .8e-4 and 100e-4 cm';   
   return
end
VD = input('Enter VD: ');
VG = input('Enter VG: ');
VS = input('Enter VS: ');
if ((VD>10) || (VG>10) || (VS>10))
    disp 'Error: All Voltages Must Be Below 10V';   
   return
end


VGS = VG-VS;
VDS = VD-VS;

%constants
e0 = 8.854e-14;
esi = 11.7*e0;
eox = 3.9*e0;
Vt = .026;
ni = 1e10;
q = 1.6e-19;

%given
Un = 500; %cm^2/Vs
lambda = .02;
tox = 20e-7;
VB = VS; %figure out if this matters
ND_poly = 1e19;
Ld = .1e-4;

%calculate Vth
Cox = eox/tox; % F/cm^2
Phi_n_poly = Vt*log(ND_poly/ni);
Phi_p = -Vt*log(NA/ni);
Phi0 = Phi_n_poly - Phi_p;
Vth = ((1/Cox) * sqrt(4*q*esi*NA*abs(Phi_p))) + 2*abs(Phi_p) - Phi0


%calculate ID
if (VGS - Vth) >= VDS
    %for linear
    disp 'In Linear Region';   
    ID = (Un*Cox*W/L) * ((VGS - Vth)*VDS - (VDS^2)/2) 
else
    %for saturation
    disp 'In Saturation Region';   
    ID = (Un*Cox*W/(2*L)) * ((VGS - Vth)^2) * (1 + lambda*VDS)
end





%% Part 2
%ask for inputs
disp 'Enter Values So That Device is in Saturation';
VD = input('Enter VD: ');
VG = input('Enter VG: ');
VS = input('Enter VS: ');

VGS = VG-VS;
VDS = VD-VS;

if (VGS - Vth) > VDS
    disp 'Error: Not in Saturation Region';
else
    ID = (Un*Cox*W/(2*L)) * ((VGS - Vth)^2) * (1 + lambda*VDS)
    %calulated values
    gm = sqrt(2*Un*Cox*W*ID/L)
    r0 = 1/(lambda*ID)
    Cgs = (2/3)*Cox*L*W
    Cgd = Cox*Ld*W
end
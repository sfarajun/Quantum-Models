% ENEE 313
% Sahar Farajun
%Matlab code for ENEE 313 Quantum and Device Physics Simulator


fprintf('\n')
fprintf('ENEE 313 Quantum and Device Physics Simulator \n')

fprintf('\n')
fprintf('Contents: \n')
fprintf('1: Newton Method for radii of atoms in nth quantum level \n')
fprintf('2: Energy dif between levels in Hydrogen and emitted photons wavelengths\n')
fprintf('3: Photoelectric Effect \n')
fprintf('4: Infinite Quantum Well Simulation (Energy Levels, Probability, and Probability Density) \n')
fprintf('5: Probability Density and Wave Functions in 2D/3D\n')
fprintf('6: Finite Quantum Well (Energy and k values) \n')
fprintf('7: PN Junction (ni, E0, Phi0, Carrier Concentration, Carrier Currents, ID, and Numerical Integration\n')
fprintf('8: MOSFET (Drain Current and Small Signal Model\n')

menuselect = '';

while true
    switch menuselect
      case '1' % Newton Method for Parabola Roots
          fprintf('\n')    
          atom_radii_313
      case '2' % Ediff and wavelengths
          fprintf('\n')
          Ediff_lambda_313
      case '3' % Photoelectric Effect
          fprintf('\n')
          photoelectric_313
      case '4' % Infinite Quantum Well
          fprintf('\n')
          infinite_well_313
      case '5' % Probability Density and Wave Functions in 2D/3D
          fprintf('\n')
          Probability_Density_313
      case '6' % Finite Quantum Well
          fprintf('\n')
          finite_well_313
      case '7' % PN Junction
          fprintf('\n')
          pn_junction
      case '8' % MOSFET
          fprintf('\n')
          MOSFET            

      otherwise
        fprintf('\n')
            menuselect = input(' Choose program number you would like to run: ', 's');
            continue
    end
    break
end
%% Part 1
%% Simulation 1

%In this simulation I am plotting the Probability density for hydrogen and
%helium of given energy values n

%choose x and stepsize 
r = 0:1e-12:5e-10;
s_1 = orbital(1, 1, r);
title("Hydrogen S Orbit vs Dist From Nucleus, n = 1");
xlabel("r (m)");
ylabel("S Orbit");
figure()
s_2 = orbital(1,2,r);
title("Helium S Orbit vs Dist From Nucleus, n = 1");
xlabel("r (m)");
ylabel("S Orbit");
figure()
s_3 = orbital(2,1,r);
title("Hydrogen S Orbit vs Dist From Nucleus, n = 2");
xlabel("r (m)");
ylabel("S Orbit");
figure()
s_4 = orbital(2,2,r);
title("Helium S Orbit vs Dist From Nucleus, n = 2");
xlabel("r (m)");
ylabel("S Orbit");

% These radii fall in line with the Bohr model's calculations, however,
% these are more accurate and show that the radii is not a set value but a
% probable value and shows the possible positions to find the electrons and
% the likelihoods of finding them in those positions. 



%% Simulation 2
%In this question I am creating 2D and 3D plots for the first 4 hydrogen
%wavefunctions

[X,Y] = meshgrid(-6e-10:1e-11:6e-10);
R = sqrt(X.^2 + Y.^2);
Theta = atan(Y ./ X);
Phi = atan(R);

%orbital2(Z, r, n, l, m, Phi, Theta)

% Theta = atan(X.^2 + Y.^2);
s_1 = orbital2(1, R, 1, 0, 0, Phi, Theta);
s_2 = orbital2(1, R, 2, 0, 0, Phi, Theta);
s_3 = orbital2(1, R, 2, 1, 0, Phi, Theta);
s_4 = orbital2(1, R, 2, 1, 1, Phi, Theta);
s_5 = orbital2(1, R, 2, 1, -1, Phi, Theta);





%% functions
function [wave_func] = orbital(n, Z, r)
    %Bohr Radius
    a0 = .53e-10;
    
    %first orbital
    if n == 1
      wave_func = (1/sqrt(pi)) * (Z/a0)^(3/2) * exp(-Z*r/a0); 
      
    %second orbital
    elseif n == 2
       wave_func = (1/(4*sqrt(pi)) * (Z/a0)^(3/2) .* (2-(Z*r/a0)) .* exp(-Z*r/(2*a0)));
            
    end
    
    s_orbit = (4*pi*r.^2) .* wave_func.^2;
    plot(r, s_orbit);
end

function [wave_func] = orbital2(Z, r, n, l, m, Phi, Theta)
    %Bohr Radius
    a0 = .53e-10;
    
    
    %first orbital
    if n == 1
      wave_func = (1/sqrt(pi)) * (Z/a0)^(3/2) * exp(-Z*r/a0); 
      
    %second orbital
    elseif n == 2
        if l == 0
            wave_func = (1/(4*sqrt(pi)) * (Z/a0)^(3/2) .* (2-(Z*r/a0)) .* exp(-Z*r/(2*a0)));
        elseif l == 1
            if m == 0
                wave_func = (1/(4*sqrt(pi)) * (Z/a0)^(3/2) .* ((Z*r/a0)) .* exp(-Z*r/(2*a0))).*cos(Theta);
            elseif m == 1
                wave_func = (1/(4*sqrt(pi)) * (Z/a0)^(3/2) .* ((Z*r/a0)) .* exp(-Z*r/(2*a0))).*sin(Theta);
            elseif m == -1
                wave_func = (1/(4*sqrt(pi)) * (Z/a0)^(3/2) .* ((Z*r/a0)) .* exp(-Z*r/(2*a0))).*sin(Theta);
            end
        end
    end
    
    s_orbit = (4*pi*r.^2) .* wave_func.^2;

    %3D plot
    figure()
    subplot(2,1,1)
    surf(s_orbit);
    title(['n = ', num2str(n),', l = ',num2str(l),', m = ',num2str(m)])
    
    %2D plot
    subplot(2,1,2)
    surf(s_orbit);
    view(0,90)
    title(['n = ', num2str(n),', l = ',num2str(l),', m = ',num2str(m)])
end



%% radius_ion.m
% * For more detailed info, see the Revised Shannon radii...
%
%% Version
% 2.07
%
%% Contact
% Please report bugs to michael.holmboe@umu.se
%
%% Examples
% # radii = radius_ion({'O'})
% # radii = radius_ion('O')

function radii = radius_ion(Atom_label)

if ~iscell(Atom_label)
    Atom_label={Atom_label};
end

Radiiproperties=load('Revised_Shannon_radii.mat');
radii=zeros(length(Atom_label),1);
for i=1:length(Atom_label)
    try
        ind=find(strncmpi([Radiiproperties.Ion],Atom_label(i),2));
    catch
        try
        ind=find(strncmpi([Radiiproperties.Ion],Atom_label(i),1));
        catch
           ind=285;% As in O 
        end
    end
%     radii(i)=median(Radiiproperties.IonicRadii(ind))';
    radii(i,1)=Radiiproperties.IonicRadii(ind(1));
end

%% Older version of this function...
% This function fetches approx. ionic radii, originally taken from
% http://environmentalchemistry.com/yogi/periodic/ionicradius.html
% The radius for H is made up...
% ionic_radii={...
%     'H' -0.400 1 'Hydrogen'; ...
%     'He' 0.500 2 'Helium'; ...
%     'Li' 0.760 3 'Lithium'; ...
%     'Be' 0.350 4 'Beryllium'; ...
%     'B'  0.230 5 'Boron'; ...
%     'C'  0.100 6 'Carbon'; ...
%     'N'  0.130 7 'Nitrogen'; ...
%     'O'  1.400 8 'Oxygen'; ...
%     'F'  1.330 9 'Fluorine'; ...
%     'Ne' 1.500 10 'Neon'; ...
%     'Na' 1.020 11 'Sodium'; ...
%     'Mg' 0.720 12 'Magnesium'; ...
%     'Al' 0.535 13 'Aluminum'; ...
%     'Si' 0.400 14 'Silicon'; ...
%     'P'  0.380 15 'Phosphorus'; ...
%     'S'  0.370 16 'Sulfur'; ...
%     'Cl' 1.810 17 'Chlorine'; ...
%     'Ar' 1.900 18 'Argon'; ...
%     'K'  1.380 19 'Potassium'; ...
%     'Ca' 0.990 20 'Calcium'; ...
%     'Sc' 0.745 21 'Scandium'; ...
%     'Ti' 0.605 22 'Titanium'; ...
%     'V'  0.590 23 'Vanadium'; ...
%     'Cr' 0.520 24 'Chromium'; ...
%     'Mn' 0.460 25 'Manganese'; ...
%     'Fe' 0.645 26 'Iron'; ...
%     'Co' 0.745 27 'Cobalt'; ...
%     'Ni' 0.690 28 'Nickel'; ...
%     'Cu' 0.730 29 'Copper'; ...
%     'Zn' 0.740 30 'Zinc'; ...
%     'Ga' 0.620 31 'Gallium'; ...
%     'Ge' 0.530 32 'Germanium'; ...
%     'As' 0.580 33 'Arsenic'; ...
%     'Se' 0.500 34 'Selenium'; ...
%     'Br' 1.960 35 'Bromine'; ...
%     'Kr' 2.300 36 'Krypton'; ...
%     'Rb' 1.520 37 'Rubidium'; ...
%     'Sr' 1.120 38 'Strontium'; ...
%     'Y'  0.900 39 'Yttrium'; ...
%     'Zr' 0.720 40 'Zirconium'; ...
%     'Nb' 0.690 41 'Niobium'; ...
%     'Mo' 0.650 42 'Molybdenum'; ...
%     'Tc' 0.560 43 'Technetium'; ...
%     'Ru' 0.680 44 'Ruthenium'; ...
%     'Rh' 0.680 45 'Rhodium'; ...
%     'Pd' 0.860 46 'Palladium'; ...
%     'Ag' 1.260 47 'Silver'; ...
%     'Cd' 0.970 48 'Cadmium'; ...
%     'In' 0.800 49 'Indium'; ...
%     'Sn' 0.690 50 'Tin'; ...
%     'Sb' 0.760 51 'Antimony'; ...
%     'Te' 0.970 52 'Tellurium'; ...
%     'I'  2.200 53 'Iodine'; ...
%     'Xe' 2.500 54 'Xenon'; ...
%     'Cs' 1.670 55 'Cesium'; ...
%     'Ba' 1.350 56 'Barium'; ...
%     'La' 1.061 57 'Lanthanum'; ...
%     'Ce' 1.034 58 'Cerium'; ...
%     'Pr' 1.013 59 'Praseodymium'; ...
%     'Nd' 0.995 60 'Neodymium'; ...
%     'Pm' 0.979 61 'Promethium'; ...
%     'Sm' 0.964 62 'Samarium'; ...
%     'Eu' 0.947 63 'Europium'; ...
%     'Gd' 0.938 64 'Gadolinium'; ...
%     'Tb' 0.923 65 'Terbium'; ...
%     'Dy' 0.912 66 'Dysprosium'; ...
%     'Ho' 0.901 67 'Holmium'; ...
%     'Er' 0.881 68 'Erbium'; ...
%     'Tm' 0.869 69 'Thulium'; ...
%     'Yb' 0.858 70 'Ytterbium'; ...
%     'Lu' 0.848 71 'Lutetium'; ...
%     'Hf' 0.710 72 'Hafnium'; ...
%     'Ta' 0.640 73 'Tantalum'; ...
%     'W'  0.620 74 'Tungsten'; ...
%     'Re' 0.560 75 'Rhenium'; ...
%     'Os' 0.630 76 'Osmium'; ...
%     'Ir' 0.625 77 'Iridium'; ...
%     'Pt' 0.625 78 'Platinum'; ...
%     'Au' 0.850 79 'Gold'; ...
%     'Hg' 1.020 80 'Mercury'; ...
%     'Tl' 1.500 81 'Thallium'; ...
%     'Pb' 1.190 82 'Lead'; ...
%     'Bi' 1.030 83 'Bismuth'; ...
%     'Po' 2.300 84 'Polonium'; ...
%     'At' 2.500 85 'Astatine'; ...
%     'Rn' 2.700 86 'Radon'; ...
%     'Fr' 1.800 87 'Francium'; ...
%     'Ra' 1.430 88 'Radium'; ...
%     'Ac' 1.119 89 'Actinium'; ...
%     'Th' 0.972 90 'Thorium'; ...
%     'Pa' 0.780 91 'Protactinium'; ...
%     'U'  0.520 92 'Uranium'; ...
%     'Np' 0.750 93 'Neptunium'; ...
%     'Pu' 0.887 94 'Plutonium'; ...
%     'Am' 0.982 95 'Americium'; ...
%     'Cm' 0.970 96 'Curium'; ...
%     'Bk' 0.949 97 'Berkelium'; ...
%     'Cf' 0.934 98 'Californium'; ...
%     'Es' 0.925 99 'Einsteinium'; ...
%     'Hw' -0.400 1 'Hydrogen'; ...
%     'HW1' -0.400 1 'Hydrogen'; ...
%     'HW2' -0.400 1 'Hydrogen'; ...
%     'OW'  1.400 8 'Oxygen'};
%
% ind=[];ind_array=[];
% if iscell(Atom_label) && length(Atom_label) > 1
%     for i=1:length(Atom_label)
%         ind=find(strncmpi(Atom_label(i),ionic_radii(:,1),2));
%         if numel(ind) == 0
%             ind=find(strncmpi(Atom_label(i),ionic_radii(:,1),1));
%             if numel(ind) == 0
%                 disp('Could not find radii for')
%                 disp(Atom_label(i))
%                 disp('setting it to 1.4�')
%                 ind = 8;
%             end
%         end
%         ind_array=[ind_array ind(1)];
%     end
%     ind=ind_array;
% else
%     ind=find(strcmpi(Atom_label,ionic_radii(:,1)));
%     if numel(ind) == 0
%         ind = 8;
%     end
% % end
%
% radii = cell2mat(ionic_radii(ind,2));


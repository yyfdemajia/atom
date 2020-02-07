%% atomic_scattering_factors
% This function retrieves the atomic scattering factor vs 2theta using the 
% 11-coeff parameters from Waasmaier&Kirfel, 1995
% One can use the if statements to control the ionic form of the fetched
% scattering factors...
%
%% Version
% 2.07
%
%% Contact
% Please report bugs to michael.holmboe@umu.se
%
%% Examples
% # f = atomic_scattering_factors('Si',1.54187,2:.033:60,2)
%
function f = atomic_scattering_factors(Atom_label,lambda,twotheta,Biso)

if size(Atom_label{1},2)>1
    Atom_label{1}(2:end)=lower(Atom_label{1}(2:end));
end

if ismember(Atom_label,['Li','Na','K','Cs'])
    Atom_label=strcat(Atom_label,'1+');
elseif ismember(Atom_label,['Mg','Ca','Sr','Ba','Cu'])
    Atom_label=strcat(Atom_label,'2+');
end

if strncmp(Atom_label,{'Nc'},1)
    if strncmpi(Atom_label,{'Nc'},2)
        %disp('Treating Nc as N')
        Atom_label={'N'};
    elseif strncmpi(Atom_label,{'Na'},2)
        %disp('Treating Nc as N')
        Atom_label={'Na1+'};
    end
end

if strcmp(Atom_label,{'Al'})
    %disp('Treating Al as Al1.5+')
    Atom_label={'Al1.5+'};
end
if strcmp(Atom_label,{'Al0'})
    %disp('Treating Al as Al1.5+')
    Atom_label={'Al'};
end
if strcmp(Atom_label,{'Alt'})
    %disp('Treating Al as Al1.5+')
    Atom_label={'Al1.5+'};
end
if strcmp(Atom_label,{'Si'})
    %disp('Treating Si as Si2+')
    Atom_label={'Si2+'};
end
if strcmp(Atom_label,{'Si0'})
    %disp('Treating Al as Al1.5+')
    Atom_label={'Si'};
end
if strcmp(Atom_label,{'Mgo'})
    %disp('Treating Mgo as Mg1+')
    Atom_label={'Mg1+'};
end
if strcmp(Atom_label,{'Mg0'})
    %disp('Treating Mgo as Mg1+')
    Atom_label={'Mg'};
end
if strcmp(Atom_label,{'Feo'})
    %disp('Treating Feo as Fe1.5+')
    Atom_label={'Fe1.5+'};
end
if strcmp(Atom_label,{'Fe0'})
    %disp('Treating Feo as Fe1.5+')
    Atom_label={'Fe'};
end


if strncmp(Atom_label,{'Oh'},2)
    %disp('Treating Oh as O1-')
    Atom_label={'O1-'};
elseif strcmp(Atom_label,{'Oapical'})
    %disp('Treating Oapical as O1-')
    Atom_label={'O1-'};
elseif strcmp(Atom_label,{'Obasal'}) %|| strcmp(Atom_label,{'O'})
    %disp('Treating Obasal as O1-')
    Atom_label={'O1-'};
elseif strcmp(Atom_label,{'Omg'}) || strncmp(Atom_label,{'Oa'},2) || strncmp(Atom_label,{'Od'},2) || strncmp(Atom_label,{'Os'},2)...
        || strncmp(Atom_label,{'Ob'},2) || strncmp(Atom_label,{'Op'},2)
    %disp('Treating Obasal as O1-')
    Atom_label={'O1-'};
elseif strcmp(Atom_label,{'OEF'})
    %disp('Treating OEdelamn/Favejee as O1-')
    Atom_label={'O1-'};
elseif strncmpi(Atom_label,{'Ow'},2)
    %disp('Treating Owx as uncharged O')
    Atom_label={'O'};
elseif strncmpi(Atom_label,{'Oc'},2)
    %disp('Treating Owx as uncharged O')
    Atom_label={'O'};
elseif strncmpi(Atom_label,{'O0'},2)
    %disp('Treating Owx as uncharged O')
    Atom_label={'O'};
elseif strncmpi(Atom_label,{'O'},1)
    %disp('Treating Owx as uncharged O')
    Atom_label={'O1-'};
end

if strncmpi(Atom_label,{'H'},1)
    if strncmpi(Atom_label,{'HEF'},2)
        %disp('Treating HEdelamn/Favejee as uncharged H')
        Atom_label={'H'};
    elseif strncmpi(Atom_label,{'Hw'},2)
        %disp('Treating HEdelamn/Favejee as uncharged H')
        Atom_label={'H'};
    elseif strncmpi(Atom_label,{'Hc'},2)
        %disp('Treating Hc as a neutral H')
        Atom_label={'H'};
    elseif strncmp(Atom_label,{'Hx'},1) && size(Atom_label,2) > 1
        if isnumeric(Atom_label(2))
            %disp('Treating Hx as uncharged H')
            Atom_label={'H'};
        elseif strncmpi(Atom_label,{'Hw'},2)
            Atom_label={'H'};
        end
    end
end

if strncmp(Atom_label,{'C'},1)
    if strncmpi(Atom_label,{'Cl'},2)
        %disp('Treating Cl as Cl1-')
        Atom_label={'Cl1-'};
    elseif strncmpi(Atom_label,{'Cs'},2)
        %disp('Treating Cl as Cl1-')
        Atom_label={'Cs1+'};
    elseif strncmpi(Atom_label,{'Ca'},2)
        %disp('Treating Cl as Cl1-')
        Atom_label={'Ca2+'};
    elseif strncmpi(Atom_label,{'Cc'},2)
        %disp('Treating Cc as C')
        Atom_label={'C'};
    else
        %disp('Treating Cx as uncharged C')
        Atom_label={'C'};
    end
end

if strncmp(Atom_label,{'H2O'},3)
    %disp('Treating H2O as a single particle H2O')
    Atom_label={'H2O'};
end

if strncmpi(Atom_label,{'Br'},2)
    %disp('Treating Nc as N')
    Atom_label={'Br1-'};
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Atom name
Waasmaier_Kirfel_label={...
    'H';...
    'H1-';...
    'He';...
    'Li';...
    'Li1+';...
    'Be';...
    'Be2+';...
    'B';...
    'C';...
    'Cval';...
    'N';...
    'O';...
    'O1-';...
    'O2-';...
    'OH1-';...
    'F';...
    'F1-';...
    'H2O';...
    'Ne';...
    'Na';...
    'Na1+';...
    'Mg';...
    'Mg1+';...
    'Mg2+';...
    'Al';...
    'Al1.5+';...
    'Al3+';...
    'Si';...
    'Siva';...
    'Si2+';...
    'Si4+';...
    'P';...
    'S';...
    'Cl';...
    'Cl1-';...
    'Ar';...
    'K';...
    'K1+';...
    'Ca';...
    'Ca2+';...
    'Sc';...
    'Sc3+';...
    'Ti';...
    'Ti2+';...
    'Ti3+';...
    'Ti4+';...
    'V';...
    'V2+';...
    'V3+';...
    'V5+';...
    'Cr';...
    'Cr2+';...
    'Cr3+';...
    'Mn';...
    'Mn2+';...
    'Mn3+';...
    'Mn4+';...
    'Fe';...
    'Fe1.5+';...
    'Fe2+';...
    'Fe3+';...
    'Co';...
    'Co2+';...
    'Co3+';...
    'Ni';...
    'Ni2+';...
    'Ni3+';...
    'Cu';...
    'Cu1+';...
    'Cu2+';...
    'Zn';...
    'Zn2+';...
    'Ga';...
    'Ga3+';...
    'Ge';...
    'Ge4+';...
    'As';...
    'Glycol';...
    'Se';...
    'Br';...
    'Br1-';...
    'Kr';...
    'Rb';...
    'Rb1+';...
    'Sr';...
    'Sr2+';...
    'Y';...
    'Zr';...
    'Zr4+';...
    'Nb';...
    'Nb3+';...
    'Nb5+';...
    'Mo';...
    'Mo3+';...
    'Mo5+';...
    'Mo6+';...
    'Tc';...
    'Ru';...
    'Ru3+';...
    'Ru4+';...
    'Rh';...
    'Rh3+';...
    'Rh4+';...
    'Pd';...
    'Pd2+';...
    'Pd4+';...
    'Ag';...
    'Ag1+';...
    'Ag2+';...
    'Cd';...
    'Cd2+';...
    'In';...
    'In3+';...
    'Sn';...
    'Sn2+';...
    'Sn4+';...
    'Sb';...
    'Sb3+';...
    'Sb5+';...
    'Te';...
    'I';...
    'I1-';...
    'Xe';...
    'Cs';...
    'Cs1+';...
    'Ba';...
    'Ba2+';...
    'La';...
    'La3+';...
    'Ce';...
    'Ce3+';...
    'Ce4+';...
    'Pr';...
    'Pr3+';...
    'Pr4+';...
    'Nd';...
    'Nd3+';...
    'Pm';...
    'Pm3+';...
    'Sm';...
    'Sm3+';...
    'Eu';...
    'Eu2+';...
    'Eu3+';...
    'Gd';...
    'Gd3+';...
    'Tb';...
    'Tb3+';...
    'Dy';...
    'Dy3+';...
    'Ho';...
    'Ho3+';...
    'Er';...
    'Er3+';...
    'Tm';...
    'Tm3+';...
    'Yb';...
    'Yb2+';...
    'Yb3+';...
    'Lu';...
    'Lu3+';...
    'Hf';...
    'Hf4+';...
    'Ta';...
    'Ta5+';...
    'W';...
    'W6+';...
    'Re';...
    'Os';...
    'Os4+';...
    'Ir';...
    'Ir3+';...
    'Ir4+';...
    'Pt';...
    'Pt2+';...
    'Pt4+';...
    'Au';...
    'Au1+';...
    'Au3+';...
    'Hg';...
    'Hg1+';...
    'Hg2+';...
    'Tl';...
    'Tl1+';...
    'Tl3+';...
    'Pb';...
    'Pb2+';...
    'Pb4+';...
    'Bi';...
    'Bi3+';...
    'Bi5+';...
    'Po';...
    'At';...
    'Rn';...
    'Fr';...
    'Ra';...
    'Ra2+';...
    'Ac';...
    'Ac3+';...
    'Th';...
    'Th4+';...
    'Pa';...
    'U';...
    'U3+';...
    'U4+';...
    'U6+';...
    'Np';...
    'Np3+';...
    'Np4+';...
    'Np6+';...
    'Pu';...
    'Pu3+';...
    'Pu4+';...
    'Pu6+';...
    'Am';...
    'Cm';...
    'Bk';...
    'Cf';...
    };

% atom_nr,charge,weight,debye-waller factor
Waasmaier_Kirfel_data=[...
    1 0 1.00794 0;...
    1 -1 1.00794 2;...
    2 0 4.002602 0;...
    3 0 6.94100 0;...
    3 1 6.94100 1.5;...
    4 0 9.012182 0;...
    4 2 9.012182 1.5;...
    5 0 10.8110 0;...
    6 0 12.0107 0;...
    6 2 12.0107 0;...
    7 0 14.0067 0;...
    8 0 15.9994 0;...
    8 -1 15.9994 2;...
    8 -2 15.9994 2;...
    9 -1 17.00734 2;...
    9 0 18.9984032 0;...
    9 -1 18.9984032 2;...
    10 0 18.01528 2;...
    10 0 20.1797 0;...
    11 0 22.98976928 0;...
    11 1 22.98976928 1.5;...
    12 0 24.3050 0;...
    12 1 24.3050 1.5;...
    12 2 24.3050 1.5;...
    13 0 26.9815386 0;...
    13 1.50000 26.9815386 1.5;...
    13 3 26.9815386 1.5;...
    14 0 28.0855 0;...
    14 2 28.0855 0;...
    14 2 28.0855 1.5;...
    14 4 28.0855 1.5;...
    15 0 30.973762 0;...
    16 0 32.0650 0;...
    17 0 35.4530 0;...
    17 -1 35.4530 2;...
    18 0 39.9480 0;...
    19 0 39.0983 0;...
    19 1 39.0983 2;...
    20 0 40.0780 0;...
    20 2 40.0780 2;...
    21 0 44.955912 0;...
    21 3 44.955912 2;...
    22 0 47.8670 0;...
    22 2 47.8670 1.5;...
    22 3 47.8670 1.5;...
    22 4 47.8670 1.5;...
    23 0 50.9415 0;...
    23 2 50.9415 1.5;...
    23 3 50.9415 1.5;...
    23 5 50.9415 1.5;...
    24 0 51.9961 0;...
    24 2 51.9961 1.5;...
    24 3 51.9961 1.5;...
    25 0 54.938045 0;...
    25 2 54.938045 1.5;...
    25 3 54.938045 1.5;...
    25 4 54.938045 1.5;...
    26 0 55.8450 0;...
    26 1.50000 55.8450 1.5;...
    26 2 55.8450 1.5;...
    26 3 55.8450 1.5;...
    27 0 58.933195 0;...
    27 2 58.933195 1.5;...
    27 3 58.933195 1.5;...
    28 0 58.6934 0;...
    28 2 58.6934 1.5;...
    28 3 58.6934 1.5;...
    29 0 63.5460 0;...
    29 1 63.5460 1.5;...
    29 2 63.5460 1.5;...
    30 0 65.3800 0;...
    30 2 65.3800 1.5;...
    31 0 69.7230 0;...
    31 3 69.7230 1.5;...
    32 0 72.6400 0;...
    32 4 72.6400 1.5;...
    33 0 74.9216 0;...
    34 0 31.0350 11;...
    34 0 78.9600 0;...
    35 0 79.9040 0;...
    35 -1 79.9040 2;...
    36 0 83.7980 0;...
    37 0 85.4678 0;...
    37 1 85.4678 1.5;...
    38 0 87.6200 0;...
    38 2 87.6200 1.5;...
    39 0 88.90585 0;...
    40 0 91.2240 0;...
    40 4 91.2240 1.5;...
    41 0 92.90638 0;...
    41 3 92.90638 1.5;...
    41 5 92.90638 1.5;...
    42 0 95.9600 0;...
    42 3 95.9600 1.5;...
    42 5 95.9600 1.5;...
    42 6 95.9600 1.5;...
    43 0 95.9600 0;...
    44 0 101.070 0;...
    44 3 101.070 1.5;...
    44 4 101.070 1.5;...
    45 0 102.9055 0;...
    45 3 102.9055 1.5;...
    45 4 102.9055 1.5;...
    46 0 106.420 0;...
    46 2 106.420 1.5;...
    46 4 106.420 1.5;...
    47 0 107.8682 0;...
    47 1 107.8682 1.5;...
    47 2 107.8682 1.5;...
    48 0 112.411 0;...
    48 2 112.411 1.5;...
    49 0 114.818 0;...
    49 3 114.818 1.5;...
    50 0 118.710 0;...
    50 2 118.710 1.5;...
    50 4 118.710 1.5;...
    51 0 121.760 0;...
    51 3 121.760 1.5;...
    51 5 121.760 1.5;...
    52 0 127.600 0;...
    53 0 126.90447 0;...
    53 -1 126.90447 2;...
    54 0 131.293 0;...
    55 0 132.9054519 0;...
    55 1 132.9054519 1.5;...
    56 0 137.327 0;...
    56 2 137.327 1.5;...
    57 0 138.90547 0;...
    57 3 138.90547 1.5;...
    58 0 140.116 0;...
    58 3 140.116 1.5;...
    58 4 140.116 1.5;...
    59 0 140.90765 0;...
    59 3 140.90765 1.5;...
    59 4 140.90765 1.5;...
    60 0 144.242 0;...
    60 3 144.242 1.5;...
    61 0 144.242 0;...
    61 3 144.242 1.5;...
    62 0 150.360 0;...
    62 3 150.360 1.5;...
    63 0 151.964 0;...
    63 2 151.964 1.5;...
    63 3 151.964 1.5;...
    64 0 157.250 0;...
    64 3 157.250 1.5;...
    65 0 158.92535 0;...
    65 3 158.92535 1.5;...
    66 0 162.500 0;...
    66 3 162.500 1.5;...
    67 0 164.93032 0;...
    67 3 164.93032 1.5;...
    68 0 167.259 0;...
    68 3 167.259 1.5;...
    69 0 168.93421 0;...
    69 3 168.93421 1.5;...
    70 0 173.054 0;...
    70 2 173.054 1.5;...
    70 3 173.054 1.5;...
    71 0 174.9668 0;...
    71 3 174.9668 1.5;...
    72 0 178.490 0;...
    72 4 178.490 1.5;...
    73 0 180.94788 0;...
    73 5 180.94788 1.5;...
    74 0 183.840 0;...
    74 6 183.840 1.5;...
    75 0 186.207 0;...
    76 0 190.230 0;...
    76 4 190.230 1.5;...
    77 0 192.217 0;...
    77 3 192.217 1.5;...
    77 4 192.217 1.5;...
    78 0 195.084 0;...
    78 2 195.084 1.5;...
    78 4 195.084 1.5;...
    79 0 196.966569 0;...
    79 1 196.966569 1.5;...
    79 3 196.966569 1.5;...
    80 0 200.590 0;...
    80 1 200.590 1.5;...
    80 2 200.590 1.5;...
    81 0 204.3833 0;...
    81 1 204.3833 1.5;...
    81 3 204.3833 1.5;...
    82 0 207.200 0;...
    82 2 207.200 1.5;...
    82 4 207.200 1.5;...
    83 0 208.9804 0;...
    83 3 208.9804 1.5;...
    83 5 208.9804 1.5;...
    84 0 208.9804 0;...
    85 0 208.9804 0;...
    86 0 208.9804 0;...
    87 0 208.9804 0;...
    88 0 208.9804 0;...
    88 2 208.9804 1.5;...
    89 0 208.9804 0;...
    89 3 208.9804 1.5;...
    90 0 232.03806 0;...
    90 4 232.03806 1.5;...
    91 0 231.03588 0;...
    92 0 238.02891 0;...
    92 3 238.02891 1.5;...
    92 4 238.02891 1.5;...
    92 6 238.02891 1.5;...
    93 0 238.02891 0;...
    93 3 238.02891 1.5;...
    93 4 238.02891 1.5;...
    93 6 238.02891 1.5;...
    94 0 238.02891 0;...
    94 3 238.02891 1.5;...
    94 4 238.02891 1.5;...
    94 6 238.02891 1.5;...
    95 0 238.02891 0;...
    96 0 238.02891 0;...
    97 0 238.02891 0;...
    98 0 238.02891 0;...
    ];

coeffs=[...
    4.90e-05 0.413048 0.294953 0.187491 0.080701 0.023736 15.569946 32.398468 5.711404 61.889874 1.334118;...
    0.000425 0.70226 0.763666 0.248678 0.261323 0.023017 23.945604 74.897919 6.773289 233.58345 1.337531;...
    0.000487 0.732354 0.753896 0.283819 0.190003 0.039139 11.553918 4.595831 1.546299 26.463964 0.377523;...
    0.002542 0.974637 0.158472 0.811855 0.262416 0.790108 4.334946 0.342451 97.102966 201.363831 1.409234;...
    0.001764 0.432724 0.549257 0.376575 -0.336481 0.97606 0.260367 1.042836 7.885294 0.260368 3.042539;...
    0.002511 1.533712 0.638283 0.601052 0.106139 1.118414 42.662079 0.59542 99.106499 0.15134 1.843093;...
    -0.653773 3.05543 -2.372617 1.044914 0.544233 0.381737 0.001226 0.001227 1.542106 0.456279 4.047479;...
    0.003823 2.085185 1.06458 1.062788 0.140515 0.641784 23.494068 1.137894 61.238976 0.114886 0.399036;...
    4.297983 2.657506 1.078079 1.490909 -4.24107 0.713791 14.780758 0.776775 42.086842 -0.000294 0.239535;...
    0.019722 1.258489 0.728215 1.119856 2.168133 0.705239 10.683769 0.208177 0.836097 24.603704 58.954273;...
    -11.804902 11.89378 3.277479 1.858092 0.858927 0.912985 0.000158 10.232723 30.34469 0.656065 0.217287;...
    0.027014 2.960427 2.508818 0.637853 0.722838 1.142756 14.182259 5.936858 0.112726 34.958481 0.39024;...
    0.046136 3.106934 3.235142 1.148886 0.783981 0.676953 19.86808 6.960252 0.170043 65.693512 0.630757;...
    0.025429 3.990247 2.300563 0.6072 1.907882 1.16708 16.639956 5.636819 0.108493 47.299709 0.379984;...
    0.0817716077 3.7112086044 2.9808357753 1.3234818897 0.781899673 1.1189575326 15.6328903403000 4.9075336219 -0.0927836086 67.2137935891000 29.8955961228000;...
    0.032557 3.511943 2.772244 0.678385 0.915159 1.089261 10.687859 4.380466 0.093982 27.255203 0.313066;...
    0.069525 0.457649 3.841561 1.432771 0.801876 3.395041 0.917243 5.507803 0.164955 51.076206 15.821679;...
    0.025429 3.990247 2.300563 0.6072 1.907882 1.16708 16.639956 5.636819 0.108493 47.299709 0.379984;...
    0.025576 4.183749 2.905726 0.520513 1.135641 1.228065 8.175457 3.252536 0.063295 21.81391 0.224952;...
    0.079712 4.910127 3.081783 1.262067 1.098938 0.560991 3.281434 9.119178 0.102763 132.013947 0.405878;...
    0.0453 3.14869 4.073989 0.767888 0.995612 0.968249 2.594987 6.046925 0.070139 14.122657 0.217037;...
    0.126842 4.708971 1.194814 1.558157 1.170413 3.239403 4.875207 108.506081 0.111516 48.292408 1.928171;...
    1.54721309 5.401034124 -52.05602002 54.84239699 0.6078769288 0.6571202564 2.419904697 8.528164558 8.405980557 109.6784057 43.68695258;...
    0.058851 3.062918 4.135106 0.853742 1.036792 0.85252 2.015803 4.417941 0.065307 9.66971 0.187818;...
    0.139509 4.730796 2.313951 1.54198 1.117564 3.154754 3.628931 43.051167 0.09596 108.932388 1.555918;...
    0.1315188639 1.2350269021 0.5698803269 7.21364941 -2.9599280486 5.3108185306 32.9722977364000 58.4965856924000 0.3080753308 -0.1724362195 3.9590276059;...
    0.019397 4.132015 0.912049 1.102425 0.614876 3.219136 3.528641 7.378344 0.133708 0.039065 1.644728;...
    0.145073 5.275329 3.191038 1.511514 1.356849 2.519114 2.631338 33.730728 0.081119 86.288643 1.170087;...
    0.14603 2.879033 3.07296 1.515981 1.39003 4.995051 1.239713 38.706276 0.081481 93.616333 2.770293;...
    0.3963295865 4.7298377194 0.6519626421 3.3278304574 1.6223740315 1.2593895831 2.9267346036 52.6132881596000 0.5050129897 31.6813758444000 2.6993888649;...
    0.097266 3.676722 3.828496 1.258033 0.419024 0.720421 1.446851 3.013144 0.064397 0.206254 5.970222;...
    0.155233 1.950541 4.14693 1.49456 1.522042 5.729711 0.908139 27.044952 0.07128 67.520187 1.981173;...
    0.154722 6.372157 5.154568 1.473732 1.635073 1.209372 1.514347 22.092527 0.061373 55.445175 0.646925;...
    0.146773 1.446071 6.870609 6.151801 1.750347 0.634168 0.052357 1.193165 18.343416 46.398396 0.401005;...
    -34.916603 1.061802 7.139886 6.524271 2.355626 35.829403 0.144727 1.171795 19.467655 60.320301 0.000436;...
    0.265954 7.188004 6.638454 0.45418 1.929593 1.523654 0.956221 15.339877 15.339862 39.043823 0.062409;...
    0.253614 8.163991 7.146945 1.07014 0.877316 1.486434 12.816323 0.808945 210.327011 39.597652 0.052821;...
    0.257164 -17.609339 1.494873 7.150305 10.899569 15.808228 18.840979 0.053453 0.81294 22.264105 14.351593;...
    0.196255 8.593655 1.477324 1.436254 1.182839 7.113258 10.460644 0.041891 81.390381 169.847839 0.688098;...
    -21.013187 8.501441 12.880483 9.765095 7.156669 0.71116 10.525848 -0.004033 0.010692 0.684443 27.231771;...
    0.157765 1.476566 1.487278 1.600187 9.177463 7.09975 53.131023 0.035325 137.319489 9.098031 0.602102;...
    0.118642 7.104348 1.511488 -53.669773 38.404816 24.53224 0.601957 0.033386 12.572138 10.859736 14.12523;...
    0.102473 9.818524 1.522646 1.703101 1.768774 7.082555 8.001879 0.029763 39.885422 120.157997 0.532405;...
    0.150362 7.040119 1.496285 9.657304 0.006534 1.649561 0.537072 0.031914 8.009958 201.800293 24.039482;...
    -35.111282 36.587933 7.230255 -9.086077 2.084594 17.294008 0.000681 0.522262 5.262317 15.881716 6.149805;...
    -0.110628 45.355537 7.0929 7.483858 -43.498817 1.678915 9.252186 0.523046 13.082852 10.193876 0.023064;...
    0.067744 10.473575 1.547881 1.986381 1.865616 7.05625 7.08194 0.02604 31.909672 108.022842 0.474882;...
    -0.533379 7.754356 2.0641 2.576998 2.011404 7.126177 7.066315 0.014993 7.066308 22.055786 0.467568;...
    0.474921 9.95848 1.59635 1.483442 -10.846044 17.332867 6.763041 0.056895 17.750029 0.328826 0.388013;...
    0.552676 15.575018 8.448095 1.61204 -9.721855 1.534029 0.682708 5.56664 10.527077 0.907961 0.066667;...
    0.06551 11.007069 1.555477 2.985293 1.347855 7.034779 6.366281 0.023987 23.244839 105.774498 0.429369;...
    0.04987 10.598877 1.565858 2.72828 0.098064 6.959321 6.151846 0.023519 17.432816 54.002388 0.426301;...
    -0.192123 7.98931 1.765079 2.627125 1.82938 6.980908 6.068867 0.018342 6.068887 16.309284 0.420864;...
    -0.147293 11.709542 1.733414 2.673141 2.023368 7.00318 5.59712 0.0178 21.78842 89.517914 0.383054;...
    -24.566132 11.287712 26.042414 3.058096 0.090258 7.088306 5.506225 0.000774 16.158575 54.766354 0.37558;...
    -0.093713 6.926972 2.081342 11.128379 2.375107 -0.419287 0.378315 0.015054 5.379957 14.429586 0.004939;...
    0.672146 12.409131 7.466993 1.809947 -12.138477 10.780248 0.3004 0.112814 12.520756 0.168653 5.173237;...
    -0.304931 12.311098 1.876623 3.066177 2.070451 6.975185 5.009415 0.014461 18.74304 82.767876 0.346506;...
    -61.44564969 12.78432135 62.56327581 1.683751473 1.432130736 6.958358598 6.234159837 -0.000399296 1.0632928865 21.58593936 0.374772458;...
    -9.676919 11.776765 11.165097 3.533495 0.165345 7.036932 4.912232 0.001748 14.166556 42.381958 0.341324;...
    -61.930725 9.721638 63.403847 2.141347 2.629274 7.033846 4.869297 0.000293 4.867602 13.539076 0.33852;...
    -0.936572 12.91451 2.481908 3.466894 2.106351 6.960892 4.507138 0.009126 16.438129 76.98732 0.314418;...
    -24.796852 6.99384 26.285812 12.254289 0.246114 4.017407 0.310779 0.000684 4.400528 35.741447 12.536393;...
    -1.147345 6.861739 2.67857 12.281889 3.501741 -0.179384 0.309794 0.008142 4.331703 11.914167 11.914167;...
    -2.762697 13.521865 6.947285 3.866028 2.1359 4.284731 4.077277 0.286763 14.622634 71.96608 0.004437;...
    -36.344471 12.519017 37.832058 4.387257 0.661552 6.949072 3.933053 0.000442 10.449184 23.860998 0.283723;...
    -0.317618 13.579366 1.902844 12.859268 3.811005 -6.838595 0.31314 0.012621 3.906407 10.894311 0.344379;...
    -3.254477 14.014192 4.784577 5.056806 1.457971 6.932996 3.73828 0.003744 13.034982 72.554794 0.265666;...
    -14.84932 12.960763 16.34215 1.110102 5.520682 6.915452 3.57601 0.000975 29.523218 10.114283 0.261326;...
    -14.878383 11.895569 16.344978 5.799817 1.048804 6.789088 3.378519 0.000924 8.133653 20.526524 0.254741;...
    -36.915829 14.741002 6.907748 4.642337 2.191766 38.424042 3.388232 0.243315 11.903689 63.31213 0.000397;...
    -8.945248 13.340772 10.428857 5.544489 0.762295 6.869172 3.215913 0.001413 8.54268 21.891756 0.239215;...
    -0.847395 15.758946 6.841123 4.121016 2.714681 2.395246 3.121754 0.226057 12.482196 66.203621 0.007238;...
    -33.875122 13.123875 35.288189 6.126979 0.611551 6.724807 2.80996 0.000323 6.831534 16.784311 0.212002;...
    0.018726 16.540613 1.5679 3.727829 3.345098 6.785079 2.866618 0.012198 13.432163 58.866047 0.210974;...
    1.086542 6.876636 6.779091 9.969591 3.135857 0.152389 2.025174 0.17665 3.573822 7.685848 16.677574;...
    -2.984117 17.025642 4.503441 3.715904 3.9372 6.790175 2.597739 0.003012 14.272119 50.437996 0.193015;...
    180.8052097 7.887361193 -184.185669 4.442661888 3.68850792 4.349643565 13.09791052 0.001710201 1.978601512 36.20862715 -0.16291182;...
    -3.160982 17.354071 4.653248 4.259489 4.136455 6.749163 2.349787 0.00255 15.57946 45.181202 0.177432;...
    -2.492088 17.55057 5.411882 3.93718 3.880645 6.707793 2.119226 16.557184 0.002481 42.164009 0.162121;...
    1.152674 17.71431 6.466926 6.947385 4.402674 -0.697279 2.122554 19.050768 0.152708 58.690361 58.690372;...
    -2.810592 17.655279 6.848105 4.171004 3.44676 6.6852 1.908231 16.606236 0.001598 39.917473 0.146896;...
    1.139548 8.123134 2.138042 6.761702 1.156051 17.679546 15.142385 33.542667 0.129372 224.132507 1.713368;...
    1.133263 17.68432 7.761588 6.680874 2.668883 0.070974 1.710209 14.919863 0.128542 31.654478 0.128543;...
    1.140251 17.730219 9.795867 6.099763 2.620025 0.600053 1.56306 14.310868 0.120574 135.771317 0.120574;...
    1.125309 17.694973 1.275762 6.154252 9.234786 0.515995 1.550888 30.133041 0.118774 13.821799 0.118774;...
    1.131787 17.79204 10.253252 5.714949 3.170516 0.918251 1.429691 13.132816 0.112173 108.197029 0.112173;...
    1.124859 17.859772 10.911038 5.821115 3.512513 0.746965 1.310692 12.319285 0.104353 91.777542 0.104353;...
    0.827902 6.802956 17.699253 10.650647 -0.248108 0.250338 0.096228 1.296127 11.240715 -0.219259 -0.219021;...
    1.123452 17.958399 12.063054 5.007015 3.287667 1.531019 1.21159 12.246687 0.098615 75.011948 0.098615;...
    -8.339573 17.714323 1.675213 7.483963 8.322464 11.143573 1.172419 30.102791 0.080255 -0.002983 10.456687;...
    -68.02478 17.580206 7.633277 10.793497 0.180884 67.837921 1.165852 0.078558 9.507652 31.621656 -0.000438;...
    1.10877 6.236218 17.987711 12.973127 3.451426 0.210899 0.09078 1.10831 11.46872 66.684151 0.09078;...
    -1.898764 7.44705 17.778122 11.886068 1.997905 1.789626 0.0720 1.073145 9.83472 28.221746 -0.011674;...
    -78.056595 7.929879 17.667669 11.515987 0.500402 77.444084 0.068856 1.068064 9.046229 26.558945 -0.000473;...
    1.141916 34.757683 9.653037 6.584769 -18.628115 2.490594 1.30177 7.123843 0.094097 1.617443 12.335434;...
    1.074784 17.840963 3.428236 1.373012 12.947364 6.335469 1.005729 41.901382 119.320541 9.781542 0.083391;...
    1.043992 6.271624 17.906738 14.123269 3.746008 0.908235 0.07704 0.928222 9.555345 35.86068 123.552246;...
    -51.905243 17.894758 13.579529 10.729251 2.474095 48.227997 0.902827 8.740579 0.045125 24.764954 -0.001699;...
    -17.241762 17.845776 13.455084 10.229087 1.653524 14.059795 0.90107 8.482392 0.045972 23.015272 -0.004889;...
    0.995452 6.216648 17.919739 3.854252 0.840326 15.173498 0.070789 0.856121 33.889484 121.686691 9.029517;...
    0.960843 17.758621 14.569813 5.29832 2.533579 0.879753 0.841779 8.319533 0.06905 23.709131 0.06905;...
    0.959941 17.716188 14.446654 5.185801 1.703448 0.989992 0.840572 8.100647 0.068995 22.357307 0.068995;...
    0.883099 6.121511 4.784063 16.631683 4.318258 13.246773 0.062549 0.784031 8.751391 34.489983 0.784031;...
    0.879336 6.122282 15.651012 3.513508 9.06079 8.771199 0.062424 8.018296 24.784275 0.776457 0.776457;...
    0.915874 6.152421 -96.069023 31.622141 81.578255 17.801403 0.063951 11.090354 13.466152 9.758302 0.783014;...
    0.756603 6.073874 17.155437 4.173344 0.852238 17.988686 0.055333 7.896512 28.443739 110.376106 0.716809;...
    0.785127 6.091192 4.019526 16.948174 4.258638 13.889437 0.056305 0.71934 7.758938 27.368349 0.71934;...
    1.068247 6.401808 48.699802 4.799859 -32.332523 16.35671 0.068167 0.94227 20.639496 1.100365 6.883131;...
    0.603504 6.080986 18.019468 4.018197 1.30351 17.974669 0.04899 7.273646 29.119284 95.831207 0.661231;...
    0.664795 6.093711 43.909691 17.041306 -39.675117 17.958918 0.050624 8.654143 15.621396 11.082067 0.667591;...
    0.333097 6.196477 18.816183 4.050479 1.638929 17.962912 0.042072 6.695665 31.00979 103.284348 0.610714;...
    0.293677 6.206277 18.497746 3.078131 10.524613 7.401234 0.041357 6.605563 18.79225 0.608082 0.608082;...
    0.119024 19.325171 6.281571 4.498866 1.856934 17.917318 6.118104 0.036915 32.529045 95.037186 0.565651;...
    -0.042519 6.353672 4.770377 14.672025 4.235959 18.002131 0.03472 6.167891 6.167879 29.006456 0.561774;...
    -0.172219 15.445732 6.420892 4.56298 1.713385 18.033537 6.280898 0.033144 6.280899 17.983601 0.55798;...
    -0.290506 5.394956 6.54957 19.650681 1.82782 17.867832 33.326523 0.030974 5.564929 87.130966 0.523992;...
    1.516108 10.189171 57.461918 19.356573 4.862206 -45.394096 0.089485 0.375256 5.357987 22.153736 0.297768;...
    -0.445371 17.920622 6.647932 12.724075 1.555545 7.600591 0.522315 0.029487 5.71821 16.433775 5.718204;...
    -0.806668 6.660302 6.940756 19.847015 1.557175 17.802427 33.031654 0.02575 5.065547 84.101616 0.48766;...
    -0.448811 19.884502 6.736593 8.110516 1.170953 17.548716 4.628591 0.027754 31.849096 84.406387 0.46355;...
    -3.341004 20.01033 17.835524 8.10413 2.231118 9.158548 4.565931 0.444266 32.430672 95.14904 0.014906;...
    -6.065902 19.97892 11.774945 9.332182 1.244749 17.737501 4.143356 0.010142 28.7962 75.280685 0.413616;...
    -2.322802 17.418674 8.314444 10.323193 1.383834 19.876251 0.399828 0.016872 25.605827 233.339676 3.826915;...
    -19.394306 19.939056 24.967621 10.375884 0.454243 17.660248 3.770511 0.00404 25.311275 76.537766 0.38473;...
    -5.183497 19.747343 17.368477 10.465718 2.592602 11.003653 3.481823 0.371224 21.226641 173.834274 0.010719;...
    -59.618172 19.7502 17.513683 10.884892 0.321585 65.149834 3.430748 0.36159 21.358307 70.309402 0.001418;...
    -21.745489 19.966019 27.329655 11.018425 3.086696 17.335455 3.197408 0.003446 19.955492 141.381973 0.341817;...
    -76.846909 19.688887 17.345703 11.356296 0.099418 82.358124 3.146211 0.339586 18.753832 90.345459 0.001072;...
    -38.386017 17.355122 43.988499 20.54665 3.13067 11.353665 0.328369 0.002047 3.088196 134.907654 18.83296;...
    -80.313423 26.593231 85.866432 -6.677695 12.111847 17.401903 3.280381 0.001012 4.313575 17.868504 0.326962;...
    -3.515096 17.457533 25.659941 11.691037 19.695251 -16.994749 0.311812 -0.003793 16.568687 2.886395 -0.008931;...
    -3.871068 21.551311 17.16173 11.903859 2.679103 9.564197 2.995675 0.312491 17.716705 152.192825 0.010468;...
    -30.500784 20.879841 36.035797 12.135341 0.283103 17.167803 2.870897 0.002364 16.615236 53.909359 0.306993;...
    -9.016722 17.496082 21.538509 20.403114 12.062211 -7.492043 0.294457 -0.002742 2.772886 15.804613 -0.013556;...
    -57.189842 17.331244 62.783924 12.160097 2.663483 22.23995 0.300269 0.00132 17.026001 148.748993 2.910268;...
    -50.541992 17.120077 56.038139 21.468307 10.000671 2.905866 0.291295 0.001421 2.743681 14.581367 22.485098;...
    -45.973682 17.286388 51.560162 12.478557 2.675515 22.960947 0.28662 0.00155 16.223755 143.984512 2.79648;...
    -46.767181 22.221066 17.068142 12.805423 0.435687 52.23877 2.635767 0.277039 14.927315 45.768017 0.001455;...
    -17.452166 23.700363 23.072214 12.777782 2.684217 17.204367 2.689539 0.003491 15.495437 139.862473 0.274536;...
    -9.714854 15.618565 19.538092 13.398946 -4.358811 24.490461 0.006001 0.306379 14.979594 0.748825 2.454492;...
    -31.586687 17.186195 37.156837 13.103387 2.707246 24.419271 0.261678 0.001995 14.78736 134.816299 2.581883;...
    -26.204315 23.899035 31.657497 12.955752 1.700576 16.992199 2.467332 0.00223 13.625002 35.089481 0.253136;...
    -19.768026 17.758327 33.498665 24.067188 13.436883 -9.019134 0.244474 -0.003901 2.487526 14.568011 -0.015628;...
    -43.505684 24.898117 17.104952 13.222581 3.266152 48.995213 2.435028 0.246961 13.996325 110.863091 0.001383;...
    -88.147179 24.344999 16.945311 13.866931 0.481674 93.506378 2.333971 0.239215 12.982995 43.876347 0.000673;...
    -26.851971 25.910013 32.344139 13.765117 2.751404 17.064405 2.373912 0.002034 13.481969 125.83651 0.236916;...
    -33.950317 24.878252 16.856016 13.663937 1.279671 39.271294 2.223301 0.22729 11.812528 29.910065 0.001527;...
    -83.279831 26.671785 88.687576 14.065445 2.768497 17.067781 2.282593 0.000665 12.92023 121.937187 0.225531;...
    -85.15065 16.864344 90.383461 13.675473 1.687078 25.540651 0.216275 0.000593 11.121207 26.250975 2.13593;...
    -41.165253 27.15019 16.999819 14.059334 3.386979 46.546471 2.16966 0.215414 12.213148 100.506783 0.001211;...
    -58.026505 16.837524 63.221336 13.703766 2.061602 26.202621 0.206873 0.000796 10.500283 24.031883 2.05506;...
    -77.135223 28.174887 82.493271 14.624002 2.802756 17.018515 2.120995 0.000640 11.915256 114.529938 0.207519;...
    -17.51346 16.810127 22.681061 13.864114 2.294506 26.864477 0.198293 0.002126 9.973341 22.836388 1.979442;...
    -70.839813 28.925894 76.173798 14.904704 2.814812 16.998117 2.046203 0.000656 11.465375 111.41198 0.199376;...
    -10.192087 16.7875 15.350905 14.182357 2.299111 27.573771 0.190852 0.003036 9.602934 22.52688 1.912862;...
    -60.313812 29.67676 65.624069 15.160854 2.830288 16.99785 1.97763 0.000720 11.044622 108.139153 0.19211;...
    -23.214935 28.443794 16.849527 14.165081 3.445311 28.308853 1.863896 0.183811 9.225469 23.691355 0.001463;...
    -18.103676 28.191629 16.828087 14.167848 2.744962 23.171774 1.842889 0.182788 9.045957 20.799847 0.001759;...
    -51.049416 30.122866 15.099346 56.314899 3.54098 16.943729 1.88309 10.342764 0.000780 89.55925 0.183849;...
    -20.626528 28.828693 16.823227 14.247617 3.079559 25.647667 1.776641 0.17556 8.575531 19.693701 0.001453;...
    -49.719837 30.617033 15.145351 54.933548 4.096253 16.896156 1.795613 9.934469 0.000739 76.189705 0.175914;...
    -18.820383 29.267378 16.792543 14.78531 2.184128 23.791996 1.697911 0.168313 8.190025 18.277578 0.001431;...
    -44.119026 31.066359 15.341823 49.278297 4.577665 16.828321 1.708732 9.618455 0.000760 66.346199 0.168002;...
    -11.542459 29.539469 16.741854 15.18207 1.642916 16.437447 1.612934 0.16046 7.654408 17.070732 0.001858;...
    -32.864574 31.5079 15.682498 37.960129 4.885509 16.792112 1.629485 9.446448 0.000898 59.980675 0.160798;...
    3.945157 29.729357 17.247808 15.184488 1.154652 0.739335 1.501648 0.140803 6.880573 14.299601 14.299618;...
    -37.412682 31.888456 16.117104 42.390297 5.211669 16.767591 1.549238 9.233474 0.000689 54.516373 0.152815;...
    -43.677956 32.210297 16.67844 48.559906 5.455839 16.735533 1.473531 9.049695 0.000519 50.210201 0.145771;...
    3.98839 17.113485 15.79237 23.342392 4.090271 7.671292 0.13185 7.288542 1.389307 19.629425 1.389307;...
    4.018893 32.004436 1.975454 17.070105 15.939454 5.990003 1.353767 81.014175 0.128093 7.661196 26.659403;...
    4.009459 31.537575 16.363338 15.597141 5.051404 1.436935 1.334144 7.451918 0.127514 21.705648 0.127515;...
    4.006865 30.391249 16.146996 17.019068 4.458904 0.975372 1.328519 7.181766 0.127337 19.060146 1.328519;...
    4.050394 31.273891 18.44544 17.063745 5.555933 1.57527 1.316992 8.797154 0.124741 40.177994 1.316997;...
    4.032512 31.986849 17.249048 15.269374 5.760234 1.694079 1.281143 7.625512 0.123571 24.190826 0.123571;...
    4.094551 41.932713 16.339224 17.653894 6.01242 -12.036877 1.111409 6.466086 0.128917 16.954155 0.778721;...
    -6.279078 16.77739 19.317156 32.979683 5.595453 10.576854 0.122737 8.62157 1.256902 38.00882 0.000601;...
    4.040792 32.124306 16.716476 16.8141 7.311565 0.993064 1.216073 7.165378 0.118715 20.442486 53.095985;...
    4.042679 31.704271 17.545767 16.819551 5.52264 0.361725 1.215561 7.220506 0.118812 20.05097 1.215562;...
    4.076478 16.83989 20.023823 28.428564 5.881564 4.714706 0.115905 8.256927 1.19525 39.247227 1.19525;...
    4.06843 28.866837 19.27754 16.776051 6.281459 3.710289 1.173967 7.583842 0.115351 29.055994 1.173968;...
    4.052869 32.411079 18.690371 16.711773 9.974835 -3.847611 1.16298 7.329806 0.114518 22.009489 22.009493;...
    4.066939 16.630795 19.386616 32.808571 1.747191 6.356862 0.110704 7.181401 1.11973 90.660263 26.014978;...
    4.05403 32.295044 16.570049 17.991013 1.535355 7.554591 1.101544 0.11002 6.528559 52.495068 20.338634;...
    -9.256075 32.525639 19.139185 17.100321 5.891115 12.599463 1.094966 6.900992 0.103667 18.489614 -0.001401;...
    4.049824 16.419567 32.73859 6.530247 2.342742 19.916475 0.105499 1.055049 25.02589 80.906593 6.664449;...
    4.065623 27.392647 16.496822 19.984501 6.813923 5.23391 1.058874 0.106305 6.708123 24.395554 1.058874;...
    4.044678 32.505657 20.01424 14.645661 5.029499 1.760138 1.047035 6.670321 0.105279 16.52504 0.105279;...
    4.040914 16.282274 32.725136 6.678302 2.69475 20.576559 0.10118 1.002287 25.714146 77.057549 6.291882;...
    4.043703 32.461437 19.438683 16.302486 7.322662 0.431704 0.99793 6.038867 0.101338 18.371586 46.361046;...
    4.113663 16.734028 20.580494 9.452623 61.155834 -34.041023 0.105076 4.773282 11.762162 1.211775 1.619408;...
    4.046556 16.289164 32.807171 21.095163 2.505901 7.254589 0.098121 0.966265 6.046622 76.598068 28.096128;...
    3.995684 16.011461 32.615547 8.113899 2.884082 21.377867 0.092639 0.904416 26.543257 68.372963 5.499512;...
    4.020977 16.070229 32.641106 21.489658 2.299218 9.480184 0.090437 0.876409 5.239687 69.188477 27.632641;...
    4.003472 16.007385 32.66383 21.594351 1.598497 11.121192 0.087031 0.840187 4.954467 199.805801 26.905106;...
    3.981773 32.56369 21.396671 11.298093 2.834688 15.914965 0.80198 4.590666 22.758972 160.404388 0.083544;...
    3.956572 4.986228 32.474945 21.947443 11.800013 10.807292 0.082597 0.791468 4.608034 24.792431 0.082597;...
    3.939212 15.914053 32.535042 21.553976 11.433394 3.612409 0.080511 0.770669 4.352206 21.381622 130.500748;...
    3.838984 15.584983 32.022125 21.456327 0.757593 12.341252 0.077438 0.739963 4.040735 47.525002 19.406845;...
    3.922533 15.784024 32.454899 21.849222 4.239077 11.736191 0.077067 0.735137 4.097976 109.464111 20.512138;...
    3.831122 15.515445 32.090691 13.996399 12.918157 7.635514 0.074499 0.711663 3.871044 18.596891 3.871044;...
    3.886066 32.740208 21.973675 12.957398 3.683832 15.744058 0.709545 4.050881 19.231543 117.255005 0.07404;...
    3.854444 15.679275 32.824306 13.660459 3.687261 22.279434 0.071206 0.681177 18.236156 112.500038 3.930325;...
    3.706622 15.360309 32.395657 21.96129 1.325894 14.251453 0.067815 0.654643 3.643409 39.604965 16.33057;...
    3.705863 15.355091 32.235306 0.557745 14.396367 21.751173 0.067789 0.652613 42.354237 15.908239 3.553231;...
    3.700591 15.333844 31.770849 21.274414 13.872636 0.048519 0.067644 0.646384 3.317894 14.65025 75.339699;...
    3.769391 32.999901 22.638077 14.219973 3.67295 15.683245 0.657086 3.854918 17.435474 109.464485 0.068033;...
    3.60337 15.378152 32.572132 22.206125 1.413295 14.828381 0.064613 0.63142 3.561936 37.875511 15.546129;...
    3.603039 15.373926 32.423019 21.969994 0.662078 14.96935 0.064597 0.629658 3.476389 39.438942 15.135764;...
    3.600942 15.359986 31.992825 21.412458 0.066574 14.568174 0.064528 0.624505 3.253441 67.658318 13.980832;...
    3.6642 33.281178 23.148544 15.153755 3.031492 15.704215 0.634999 3.856168 16.849735 121.292038 0.064857;...
    3.428895 15.356004 32.769127 22.68021 1.351055 15.416232 0.06059 0.604663 3.491509 37.260635 14.981921;...
    3.480408 15.416219 32.610569 22.256662 0.719495 15.518152 0.061456 0.607938 3.411848 37.628792 14.46436;...
    3.502325 15.436506 32.289719 14.726737 15.012391 7.024677 0.061815 0.606541 3.245363 13.616438 3.245364;...
    3.54116 33.435162 23.657259 15.576339 3.027023 15.7461 0.612785 3.792942 16.195778 117.757004 0.061755;...
    3.39084 15.804837 33.480801 24.150198 3.655563 15.499866 0.058619 0.59016 3.67472 100.736191 15.408296;...
    3.213169 15.889072 33.625286 24.710381 3.707139 15.839268 0.055503 0.569571 3.615472 97.694786 14.754303;...
    3.005326 33.794075 25.467693 16.048487 3.657525 16.008982 0.550447 3.581973 14.357388 96.064972 0.05245;...
    ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

index=find(ismember(Waasmaier_Kirfel_label,Atom_label)==1);

% Whatwhatwhat?
if size(index,2)==0
    disp('Did not found the atomtype...')
    Atom_label
    pause
end

c=coeffs(index,1);
a1=coeffs(index,2);
a2=coeffs(index,3);
a3=coeffs(index,4);
a4=coeffs(index,5);
a5=coeffs(index,6);
b1=coeffs(index,7);
b2=coeffs(index,8);
b3=coeffs(index,9);
b4=coeffs(index,10);
b5=coeffs(index,11);

theta=twotheta./2;

sinthetaoverlambda=sin(theta*pi()/180)/lambda;

f_zero = a1*exp(-b1.*sinthetaoverlambda.^2)...
    +a2*exp(-b2.*sinthetaoverlambda.^2)...
    +a3*exp(-b3.*sinthetaoverlambda.^2)...
    +a4*exp(-b4.*sinthetaoverlambda.^2)...
    +a5*exp(-b5.*sinthetaoverlambda.^2)+c;

% % ANOMALOUS DISPERSION CORRECTION FOR IRON WITH COPPER RADIATION, TAKEN FROM NEWMOD, 1987
% if strncmpi(Atom_label,{'Fe'},2);
%     f_zero = ((f_zero-1.1).^2+11.56).^0.5;
% end

f = f_zero.*exp(-Biso*sin((twotheta/2)*pi()/180).^2/lambda^2);

% Because Oh has 9 e-
% if strncmpi(Atom_label,{'H'},2)
%     f=.5*f;
% end

nElectrons=Waasmaier_Kirfel_data(index,1)-Waasmaier_Kirfel_data(index,2);

Atomtype=char(Atom_label);

assignin('caller','nElectrons',nElectrons);
assignin('caller','Atomtype',Atomtype);

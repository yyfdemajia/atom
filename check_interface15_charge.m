%% check_interface15_charge.m
% * This function checks the charge of interface_param atomtypes
% * atom is the atom struct

%% Examples
% * atom = check_interface15_charge(atom)

function atom = check_interface15_charge(atom)
%% 
% atom=System;
nAtoms=size(atom,2);
interface15_param(unique([atom.fftype]),'tip3p');
for i=1:length(atom)
    if strncmpi([atom(i).fftype],{'Hw'},2);
        ind=strncmpi({'Hw'},[forcefield.interface15.type],2);
        atom(i).charge=[forcefield.interface15(ind).charge];
    elseif sum(strcmpi([atom(i).fftype],[forcefield.interface15.type])) > 0;
        ind=strcmpi([atom(i).fftype],[forcefield.interface15.type]);
        atom(i).charge=[forcefield.interface15(ind).charge];
    else 
        atom(i).charge=0;
    end
end

disp('Total charge')
Total_charge=sum([atom.charge])

assignin('caller','Total_charge',Total_charge);
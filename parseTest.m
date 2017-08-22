clc;clear;
f=fopen(fn,'r');
%Beginning information
while ~feof(f)
    tline = fgetl(f);
    if strcmp(tline(1:3),'---')
        break;
    end
end
%Data sets
while ~feof(f)
    
end
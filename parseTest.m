%Read the .out file of pint test

clc;clear;
f=fopen('data\\run-egfr104-priority-2015-02-12.out','r');
%killed=9986;
%Inconc=zeros(killed,12);
Inconc=[];
%Beginning information
while ~feof(f)
    tline = fgetl(f);
    if strcmp(tline(1:3),'---')
        temp=tline(5:end);
        words=regexp(temp,',*\s|\(\*|\*\)','split');
        dict=containers.Map(1:13,words(1:2:25)); %dictionary of varying initial states
        break;
    end
end
%Data sets
posVert=0;
while ~feof(f)
    killedMark=0;
    temp=tline(5:end);
    if strcmp(tline(1:3),'---')
        for i=1:12
            tline = fgetl(f);
            tline = fgetl(f);
            if strcmp(tline,'*** Killed ***')
                killedMark=1;
            end
        end
        if killedMark
            posVert=posVert+1;
            words=regexp(temp,',*\s|\(\*|\*\)','split');
            Inconc=[Inconc;words(2:2:end)];
        end
    end
    tline = fgetl(f);
end

%Read the .out file of pint test
function [inconc,dictInput,dictOutput]=parseTest(filename)
f=fopen(filename,'r');
%killed=9986;
%Inconc=zeros(killed,12);
inconc=[];
%Beginning information
dictOutput=containers.Map;
while ~feof(f)
    tline = fgetl(f);
    if strcmp(tline(1:6),'Inputs')
        words=regexp(tline,'\s','split');
        count=size(words,2);
        dictInput=containers.Map(1:count-1,words(2:count));
    elseif strcmp(tline(1:7),'Outputs')
        words=regexp(tline,'\s','split');
        count=size(words,2);
        dictOutput=containers.Map(1:count-1,words(2:count));
        break;
    end
end

%Data sets
posVert=0;
while ~feof(f)
    killedMark=0;
    temp=tline(5:end);
    if strcmp(tline(1:3),'---')
        for i=1:size(dictOutput,1)
            tline = fgetl(f);
            tline = fgetl(f);
            if strcmp(tline,'*** Killed ***')
                killedMark=1;
            end
        end
        if killedMark
            posVert=posVert+1;
            words=regexp(temp,',*\s|\(\*|\*\)','split');
            inconc=[inconc;str2double(words(2:2:end))];
        end
    end
    tline = fgetl(f);
end
if isempty(inconc)
    inconc=zeros(2^size(dictInput,1),size(dictInput,1));
    for i=0:1
        for j=0:1
            for k=0:1
                inconc(4*i+2*j+k+1,:)=[i,j,k];
            end
        end
    end
end
end

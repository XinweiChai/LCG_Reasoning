function [dict, actions, initialState,startNode]=readBAN(fn)
f=fopen(fn,'r');
actions=cell(0,4);
readProc=0;
process=[];
hasStartNode=0;
startNode=[0 0];
while ~feof(f)
    tline = fgetl(f);
    %split file
    if ~isempty(strfind(tline,'(*'))
        hasStartNode=1;
        while ~isempty(strfind(tline,'*)'))
            %pos=strfind(tline,'goal');
            words=regexp(tline,',*\s|\(\*|\*\)','split');
            pos= find(strcmp(words, 'goal'));
            startNode=words{pos+1};
            startNode=regexp(startNode,'_','split');
            tline=fgetl(f);
        end
    end
    s=regexp(tline,'\s*', 'split');
    if size(s,2)<=1
        continue;
    elseif size(s,2)>2 && ~readProc
        readProc=1;
        dict = containers.Map(process,1:size(process,1));
        if hasStartNode
            startNode=[dict(startNode{1}),str2double(startNode{2})];
        end
    end
    if ~readProc %read processes
        process=[process;s(1)];
        continue;
    else
    
%     init_state=cell(size(process,1),2);
%     init_state(:,1)=process;
    initialState=zeros(1,size(process,1));% all zeros as default
    if ~isequal(s(1),{'initial_state'})%read actions
        act=cell(1,4);
        act{2}=dict(s{1});
        act{3}=str2double(s{2});
        act{4}=str2double(s{4});
        s=s(1,6:end);
        s(2:2:size(s,2))=[];
        for i=1:size(s,2)
            temp=regexp(s{1,i},'=', 'split');
            act{1}=[act{1};[dict(temp{1}),str2double(temp(2))]];
        end
        actions=[actions;act];
    end
    end
end
%dictionary of processes
end
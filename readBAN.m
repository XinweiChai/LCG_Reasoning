function [process, actions, init_state]=readBAN(fn)
f=fopen(fn,'r');
actions=cell(0,4);
readProc=0;
process=[];

while ~feof(f) 
     tline = fgetl(f); 
     s=regexp(tline,'\s*', 'split');
     if size(s,2)~=2
         readProc=1;
     end
     if size(s,2)<=1
         continue;
     end
     if ~readProc %read processes
         process=[process;s(1)];
         continue;
     end
     
     init_state=cell(size(process,1),2);
     init_state(:,1)=process;
     for i=1:size(init_state,1)
        init_state{i,2}='0';
     end
     if ~isequal(s(1),{'initial_state'})%read actions, need modifications
         act=cell(1,4);
         act{2}=s{1};
         act{3}=(s{2});
         act{4}=(s{4});
         s=s(1,6:end);
         s(2:2:size(s,2))=[];
         for i=1:size(s,2)
             act{1}=[act{1};regexp(s{1,i},'=', 'split')];
         end
         actions=[actions;act];
     end
end
process = containers.Map(process,1:size(process,1));
end
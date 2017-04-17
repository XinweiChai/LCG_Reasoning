function [process, actions, init_state]=readPH(fn)
f=fopen(fn,'r');
nline=1;
actions=cell(0,5);
while ~feof(f) 
     tline = fgetl(f); 
%      s=regexp(tline,'\s*process*\s*', 'split');
     s=regexp(tline,'\s*', 'split');
%      s1 = char(s);
     if nline==1
        cnt=1;
        process=cell(floor(size(s,2)/3),2);
        cnt2=1;
        while cnt<size(s,2) && isequal(s(cnt),{'process'}) 
            process(cnt2,1)=s(cnt+1);
            process(cnt2,2)=s(cnt+2);
            cnt2=cnt2+1;
            cnt=cnt+3;
        end
     elseif isequal(s(1),{'initial_state'})
         init_state=cell(size(process));
         s(1)=[];
         for i=1:size(process,1)
             init_state(i,1)=s(2*i-1);
             init_state(i,2)=s(2*i);
         end
         
     else
         s(:,3)=[];
         actions=[actions;s];
     end
     nline = nline+1;
end

end
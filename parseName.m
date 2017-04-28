function [newLabels,procs,objs,sols]=parseName(labels)
procs=[];
objs=[];
sols=[];
newLabels=cell(size(labels));
for i=1:size(labels,2)
    if size(labels{i},2)>7 && strcmp(labels{i}(1:7),'pintsol')
        sols=[sols;i];
    elseif strcmp(labels{i}(1:2),'O_')
        objs=[objs;i];
    else
        pos=strfind(labels{i},'_');
        pos=pos(end);
        newLabels{i}={labels{i}(1:pos-1),labels{i}(pos+1:end)};
        procs=[procs;i];
    end
end
end
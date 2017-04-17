function [newLabels,procs,objs,sols]=parseName(labels)
procs=[];
objs=[];
sols=[];
newLabels=cell(size(labels));
for i=1:size(labels,2)
    %newLabels{i}=regexp(labels{i},'_|sol', 'split');
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
    
%     newLabels{i}=regexp(labels{i},'\d_\d', 'split');
%     labels(i)
%     newLabels{i}
%     switch size(newLabels{i},2)
%         case 1
%             sols=[sols;i];
%         case 2
%             procs=[procs;i];
%         case 4
%             objs=[objs;i];
%     end
end
end
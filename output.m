function output=output(sequence)
output=cell(size(sequence));
for i=1:size(sequence,1)
    for j=1:size(sequence{i,1},2)
        output{i,1}=[output{i,1},sequence{i,1}{j}{1},'_',sequence{i,1}{j}{2},' '];
    end
    
    output{i,2}=[sequence{i,2}{1},'_',sequence{i,2}{2}];
end
end
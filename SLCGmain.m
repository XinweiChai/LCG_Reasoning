clc;clear;
[process, actions, initialState]=readBAN('data\\egfr104.an');
[inconc,dictInput,dictOutput]=parseTest('data\\run-egfr104-priority.out');
for i=inconc' 
    for j=find(i)'
        tempInitialState=initialState;
        tempInitialState(process(dictInput(j)))=1;
        for k=size(dictOutput,2)
            startNode=[process(dictOutput(k)), 1];
            [stateNodeArray, adjMatrix]=SLCG(tempInitialState, actions, startNode);
            
        end
    end
end
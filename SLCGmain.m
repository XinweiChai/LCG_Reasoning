clc;clear;
x=input('Input model in folder "data": ','s');
[process, actions, initialState,startState]=readBAN(['data\\',x]);
x=input('Input desired state, e.g. a=1, 0 for default option: ','s');
if ~strcmp(x,'0')
    temp=regexp(x,'=|\s','split');
    startState=[process(temp{1}),str2double(temp{2})];
end
[stateArray, adjMatrix,solNodeArray]=SLCG(initialState, actions, startState);
startNodeBool=startState(1)*2+startState(2)-1;
startNode=stateArray(startNodeBool);
[SCC,~] = tarjan(adjMatrix);
while size(SCC,2)~=size(adjMatrix,2)
    [Adj,stateArray]=breakCycle(adjMatrix,SCC,startNodeBool,stateArray,solNodeArray);
    [SCC,~] = tarjan(Adj);
end
stateArray=precondition(stateArray,initialState);
reachable=0;
for l=1:50
    stateArray=reconstruct(stateArray,startNode);
    andGates=solNodeArray(arrayfun(@(x) size(x.Next,2)>1,solNodeArray));
    andGateTree=gateTree(andGates,startNode);
    [reachable,sequence,finalState]=andReasoning(andGateTree,startNode,initialState);
    if reachable
        disp('reachable');
        return;
    end
end
disp('unreachable');
clc;clear;
numExamples=5;
res=zeros(1,numExamples);
for i=1:numExamples
    [process, actions, initialState,startState]=readBAN(['data\\LCG',num2str(i)]);
    [stateArray, adjMatrix,solNodeArray]=SLCG(initialState, actions, startState);
    startNode=stateArray(startState(1)*2+startState(2)-1);
    initialStateBool=zeros(size(initialState,2)*2,1);
    [SCC,~] = tarjan(adjMatrix);
    while size(SCC,2)~=size(adjMatrix,2)
        [Adj,stateArray]=breakCycle(adjMatrix,SCC,startState,stateArray);
        [SCC,~] = tarjan(Adj);
    end
    numStates=2*size(initialState,2);
    stateArray=precondition(stateArray,initialState);
    reachable=0;
    for l=1:50
        stateArray=reconstruct(stateArray,startNode);
        andGates=solNodeArray(arrayfun(@(x) size(x.Next,2)>1,solNodeArray));
        [andGateTree,root]=gateTree(andGates,startNode);
        [reachable,sequence,finalState]=andReasoning(andGateTree,startNode,initialState);
        if reachable
            break;
        end
    end
    
    res(i)=reachable;
end
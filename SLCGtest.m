clc;clear;
res=zeros(1,5);
for i=1:5
    [process, actions, initialState,startState]=readBAN(['data\\LCG',num2str(i)]);
    [stateNodeArray, adjMatrix,solNodeArray]=SLCG(initialState, actions, startState);
    startNode=stateNodeArray(startState(1)*2+startState(2)-1);
    initialStateBool=zeros(size(initialState,2)*2,1);
    [SCC,~] = tarjan(adjMatrix);
    while size(SCC,2)~=size(adjMatrix,2)
        [Adj,stateNodeArray]=breakCycle(adjMatrix,SCC,startState,stateNodeArray);
        [SCC,~] = tarjan(Adj);
    end
    numStates=2*size(initialState,2);
    adjMatrix=precondition(stateNodeArray,initialStateBool);
    reachable=0;
    bigGates=[];
    for l=1
        stateNodeArray=reconstruct(stateNodeArray,startNode);
        andGates=solNodeArray(arrayfun(@(x) isGate(x,initialState),solNodeArray));
        [andGateTree,root]=gateTree(andGates,startNode);
        [reachable,sequence,finalState]=andReasoning(stateNodeArray,andGateTree,startNode,initialState);
        if reachable
            break;
        end
    end
    
    res(i)=reachable;
end
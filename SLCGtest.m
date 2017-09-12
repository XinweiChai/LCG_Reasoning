clc;
[process, actions, initialState]=readBAN('data\\LCG1');
% [inconc,dictInput,dictOutput]=parseTest('data\\run-egfr104-priority.out');
result=zeros(size(inconc,1),size(dictOutput,1));
count=0;
for i=inconc'
    count=count+1;
    for j=find(i)'
        tempInitialState=initialState;
        tempInitialState(process(dictInput(j)))=1;
        for k=size(dictOutput,2)
            startState=[process(dictOutput(k)), 1];
            [stateNodeArray, adjMatrix,solNodeArray]=SLCG(tempInitialState, actions, startState);
            startNode=stateNodeArray(startState(1)*2+startState(2)-1);
            initialStateBool=zeros(size(initialState,2)*2,1);
            for l=1:size(initialState,2)
                initialStateBool(l*2+initialState(l)-1)=1;
            end
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
                andGates=solNodeArray(arrayfun(@(x) isGate(x,tempInitialState),solNodeArray));
                [andGateTree,root]=gateTree(andGates,startNode);
                [reachable,sequence,finalState]=andReasoning(stateNodeArray,andGateTree,startNode,tempInitialState);
                if reachable
                    break;
                end
            end
            
        end
    end
end
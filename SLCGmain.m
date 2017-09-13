clc;clear
[process, actions, initialState]=readBAN('data\\egfr104.an');
[inconc,dictInput,dictOutput]=parseTest('data\\run-egfr104-priority.out');
result=zeros(size(inconc,1),size(dictOutput,1));
count=0;
for i=inconc'
    tic
    count=count+1;
    for j=find(i)'
        tempInitialState=initialState;
        tempInitialState(process(dictInput(j)))=1;
        for k=1:size(dictOutput,1)
            startState=[process(dictOutput(k)), 1];
            [stateArray, adjMatrix,solArray]=SLCG(tempInitialState, actions, startState);
            startNode=stateArray(startState(1)*2+startState(2)-1);
            [SCC,~] = tarjan(adjMatrix);
            while size(SCC,2)~=size(adjMatrix,2)
                [Adj,stateArray]=breakCycle(adjMatrix,SCC,startState,stateArray);
                [SCC,~] = tarjan(Adj);
            end
            numStates=2*size(initialState,2);
            stateArray=precondition(stateArray,initialState);
            reachable=0;
            bigGates=[];
            for l=1:500
                stateArrayCopy=copy(stateArray);
                startNodeCopy=copy(startNode);
                [startNodeCopy,stateArrayCopy,solArray]=reconstruct(stateArrayCopy,startNodeCopy);
                andGates=solArray(arrayfun(@(x) size(x.Next,2)>1,solArray));
                [andGateTree,root]=gateTree(andGates,startNodeCopy);
                [reachable,sequence,finalState]=andReasoning(andGateTree,startNodeCopy,tempInitialState);
                if reachable
                    break;
                end
            end
            result(count,k)=reachable;
        end
    end
    toc
    count
    result(count,:)
end
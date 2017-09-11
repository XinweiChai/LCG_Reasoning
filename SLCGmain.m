clc;clear;
[process, actions, initialState]=readBAN('data\\egfr104.an');
[inconc,dictInput,dictOutput]=parseTest('data\\run-egfr104-priority.out');
result=zeros(size(inconc,1),size(dictOutput,1));
count=0;
for i=inconc'
    count=count+1;
    for j=find(i)'
        tempInitialState=initialState;
        tempInitialState(process(dictInput(j)))=1;
        for k=size(dictOutput,2)
            startNode=[process(dictOutput(k)), 1];
            [stateNodeArray, adjMatrix]=SLCG(tempInitialState, actions, startNode);
            initialStateBool=zeros(size(initialState,2)*2,1);
            for i=1:size(initialState,2)
                initialStateBool((i-1)*2+initialState(i)+1)=1;
            end
            [SCC,~] = tarjan(adjMatrix);
            while size(SCC,2)~=size(adjMatrix,2)
                [Adj,stateNodeArray]=breakCycle(adjMatrix,SCC,startNode,stateNodeArray);
                [SCC,~] = tarjan(Adj);
            end
            numStates=2*size(initialState,2);
            adjMatrix=precondition(stateNodeArray,initialStateBool);
            reachable=0;
            for i=1:500
                [newAdjList,adjMatrix]=reconstruct(adjList,startNode);%use nargin
                andGates=sols(sum(adjMat(sols,:)'~=0)>1);
                if ~isempty(sols(sum(adjMat(sols,:)'~=0)>10))
                    sols(sum(adjMat(sols,:)'~=0)>10);
                    disp('Big and gates detected, continue?');
                    pause;
                end
                andGateTree=gateTree(newAdjList,andGates,startNode);
                [reachable,sequence,finalState]=andReasoning(newAdjList,andGateTree,startNode,process, init_state,newLabels);
                if reachable
                    break;
                end
            end
            
        end
    end
end
clc;clear
% x=input('0 for TCR tests, 1 for egfr inconclusive tests: ');
data={'tcrsig94.an','egfr104test.an'};
out={'run-tcrsig94.out';'run-egfr104-priority.out'};
% [process, actions, initialState]=readBAN(['data\\',data{x+1}]);
% [tests,dictInput,dictOutput]=parseTest(['data\\',out{x+1}]);
[process, actions, initialState]=readBAN('data\\egfr104test.an');
[tests,dictInput,dictOutput]=parseTest('data\\run-egfr104-priority.out');
result=zeros(size(tests,1),size(dictOutput,1));
count=0;
for i=tests'
    tic
    count=count+1;
    tempInitialState=initialState;
    for j=find(i)'
        tempInitialState(process(dictInput(j)))=1;
    end
        for k=1:size(dictOutput,1)
            startState=[process(dictOutput(k)), 1];
            if k==12
                1;
            end
            [stateArray, adjMatrix,solArray]=SLCG(tempInitialState, actions, startState);
            startNode=stateArray(startState(1)*2+startState(2)-1);
            [SCC,~] = tarjan(adjMatrix);
            while size(SCC,2)~=size(adjMatrix,2)
                [Adj,stateArray]=breakCycle(adjMatrix,SCC,startState,stateArray);
                [SCC,~] = tarjan(Adj);
            end
            numStates=2*size(initialState,2);
            stateArray=precondition(stateArray,tempInitialState);
            reachable=0;
            for l=1:5
                [stateArray, adjMatrix,solArray]=SLCG(tempInitialState, actions, startState);
                [startNode,stateArray,solArray]=reconstruct(stateArray,startNode);
                andGates=solArray(arrayfun(@(x) size(x.Next,2)>1,solArray));
                andGateTree=gateTree(andGates,startNode);
                [reachable,sequence,finalState]=andReasoning(andGateTree,startNode,tempInitialState);
                if reachable
                    break;
                end
            end
            result(count,k)=reachable;
        end
    toc
end
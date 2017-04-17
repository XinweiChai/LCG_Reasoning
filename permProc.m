function [reachable,sequence,finalState]=permProc(andGate,adjList,andGateTree,reachable,sequence,finalState,startNode)
global newLabels process actions;
if size(andGateTree,2)==1
    [reachable,partialSequence,finalState]=simpleReasoning(adjList,newLabels,process,actions,finalState,startNode,[]);
    sequence=[sequence;partialSequence];
    return;
end
for i=perms(andGateTree{2,cell2mat(andGateTree(1,:))==andGate})%the root elememt of andGateTree
    for j=i' %traverse in one permutation
        if isempty(cell2mat(andGateTree(2,cell2mat(andGateTree(1,:))==j)))%check if there is a leaf AND gate
            cand=perms(adjList{1,j});
            for k=1:size(cand,1)
                for l=cand(k,:)
                    [partialReachable,partialSequence,finalState]=simpleReasoning(adjList,newLabels,process,actions,finalState,l,[]);
                    reachable=reachable*partialReachable;
                    if ~partialReachable
                        break;
                    end
                    sequence=[sequence;partialSequence];
                end
                 if reachable %if one perm works, no need to check other perms
                     pred=adjList{2,j};
                     pred=adjList{2,pred};%find the process
                     finalState{process(newLabels{1,pred}{1}),2}=newLabels{1,pred}{2};
                     break;
                 end
            end
            %andGateTree{2,andGateTree{3,j}}(andGateTree{2,andGateTree{3,j}}==j)=[];%delete the successor of its predecessor
        else
            [reachable,sequence,finalState]=permProc(j,adjList,andGateTree,reachable,sequence,finalState,startNode);
        end
    end
end
if reachable
    andGateTree(:,cell2mat(andGateTree(1,:))==andGate)=[];
    [reachable,sequence,finalState]=permProc(j,adjList,andGateTree,reachable,sequence,finalState,startNode);
end
end
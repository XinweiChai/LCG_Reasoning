function [reachable,sequence,state]=andReasoning(andGateTree,startNode,state)
reachable=0;
sequence=[];
if isempty(andGateTree)
    [reachable,sequence,state]=simpleReasoning(state,startNode);
    return;
end

while ~isempty(andGateTree)
    leaves=andGateTree(arrayfun(@(x) isempty(x.NextBranch),andGateTree));
    for i=leaves
        arrayfun(@(x) cutBranch(x,i),i.PrevBranch);
        andGateTree(arrayfun(@(x) isequal(x,i),andGateTree))=[];
        cand=perms(i.Next);
        for j=cand'
            copyState=state;
            reachable=1;
            cache=[];
            for k=j'
                [partialReachable,partialSequence,copyState]=simpleReasoning(copyState,k);
                reachable=reachable*partialReachable;
                if ~partialReachable
                    break;
                end
                cache=[cache,partialSequence];
                %                 sequence=[sequence;partialSequence];
            end
            if reachable %if one perm works, no need to check other perms
                sequence=[sequence,cache];
                state=copyState;
                %                 temp=adjList{2,andGateTree{1,i}};
                %                 forkNode=adjList{2,temp};
                if size(i.Prev,2)>1
                    1;
                end
                [~,partialSequence,state]=simpleReasoning(state,i.Prev);
                sequence=[sequence,partialSequence];
                break;
            end
        end
        if ~reachable
            sequence=[];
            return;
        end
    end
end
end
%{
function [reachable,sequence,init_state]=andReasoning(adjList,andGateTree,startNode,process, init_state,newLabels)
sequence=[];
if isempty(andGateTree)
    [reachable,sequence,init_state]=simpleReasoning(adjList,newLabels,process,init_state,startNode);
    return;
end
while ~isempty(andGateTree)
    leaves=find(cellfun(@isempty,andGateTree(2,:)));
    for i=leaves
        pred=andGateTree{3,i};
        pos=find(cell2mat(andGateTree(1,:))==pred);
        for j=pos
            andGateTree{2,j}(andGateTree{2,j}==andGateTree{1,i})=[];%delete predecessor
        end
        cand=perms(adjList{1,andGateTree{1,i}});%all the permutations
        for j=1:size(cand,1)
            reachable=1;
            for k=cand(j,:)
                [partialReachable,partialSequence,init_state]=simpleReasoning(adjList,newLabels,process,init_state,k);
                reachable=reachable*partialReachable;
                if ~partialReachable
                    break;
                end
                sequence=[sequence;partialSequence];
            end
            if reachable %if one perm works, no need to check other perms
                temp=adjList{2,andGateTree{1,i}};
                forkNode=adjList{2,temp};
                [~,partialSequence,init_state]=simpleReasoning(adjList,newLabels,process,init_state,forkNode);
                sequence=[sequence;partialSequence];
                break;
            end
        end
        if ~reachable
            sequence=[];
            return;
        end
    end
    
    andGateTree(:,leaves)=[];
end
reachable=1;
end
%}
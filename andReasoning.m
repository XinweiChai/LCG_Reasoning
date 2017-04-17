function [reachable,sequence,init_state]=andReasoning(adjList,andGateTree,startNode,process, init_state,newLabels)
sequence=[];
%unvisited= cell2mat(andGateTree(1,1:end-1));
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
                    [partialReachable,partialSequence,init_state]=simpleReasoning(adjList,newLabels,process,init_state,k,[]);
                    reachable=reachable*partialReachable;
                    if ~partialReachable
                        break;
                    end
                    sequence=[sequence;partialSequence];
                end
%                  if reachable %if one perm works, no need to check other perms
                    break;
%                  end
            end
            if ~reachable
                sequence=[];
                return;
            end
        end
        
        andGateTree(:,leaves)=[];


        %for i=perms(leaves)
        %    simpleReasoning(Adj,adjList,newLabels,process,actions,init_state,startNode)
        %end
    end
    reachable=1;
    [~,partialSequence,init_state]=simpleReasoning(adjList,newLabels,process,init_state,startNode,[]);
    sequence=[sequence;partialSequence];
end
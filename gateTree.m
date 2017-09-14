function gateTree=gateTree(gates,startNode)
if isempty(gates)
    gateTree=[];
    return;
end
root=startNode;
while ~ismember(root,gates)
    root=root.Next;
end
gateTree=root;
while ~isempty(root)
    for i=root
        for j=i.Next
            while ~ismember(j,gates) && hasNext(j)
                j=j.Next;
            end
            if hasNext(j)
                if ~ismember(j,i.NextBranch)
                    insertBranch(j,i);
                end
                root=[root,j];
                gateTree=[gateTree,j];
            end
        end
        root=root(2:end);
    end
end
gateTree=unique(gateTree);
% startNode=adjList{1,startNode};
% if isempty(startNode)
%     gateTree=[];
%     return;
% end
% startNode=adjList{1,startNode};
% if ismember(startNode,gates)
%     gateTree=[num2cell(gates);cell(2,size(gates,2))];
% else
%     gates=[gates,startNode];
%     gateTree=[num2cell(gates);cell(2,size(gates,2))];
% end
% for i=gates
%     if i~=startNode
%         pred=adjList{2,i};
%     else
%         continue;
%     end
%     while (~ismember(pred,gates))
%         pred=adjList{2,pred};
%     end
%     gateTree{3,gates==i}=[gateTree{2,gates==i},pred];%predecessors
%         gateTree{2,gates==pred}=[gateTree{2,gates==pred},i];%successors
% end
end
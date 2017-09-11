function [gateTree,root]=gateTree(gates,startNode)
if isempty(startNode.Next)
    gateTree=[];
    root=[];
    return;
end
root=startNode;
gateTree=root;
while ~ismember(root,gates)
        root=root.Next;
end

while ~isempty(root)
    while size(root.Next,2)<=1
        shortcut(root);
        gateTree=[gateTree,root];
    end
    root=root.NextBranch;
end

    
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
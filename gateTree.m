function gateTree=gateTree(adjList,gates,startNode)
startNode=adjList{1,startNode};
if isempty(startNode)
    gateTree=[];
    return;
end
startNode=adjList{1,startNode};
if ismember(startNode,gates)
    gateTree=[num2cell(gates);cell(2,size(gates,2))];
else
    gates=[gates,startNode];
    gateTree=[num2cell(gates);cell(2,size(gates,2))];
end
for i=gates
    %pred=Adj(find(Adj(:,i)~=0),i);
    %pred=find(Adj(:,i)~=0);
    if i~=startNode
        pred=adjList{2,i};
    else
        continue;
    end
    %temp=Adj(:,i);
    %pred=temp(temp~=0);
    while (~ismember(pred,gates))%&&(pred~=startNode)
        %temp=Adj(:,pred);
        %pred=temp(temp~=0);
        %             pred=find(Adj(:,pred)~=0);
        pred=adjList{2,pred};
        %pred=pred(1);
    end
    gateTree{3,gates==i}=[gateTree{2,gates==i},pred];%predecessors
    %if pred~=startNode
        gateTree{2,gates==pred}=[gateTree{2,gates==pred},i];%successors
    %else
    %    gateTree{2,end}=[gateTree{2,end},i];
    %end
end
end
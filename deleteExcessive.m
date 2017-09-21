function Adj=deleteExcessive(Adj,pred,startNode,stateNodeArray,solNodeArray)
while sum(Adj(pred,:)~=0)==0
    for i=1:2 %Delete processes and their preceding solution nodes
        temp=find(Adj(:,pred));
        Adj=deleteElement(Adj,pred,stateNodeArray,solNodeArray);
        pred=temp;
    end
    if find(Adj(:,pred))==startNode
        break;
    end
end
end
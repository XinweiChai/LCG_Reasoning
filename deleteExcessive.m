function Adj=deleteExcessive(Adj,pred,startNode)
while sum(Adj(pred,:)~=0)==0
    for i=1:3 %Delete objective, process and solution node
        temp=find(Adj(:,pred));
        Adj=deleteElement(Adj,pred);
        pred=temp;
    end
    if find(Adj(:,pred))==startNode
        break;
    end
end
end
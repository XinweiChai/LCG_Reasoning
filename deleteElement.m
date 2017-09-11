function Adj=deleteElement(Adj,toDelete,stateNodeArray)
    Adj(toDelete,:)=zeros(size(Adj,1),1);
    Adj(:,toDelete)=zeros(1,size(Adj,1));
    for i=toDelete
        delete(stateNodeArray(i))
    end
end
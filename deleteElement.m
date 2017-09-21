function Adj=deleteElement(Adj,toDelete,stateNodeArray,solNodeArray)
    Adj(toDelete,:)=zeros(size(Adj,1),1);
    Adj(:,toDelete)=zeros(1,size(Adj,1));
    for i=toDelete
        if i<=size(stateNodeArray,2)
            deleteNode(stateNodeArray(i));
        else
            deleteNode(solNodeArray(i-size(stateNodeArray,2)));
        end
    end
end
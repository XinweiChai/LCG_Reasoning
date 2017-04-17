function Adj=deleteElement(Adj,toDelete)
    Adj(toDelete,:)=zeros(size(Adj,1),1);
    Adj(:,toDelete)=zeros(1,size(Adj,1));
end
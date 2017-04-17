function list=adjList(Adj)
list=cell(2,size(Adj,1));
for i=1:size(Adj,1)
    list{1,i}=find(Adj(i,:)~=0);%successor
    list{2,i}=find(Adj(:,i)~=0)';%predecessor
end
end
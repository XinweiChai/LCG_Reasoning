function [newAdjList,adjMat,procs,objs,sols]=reconstruct(adjlist,startNode)
procs=[];
objs=[];
sols=[];
adjMat=zeros(size(adjlist,2));
current=startNode;
cnt=0;
visited=zeros(1,size(adjlist,2));
%visited(startNode)=1;
while ~isempty(current)
    current(visited(current)==1)=[];
    visited(current)=1;
    temp=current;
    current=adjlist(1,current);
    switch mod(cnt,3)
        case 0%proc
            procs=[procs,temp];
        case 1%obj
            objs=[objs,temp];
            for i=1:size(current,2)
                if size(current{i},2)>1
                    current{i}=current{i}(randi(size(current{i},2)));
                end
            end
        case 2%sol
            sols=[sols,temp];
    end
    for i=1:size(temp,2)
        adjMat(temp(i),current{i})=1;
    end
    current=cell2mat(current);
    current=unique(current);
    cnt=cnt+1;
end
conflict=find(sum(adjMat(1:end,:)~=0)>1);
for i=conflict
    pos=find(adjMat(:,i)'~=0);
    pos=pos(2:end);
    adjMat(pos,i)=0;
end
newAdjList=adjList(adjMat);
end
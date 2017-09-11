%reconstruct the LCG modification needed for SLCG
function [newAdjList,adjMat,procs,objs,sols]=reconstruct(adjlist,startNode)
procs=[];
objs=[];
sols=[];
adjMat=zeros(size(adjlist,2));
current=startNode;
cnt=0;
visited=zeros(1,size(adjlist,2));
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
conflict=find(sum(adjMat(1:end,:)~=0)>1);%solve the case where a state is required by multiple solutions
for i=conflict
    pos=find(adjMat(:,i)'~=0);
    pos=pos(2:end);
    adjMat(pos,i)=0;
    for j=pos %may be modified, delete excessive forks
        while sum(adjMat(pos,:)~=0)==0
            pred=find(adjMat(:,pos)~=0);
            adjMat(:,pos)=0;
            pos=pred;
        end
    end
end
newAdjList=adjList(adjMat);




end
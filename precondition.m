function adjList=precondition(adjList,objs)
%andGates=sols(sum(Adj(sols,:)'~=0)>1);
%noSolution=objs(sum(Adj(objs,:)'~=0)==0);%objects
noSolution=objs(cellfun(@isempty,adjList(1,objs)));
noSolution=noSolution(~cellfun(@isempty,adjList(2,noSolution)));
while ~isempty(noSolution)
    for i=noSolution'
        current=i;
        for j=1:2%procs and objs
            temp=current;
            current=cell2mat(adjList(2,current));
            adjList(2,temp)={[]};
            adjList(1,current)={[]};
        end
        %sols
        temp=current;
        current=cell2mat(adjList(2,current));
        adjList(2,temp)={[]};
        for j=current
            for k=temp
                adjList{1,j}(adjList{1,j}==k)=[];
            end
        end
    end
    noSolution=objs(cellfun(@isempty,adjList(1,objs)));
    noSolution=noSolution(~cellfun(@isempty,adjList(2,noSolution)));
end




% for i=noSolution'
%     cnt=0;
%     current=i;
%     temp=current;
%     while size(temp,2)>1||~isempty(adjList{2,temp})
%         %current(visited(current)==1)=[];
%         %visited(current)=1;
%         temp=current;
%         current=cell2mat(adjList(2,current));
%         adjList(2,temp)={[]};
%         switch mod(cnt,3)
%             case {0,1}  %procs and objs
%                 adjList(1,current)={[]};
%             case 2  %sols
%                 for j=current
%                     for k=temp
%                         adjList{1,j}(adjList{1,j}==k)=[];
%                     end
%                 end
%         end
%         cnt=cnt+1;
%     end
% end
end
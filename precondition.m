function adjList=precondition(adjList,objs)
noSolution=objs(cellfun(@isempty,adjList(1,objs)));%objects
noSolution=noSolution(~cellfun(@isempty,adjList(2,noSolution)));
while ~isempty(noSolution)%delete the branches without solution
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
end
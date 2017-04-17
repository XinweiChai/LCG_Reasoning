function [reachable,sequence,finalState]=orReasoning(adjList,andGates,orGateTree,startNode, init_state)
newAdjList=cell(size(adjList));
unvisited=1:size(adjList,2);
if size(orGateTree,2)<1
    %recalculate Adj, adjList, andGateTree, orGateTree, procs, objs, sols
else
    
    %while current has next, go next randomly, and delete other branches
    for i=1:1 %tentatives to be fixed
        choice=zeros(1,size(orGateTree,2));
        for j=1:size(orGateTree,2)
            temp=adjList{1,orGateTree{1,j}};%To be chosen
            choice(j)=temp(randi(size(temp,2)));
        end
        %random choice of forks
        current=startNode;
        queue=current;
        unvisited(unvisited==queue(1))=[];
        while ~isempty(queue)
%             if ismember(queue(1),cell2mat(orGateTree(1,:)))
            if ismember(queue(1),cell2mat(orGateTree(1,:)))
                pos=cell2mat(orGateTree(1,:))==queue(1);
                newAdjList{1,queue(1)}=choice(pos);
                newAdjList{2,choice(pos)}=queue(1);
                unvisited(unvisited==queue(1))=[];
                queue=[queue(2:end),choice(pos)];
            else
                newAdjList{1,queue(1)}=adjList{1,queue(1)};
                newAdjList(2,adjList{1,queue(1)})=num2cell(queue(1));
                unvisited(unvisited==queue(1))=[];
                queue=[queue(2:end),adjList{1,queue(1)}];
            end
            
        end
        newAndGates=andGates;
        newAndGates(ismember(newAndGates(1,:),unvisited))=[];
        newAndGateTree=gateTree(adjList,newAndGates,startNode);
        sequence=[];
        [reachable,sequence,finalState]=permProc(startNode,newAdjList,newAndGateTree,1,sequence,init_state,startNode);
    end
end
end
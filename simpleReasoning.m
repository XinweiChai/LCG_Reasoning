function [reachable,sequence,finalState]=simpleReasoning(adjList,newLabels,process,init_state,startNode,sequence)
reachable=0;
finalState=init_state;
current=startNode;
%succ=adjList{1,current};temp=newLabels{succ};
if inState(newLabels,current,process,init_state)
    %isequal(newLabels{current}{2},init_state{process(newLabels{current}{1}),2})%if already reached
    reachable=1;
    return;
end
%while ~isempty(Adj(current,Adj(current,:)~=0))

while ~isempty(adjList{1,current})
    temp=current;
    for i=1:3
%         newLabels{current}
        if isempty(current)
            reachable=0;
            return;
        end
        current=adjList{1,current};
    end
    sequence=[{newLabels(current),newLabels{temp}};sequence];%find corresponding action
    if inState(newLabels,current,process,init_state)
        reachable=1;
        for i=sequence(:,2)'
            finalState{process(i{1}{1}),2}=i{1}{2};%update of finalState
        end
        return;
    end
end
end
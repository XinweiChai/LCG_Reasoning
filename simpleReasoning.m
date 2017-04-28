function [reachable,sequence,finalState]=simpleReasoning(adjList,newLabels,process,init_state,startNode)
sequence=[];
reachable=0;
finalState=init_state;
current=startNode;
if inState(newLabels,current,process,init_state)%if already reached
    reachable=1;
    return;
end

while ~isempty(adjList{1,current})
    temp=current;
    for i=1:3
        if isempty(current)
            reachable=0;
            return;
        end
        current=adjList{1,current};
    end
    if isempty(current)
        return;
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
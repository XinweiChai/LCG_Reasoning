function bool=isFirable(currentState,action,process)
    bool=1;
    if currentState{process(action{2}),2}~=action{3}
        bool=0;
        return;
    end
    for i=1:size(action{1},1)
        if currentState{process(action{i}{1}),2}~=action{i}{2}
            bool=0;
            return;
        end
    end
end

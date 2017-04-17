function [state,modified]=transit(currentState,action,process)
    state=currentState;
    modified=0;
    if isFirable(currentState,action,process)
        state{process(action{2}),2}=action{4};
        modified=1;
    end
end
function bool=inState(newLabels,current,process,init_state)
bool=1;
for i=current
    if newLabels{1,i}{2}~=init_state{process(newLabels{i}{1}),2}
        bool=0;
        return;
    end
end
end
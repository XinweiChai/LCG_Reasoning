function initialNode=SLCG(initialState, actions, startNode)
%node=(type, name, state) e.g. initialState=(0,1,0) (stateNode, 1st sort, state 0)
%sol=(1,1) (solutionNode, 1st action) 0 stands for trivial solution
%Need a dictionary for names of sorts (finished)
%Need an array for actions
%action=({hitter(s), hitterState(s)}, target, targetState)
Ls=startNode;
LS=initialState;
initialNode=nlnode(initialState);
while ~isempty(Ls)
    for i=Ls
        if ismember(i,LS)
            continue;
        end
        Ls=Ls(2:end);
        curr=nlnode(i);
        if i==initialState
            tempSol=[1,0];
            temp=nlnode(tempSol);
            insertAfter(temp,curr);
        else
            act=findSol(i,actions);
            for j=act
                tempSol=nlnode(j);
                insertAfter(j,curr);
                for k=j{1}
                    tempSol.Next=k;
                end
                Ls=[Ls,k];
                LS=union(LS,ls);
            end
        end
    end
end
end
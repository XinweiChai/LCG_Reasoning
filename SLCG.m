function top=SLCG(initialState, actions, startNode)
%node=(type, name, state) e.g. initialState=[1,0] (1st sort, state 0)
%sol=1 ( 1st action) 0 stands for trivial solution
%Need a dictionary for names of sorts (finished)
%Need an array for actions
%action=({hitter(s), hitterState(s)}, target, targetState)
Ls=startNode;
targets=cell2mat(actions(:,[2,4]));%used to find solutions
LS=startNode;
top=dlnode(startNode);
while ~isempty(Ls)
    for i=Ls'
        if ismember(i',LS,'rows') && ~isequal(i',LS)
            continue;
        end
        LS=union(LS,Ls(1,:),'rows');
        Ls=Ls(2:end);
        curr=dlnode(i);
        if i(2)==initialState(i(1))
            tempSol=0;
            temp=nlnode(tempSol);
            insertAfter(temp,curr);
        else
            act=ismember(targets,i','rows');
            for j=actions(act,:)'
                nodej=dlnode(j);
                insertAfter(nodej,curr);
                for k=j{1}
                    nodek=dlnode(k);
                    insertAfter(nodek,nodej);
                end
                Ls=[Ls,k];
%                 LS=union(LS,ls);
            end
        end
    end
end
end
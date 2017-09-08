function stateNodeArray=SLCG(initialState, actions, startNode)
%node=(type, name, state) e.g. initialState=[1,0] (1st sort, state 0)
%sol=1 ( 1st action) 0 stands for trivial solution
%Need a dictionary for names of sorts (finished)
%Need an array for actions
%action=({hitter(s), hitterState(s)}, target, targetState)
%stateNodes list : stateNodeArray=[a_0,a_1...etc]
%actionNodes list: 
Ls=startNode;
targets=cell2mat(actions(:,[2,4]));%used to find solutions
LS=startNode;
top=dlnode(startNode);
stateNodeArray(1,size(initialState,2)*2)=dlnode();
solNodeArray(1,size(actions,1))=dlnode();
for i=1:size(initialState,2)*2
    stateNodeArray(i)=dlnode([floor((i+1)/2),mod(i+1,2)]);
end
for i=1:size(actions,1)
    solNodeArray(i)=dlnode(i);
end
while ~isempty(Ls)
    for i=Ls'
        if ismember(i',LS,'rows') && ~isequal(i',LS) %Need to fix the problem of the union with empty matrix
            Ls=Ls(2:end,:);
            continue;
        end
        LS=union(LS,i','rows');
        Ls=Ls(2:end,:);
        if i(2)==initialState(i(1))
            continue;
        else
        nodei=stateNodeArray((i(1)-1)*2+i(2)+1);

            act=ismember(targets,i','rows');
            for j=find(act)'%successive actions
                nodej=solNodeArray(j);
                insertAfter(nodej,nodei);
                for k=actions{j,1}'
                    nodek=stateNodeArray((k(1)-1)*2+k(2)+1);
                    insertAfter(nodek,nodej);
                    Ls=[Ls;k'];
                end
%                 LS=union(LS,ls);
            end
        end
    end
end
end
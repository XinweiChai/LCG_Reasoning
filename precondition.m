% function adjMatrix=precondition(adjMatrix,numStates,initialState)
%         noSolution=objs(cellfun(@isempty,adjList(1,objs)));%objects
%         noSolution=noSolution(~cellfun(@isempty,adjList(2,noSolution)));
%         while ~isempty(noSolution)%delete the branches without solution
%             for i=noSolution'
%                 current=i;
%                 for j=1:2%procs and objs
%                     temp=current;
%                     current=cell2mat(adjList(2,current));
%                     adjList(2,temp)={[]};
%                     adjList(1,current)={[]};
%                 end
%                 %sols
%                 temp=current;
%                 current=cell2mat(adjList(2,current));
%                 adjList(2,temp)={[]};
%                 for j=current
%                     for k=temp
%                         adjList{1,j}(adjList{1,j}==k)=[];
%                     end
%                 end
%             end
%             noSolution=objs(cellfun(@isempty,adjList(1,objs)));
%             noSolution=noSolution(~cellfun(@isempty,adjList(2,noSolution)));
%         end


% noSolution=~any(adjMatrix(1:numStates,size(adjMatrix,1)-numStates+1:end)');
% for i=1:size(initialState,2)
%     noSolution((i-1)*2+initialState(i)+1)=0;%except initial States
% end
% while isempty(find(noSolution, 1))
%     actionsToDelete=find(adjMatrix(:,noSolution));
%
%     adjMatrix(:,noSolution)=zeros(1,size(adjMatrix,1));
%
% end
function stateArray=precondition(stateArray,initialState)
ind=arrayfun(@(i) isempty(i.Next) && ~isempty(i.Prev)...
    && initialState(i.Data(1))~=i.Data(2),stateArray);
arrayfun(@(x) deleteNode(x.Prev),stateArray(ind));
arrayfun(@(x) deleteNode(x),stateArray(ind));
if any(ind)
    stateArray=precondition(stateArray,initialState);
end
end
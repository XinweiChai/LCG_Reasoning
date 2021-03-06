clc;clear;
x=input('0 for figures in the paper, 1 for EGFR example, 2 for multiReq test: ');
switch x
    case 0
        y=input('examples from 1-5: ');
        if isnumeric(y) && y==fix(y) && y>=1 && y<=5
            [process, actions, initialState,startNode]=readBAN(['data\\LCG',num2str(y)]);
            [Adj, labels] = dot_to_graph(['data\\LCG',num2str(y),'.dot']);
        else
            disp('invalid input');
            return;
        end
    case 1
        [process, actions, initialState,startNode]=readBAN('data\\egfr104.an');
        y=input('1 for ap1=1, 2 for pro_apoptotic=1: ');
        switch y
            case 1
                startNode='ap1_1';
                [Adj, labels] = dot_to_graph(['data\\ap1.dot']);
            case 2
                startNode='pro_apoptotic_1';
                [Adj, labels] = dot_to_graph(['data\\pro_apoptotic.dot']);
            otherwise
                disp('invalid input');
                return;
        end
    case 2
        [process, actions, initialState,startNode]=readBAN('data\\multiReq');
        [Adj, labels] = dot_to_graph('data\\multiReq.dot');
    otherwise
        disp('invalid input');
        return;
end
% startNode=regexp(startNode,'_\d','split');
% startNode=[process(startNode{1}),1];
[stateNodeArray, adjMatrix]=SLCG(initialState, actions, startNode);
initialStateBool=zeros(size(initialState,2)*2,1);
for i=1:size(initialState,2)
    initialStateBool(i*2+initialState(i)-1)=1;
end
[SCC,~] = tarjan(adjMatrix);
while size(SCC,2)~=size(adjMatrix,2)
    [Adj,stateNodeArray]=breakCycle(adjMatrix,SCC,startNode,stateNodeArray);
    [SCC,~] = tarjan(Adj);
end
numStates=2*size(initialState,2);
adjMatrix=precondition(stateNodeArray,initialStateBool);% Rewrite using nargin
reachable=0;
for i=1:500
    [newAdjList,adjMatrix]=reconstruct(adjList,startNode);%use nargin
    andGates=sols(sum(adjMat(sols,:)'~=0)>1);
    if ~isempty(sols(sum(adjMat(sols,:)'~=0)>10))
        sols(sum(adjMat(sols,:)'~=0)>10);
        disp('Big and gates detected, continue?');
        pause;
    end
    andGateTree=gateTree(newAdjList,andGates,startNode);
    [reachable,sequence,finalState]=andReasoning(newAdjList,andGateTree,startNode,process, init_state,newLabels);
    if reachable
        break;
    end
end
if reachable
    disp('reachable');
    disp(output(sequence));
else
    disp('unreachable');
end


% [SCC,~] = tarjan(Adj); %Adjacency matrix
% startNode=find(strcmp(labels, startNode));
% while size(SCC,2)~=size(Adj,2)
%     Adj=breakCycle(Adj,SCC,startNode);
%     [SCC,~] = tarjan(Adj);
% end
% [newLabels,procs,objs,sols]=parseName(labels);
% %%
% adjList=adjList(Adj);
% tic
% adjList=precondition(adjList,objs);
% reachable=0;
% for i=1:500
% [newAdjList,adjMat,procs,objs,sols]=reconstruct(adjList,startNode);
% andGates=sols(sum(adjMat(sols,:)'~=0)>1);
% if ~isempty(sols(sum(adjMat(sols,:)'~=0)>10))
%     sols(sum(adjMat(sols,:)'~=0)>10);
%     disp('Big and gates detected, continue?');
%     pause;
% end
% andGateTree=gateTree(newAdjList,andGates,startNode);
% [reachable,sequence,finalState]=andReasoning(newAdjList,andGateTree,startNode,process, init_state,newLabels);
% if reachable
%     break;
% end
% end
% if reachable
%     disp('reachable');
%     disp(output(sequence));
% else
%     disp('unreachable');
% end
% toc
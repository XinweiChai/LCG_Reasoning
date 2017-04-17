clc;clear;
%[process, actions, init_state]=readPH('PHex.ph');
% global process actions init_state labels newLabels;
% [process, actions, init_state]=readBAN('ANex');
[process, actions, init_state]=readBAN('LoopTest2');
%[process, actions, init_state]=readBAN('data\\egfr104.an');
% [Adj, labels] = dot_to_graph('scc.map');
%   [Adj, labels] = dot_to_graph('test.dot');
%  [Adj, labels] = dot_to_graph('test1.dot');
[Adj, labels] = dot_to_graph('LoopTest2.dot'); %Adj records the successors of each components
%[Adj, labels] = dot_to_graph('data\\ap1.dot');
[SCC,~] = tarjan(Adj);
startNode=1;
while size(SCC,2)~=size(Adj,2)
    Adj=breakCycle(Adj,SCC,startNode);
    [SCC,~] = tarjan(Adj);
end
[newLabels,procs,objs,sols]=parseName(labels);
% andGates=sols(sum(Adj(sols,:)'~=0)>1)';% Solutions with plural successors
% orGates=objs(sum(Adj(objs,:)'~=0)>1)'; % Objectives with plural successors
%% 
%bigAndGates=sols(sum(Adj(sols,:)'~=0)>5);
adjList=adjList(Adj);
adjList=precondition(adjList,objs);
reachable=0;
for i=1:500
[newAdjList,adjMat,procs,objs,sols]=reconstruct(adjList,startNode);
%orGates=objs(sum(adjMat(objs,:)'~=0)>1)'
andGates=sols(sum(adjMat(sols,:)'~=0)>1);
if ~isempty(sols(sum(adjMat(sols,:)'~=0)>10))
    sols(sum(adjMat(sols,:)'~=0)>10)%show big and gates
end
andGateTree=gateTree(newAdjList,andGates,startNode);
[reachable,sequence,finalState]=andReasoning(newAdjList,andGateTree,startNode,process, init_state,newLabels);
if reachable
    break;
end
end
output(sequence)
%[reachable,sequence,finalState]=permProc(startNode,newAdjList,andGateTree,1,sequence,init_state,startNode);
%[reachable,sequence]=andReasoning(Adj,andGateTree,startNode,process, actions, init_state);
%OrGate Reasoning
%[reachable,sequence,finalState]=orReasoning(Adj,adjList,andGates,andGateTree,orGateTree,startNode,process, actions, init_state);
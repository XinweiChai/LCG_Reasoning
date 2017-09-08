clc;clear
n1=dlnode(1);
n2=dlnode(2);
insertAfter(n2,n1);
n1=dlnode(3);
insertAfter(n1,n2);
a(1,10)=dlnode();

[process, actions, initialState,startNode]=readBAN('data\\LCG1');
stateNodeArray=SLCG(initialState, actions, startNode);

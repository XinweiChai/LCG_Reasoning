clc;clear
 n1=dlnode(1);
 n2=dlnode(2);
 insertAfter(n2,n1);
 n3=dlnode(3);
 insertAfter(n3,n2);
 array=[n1,n2,n3];
a=array(arrayfun(@(x) ~isempty(x.Next),array));
x=perms(array)
% a(1,10)=dlnode();
% 
% [process, actions, initialState,startNode]=readBAN('egfr104.an');
% stateNodeArray=SLCG(initialState, actions, startNode);
% a=[0 0 0 0;1 0 0 0;0 0 0 0];
% any(a')
% b=[0 0 0 0 0];
% nonzeros(b)
[res,resPos]=ismember(n2,array);
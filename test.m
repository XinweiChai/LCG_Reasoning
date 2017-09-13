clc;clear
 n1=dlnode(1);
 n2=dlnode(2);
 insertAfter(n2,n1);
 n3=dlnode(3);
 insertAfter(n3,n2);
 n4=dlnode(4);
 insertAfter(n4,n3);
 array1=[n1,n3];
 array2=[n2,n4];
 cut(n2,n2.Next);
% a(1,10)=dlnode();
% 
% [process, actions, initialState,startNode]=readBAN('egfr104.an');
% stateNodeArray=SLCG(initialState, actions, startNode);
% a=[0 0 0 0;1 0 0 0;0 0 0 0];
% any(a')
% b=[0 0 0 0 0];
% nonzeros(b)
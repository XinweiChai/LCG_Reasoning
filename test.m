 clc;clear
 n1=dlnode(1);
 n2=dlnode(2);
 insertAfter(n2,n1);
%  n3=dlnode(3);
%  insertAfter(n3,n1);
 n1copy=copy(n1);
 cut(n1copy,n1copy.Next);
 isequal(n1copy,n2.Prev)
 
%  for i=array
%      if i.Data==1
%          toConnect=i.Next(randi(size(i.Next,2)));
%          arrayfun(@(x) cut(i,x),i.Next);
%      end
%  end
%  array4=copy(array2);
%  cut(array3(1),array3(1).Next);
% % a(1,10)=dlnode();
% 
% a=[0 0 0 0;1 0 0 0;0 0 0 0];
% any(a')
% b=[0 0 0 0 0];
% nonzeros(b)
% n1=dlnode(1);
% a=[n1,n1];
% unique(a)

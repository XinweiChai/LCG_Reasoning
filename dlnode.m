classdef dlnode <  matlab.mixin.Copyable
    % dlnode A class to represent a doubly-linked list node.
    % Link multiple dlnode objects together to create linked lists.
    properties
        Data
    end
    properties(SetAccess = private)
        Next = dlnode.empty;
        Prev = dlnode.empty;
        NextBranch=dlnode.empty;
        PrevBranch=dlnode.empty;
    end
    
    methods
        function node = dlnode(Data)
            % Construct a dlnode object.
            if nargin > 0
                node.Data = Data;
            end
        end
        
        function insertAfter(newNode, nodeBefore)
            % Insert newNode after nodeBefore.
            %          if ~isempty(newNode.Prev)
            %             newNode.Prev.Next=dlnode.empty;
            %          end
            %          newNode.Next = nodeBefore.Next;
            newNode.Prev = [newNode.Prev,nodeBefore];
            %          if ~isempty(nodeBefore.Next)
            %             nodeBefore.Next.Prev = newNode;
            %          end
            nodeBefore.Next = [nodeBefore.Next,newNode];
        end
        
        function insertBranch(after,before)
            after.PrevBranch = before;
            before.NextBranch = [before.NextBranch,after];
        end
        function deleteNode(node)
            for i=node.Prev
                i.Next(arrayfun(@(x) isequal(x,node),i.Next))=[];
                break;
            end
            node.Next = dlnode.empty;
            node.Prev = dlnode.empty;
        end
        function cut(nodeBefore,nodeAfter)
            nodeBefore.Next(arrayfun(@(x) isequal(x,nodeAfter),nodeBefore.Next))=[];
            nodeAfter.Prev(arrayfun(@(x) isequal(x,nodeBefore),nodeAfter.Prev))=[];
        end
        function cutBranch(nodeBefore,nodeAfter)
            if isempty(nodeBefore) || isempty(nodeAfter)
                return;
            end
            nodeBefore.NextBranch(arrayfun(@(x) isequal(x,nodeAfter),nodeBefore.NextBranch))=[];
            nodeAfter.PrevBranch(arrayfun(@(x) isequal(x,nodeBefore),nodeAfter.PrevBranch))=[];
        end
        function shortcut(node)
            node.NextBranch=node.Next.Next;
            for i=node.NextBranch
                i.PrevBranch=node;
            end
        end
        function bool=hasNext(node)
            bool=~isempty(node.Next);
        end
        function bool=isGate(node,initialState)
%             count=0;
            for i=node.Next
                if i.Data(2)==initialState(i.Data(1))
                    cut(node,i);
%                     count=count+1;
                end
            end
            bool=size(node.Next,2)>1;
            if size(node.Next,2)>10
                disp('Big and gates detected, continue?');
                pause;
            end
        end
    end % methods
    
end % classdef



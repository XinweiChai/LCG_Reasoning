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
        
        function insertAfter(nodeAfter, nodeBefore)
            % Insert newNode after nodeBefore.
            %          if ~isempty(newNode.Prev)
            %             newNode.Prev.Next=dlnode.empty;
            %          end
            %          newNode.Next = nodeBefore.Next;
            nodeAfter.Prev = [nodeAfter.Prev,nodeBefore];
            %          if ~isempty(nodeBefore.Next)
            %             nodeBefore.Next.Prev = newNode;
            %          end
            nodeBefore.Next = [nodeBefore.Next,nodeAfter];
        end
        
        function insertBranch(after,before)
            after.PrevBranch = [after.PrevBranch,before];
            before.NextBranch = [before.NextBranch,after];
        end
        function deleteNode(node)
            for i=node
                for j=i.Prev
                    j.Next(arrayfun(@(x) isequal(x,i),j.Next))=[];
                    break;
                end
                for j=i.Next
                    j.Prev(arrayfun(@(x) isequal(x,i),j.Prev))=[];
                    break;
                end
                i.Next = dlnode.empty;
                i.Prev = dlnode.empty;
            end
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
%         function setNext(node,next)
%             node.Next=next;
%         end
    end % methods
    
end % classdef



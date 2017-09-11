classdef dlnode < handle
    % dlnode A class to represent a doubly-linked list node.
    % Link multiple dlnode objects together to create linked lists.
    properties
        Data
    end
    properties(SetAccess = private)
        Next = dlnode.empty;
        Prev = dlnode.empty;
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
        function deleteNode(node)
            for i=node.Prev
                for j=i.Next
                    if isequal(j,node)
                        j=dlnode.empty;
                        break;
                    end
                end
            end
            node.Next = dlnode.empty;
            node.Prev = dlnode.empty;
        end
        
    end % methods
    
end % classdef



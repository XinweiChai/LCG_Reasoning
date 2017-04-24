function Adj=breakCycle(Adj,SCC,startNode)
     for i=1:size(SCC,2)
         if size(SCC{i},2)==1
             break;
         end
%         SCC{i}==startNode)
        for j=SCC{i}
            if j==startNode
                toDelete=fliplr(find(Adj(:,j))')';
                pred=find(Adj(:,toDelete));
                Adj=deleteElement(Adj,toDelete);
                Adj=deleteExcessive(Adj,pred,startNode);
%                 while sum(Adj(temp(end),:)==0)
%                     deleteElement(Adj,temp(end));
%                 end
                %Adj(:,j)=zeros(1,size(Adj,1));
            else   % second case of breaking the cycle: with exterior link
                pred=find(Adj(:,j));  
                extLink=find(ismember(pred,SCC{i})==0);
                if ~isempty(extLink)
                    toDelete=fliplr(pred')';
                    toDelete(toDelete==pred(extLink))=[];
                    predofDelete=find(Adj(:,toDelete));
                    Adj=deleteElement(Adj,toDelete);
                    Adj(:,j)=zeros(1,size(Adj,1));
                    Adj(pred(extLink),j)=1; %keep the exterior link undeleted
                    Adj=deleteExcessive(Adj,predofDelete,startNode);
                end
            end
        end
    end
end
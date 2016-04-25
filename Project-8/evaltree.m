function [ypredict]=evaltree(T,xTe)
% function [ypredict]=evaltree(T,xTe);
%
% input:
% T0  | tree structure
% xTe | Test data (dxn matrix)
%
% output:
%
% ypredict : predictions of labels for xTe
%

%% Rows of matrix T represents:
%     prediction at this node
%     index of feature to cut
%     cutoff value c (<=c : left, and >c : right)
%     index of left subtree (0 = leaf)
%     index of right subtree (0 = leaf)
%     parent (0 = root)
[~, q] = size(T); %q: total number of nodes
[~,n] = size(xTe);
ypredict = zeros(1,n);
 

for i = 1:n %classify one observation at a time
    node = 1; %starts at root
    while node < q;
        if T(4,node)==0 && T(5,node)==0 %if the node is a leaf (no sub-trees)
            break; % then break the while loop
        end;
        %[L, R] = find(T(6,:)==node); 
        %find matrix indices of child nodes
       
        if xTe(T(2,node), i) <= T(3,node) %if classify to left
            node =T(4,node);
        else
            node = T(5,node);
        end;
    end;
    ypredict(1,i) = T(1, node); % the predicted y is the predication at final node
end;

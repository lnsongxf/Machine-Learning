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
[d,n] = size(xTe);
ypredict = zeros(n,1);
 
node = 0; %starts at root
for i = 1:n %classify one observation at a time
    while node <= q;
        if isempty(T(6,:)==node) %if the node is a leaf (no sub-trees)
            break; % then break the while loop
        end;
        [L, R] = find(T(6,:)==node); %find matrix indices of child nodes
       
        if xTe(T(2,node+1), i) <= T(3,node+1) %if classify to left
            node = L-1;
        else
            node = R-1;
        end;
    end;
    ypredict(i,1) = T(1, node+1); % the predicted y is the predication at final node
end;


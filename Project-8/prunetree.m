function T=prunetree(T,xTe,y)
% function T=prunetree(T,xTe,y)
%
% Prunes a tree to minimal size such that performance on data xTe,y does not
% suffer.
%
% Input:
% T = tree
% xTe = validation data x (dxn matrix)
% y = labels (1xn matrix)
%
% Output:
% T = pruned tree
%

parent = unique(T(6,:));
[num_parent,~] = size(parent);

for i = 1: num_parent
    p = parent(num_parent+1-i,1); % prune from bottom 
    index = T(6,:)~= p; % find index of nodes that are not children of node p
    T_ = T(:,index); % T_ is the tree that excludes the two nodes having p as parent node
    [ypredict]=evaltree(T,xTe);
    error = (y-ypredict)*(y-ypredict)';
    [ypredict_]=evaltree(T_,xTe);
    error_ = (y-ypredict_)*(y-ypredict_)';
    if error_<= error %if pruned tree has smaller testing error
        T = T_; % then trim the original tree
    end;
end;


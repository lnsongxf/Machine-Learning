function preds=evalforest(F,xTe)
% function preds=evalforest(F,xTe);
%
% Evaluates a random forest on a test set xTe.
%
% input:
% F   | Forest of decision trees
% xTe | matrix of m input vectors (matrix size dxm)
%
% output:
%
% preds | predictions of labels for xTe

[d, m] = size(xTe);
[~, nt] = size(F);
preds = zeros(1,m);
for t = 1:nt
    T = F{1,t};
    [ypredict]=evaltree(T,xTe); 
    preds = preds + ypredict;
end;
preds = preds/nt; % average over all prediction results

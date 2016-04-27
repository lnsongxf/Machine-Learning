function preds=evalboost(BDT,xTe)
% function preds=evalboost(BDT,xTe);
%
% Evaluates a boosted decision tree on a test set xTe.
%
% input:
% BDT | Boosted Decision Trees
% xTe | matrix of m input vectors (matrix size dxm)
%
% output:
%
% preds | predictions of labels for xTe
%

preds = 0;
total_weight= 0;
for i = 1:size(BDT,2)
    preds = preds+  BDT{1,i}*evaltree(BDT{2,i}, xTe);
    total_weight = total_weight + BDT{1,i};
end;
preds = preds/total_weight;

for i = 1: size(preds, 2)
   if preds(1,i) >= 1.45
       preds(1,i) = 2;
   else;
       preds(1,i) = 1;
   end;
end

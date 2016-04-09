function [svmclassify,sv_i,alphas]=trainsvm(xTr,yTr, C,ktype,kpar);
% function [svmclassify,sv_i,alphas]=trainsvm(xTr,yTr, C,ktype,kpar);
% INPUT:	
% xTr : dxn input vectors
% yTr : 1xn input labels
% C   : regularization constant (in front of loss)
% ktype : (linear, rbf, polynomial)
% 
% Output:
% svmclassify : a classifier (scmclassify(xTe) returns the predictions on xTe)
% sv_i : indices of support vecdtors
% alphas : a nx1 vector of alpha values
%
% Trains an SVM classifier with kernel (ktype) and parameters (C,kpar)
% on the data set (xTr,yTr)
%

if nargin<5,kpar=1;end;

disp('Generating Kernel ...')
K = computeK(ktype, xTr, xTr, kpar);

[H,q,Aeq,beq,lb,ub]=generateQP(K,yTr,C);
alpha0 = zeros(size(q));

disp('Solving QP ...')
alphas = quadprog(H, q,  Aeq.*0, beq.*0 ,Aeq,beq,lb, ub);

disp('Recovering bias')
bias =recoverBias(K,yTr,alphas,C);

disp('Extracting support vectors ...')
sv_i = alphas~=0 ; 

disp('Creating classifier ...')
%K: nxm
%xTr: dxn
%x: dxm
%output predictions (1×m)
svmclassify = @(x) (alphas'.*yTr*computeK(ktype, xTr, x, kpar) + bias)';

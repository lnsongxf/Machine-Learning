function bias=recoverBias(K,yTr,alphas,C);
% function bias=recoverBias(K,yTr,alphas,C);
%
% INPUT:	
% K : nxn kernel matrix
% yTr : 1xn input labels
% alphas  : nx1 vector or alpha values
% C : regularization constant
% 
% Output:
% bias : the hyperplane bias of the kernel SVM specified by alphas
%
% Solves for the hyperplane bias term, which is uniquely specified by the support vectors with alpha values
% 0<alpha<C
%
n = size(yTr(:),1);
yTr =reshape(yTr, 1, n);

a = alphas-C/2;
a = sort(a);
I = find((a>-C/2)&(a < C/2));
bias = yTr(1,I(1,1))-alphas'.*yTr*K(:,I(1,1)) ; %scalar

function [loss,gradient]=logistic(w,xTr,yTr,lambda)
% function w=logistic(w,xTr,yTr)
%
% INPUT:
% xTr dxn matrix (each column is an input vector)
% yTr 1xn matrix (each entry is a label)
% w weight vector (default w=0)
%
% OUTPUTS:
% 
% loss = the total loss obtained with w on xTr and yTr
% gradient = the gradient at w
%
if nargin<4,lambda=0.012;end;
[d,n]=size(xTr);
%loss = sum(log(1+exp(-yTr.*(w'*xTr))));
%gradient = -(yTr./(exp(yTr.*(w'*xTr))+1))*xTr'; %%

z = w'*xTr; %1xn
[a,b] = size(z) ;
g=zeros(a,b);
for i = 1:a;
    for j = 1: b;
        g(i,j) = 1/(1+exp(-z(i,j)));
    end
end

yTr2 = yTr;
id = yTr == -1;
yTr2(id) = 0;

%loss= (1/n)*sum(-yTr2.*log(g)-(1-yTr2).*log(1-g))  ;

%gradient =  (1/n)*xTr*(g- yTr2)' ;
loss= (1/n)*sum(-yTr2.*log(g)-(1-yTr2).*log(1-g))+lambda*w'*w;  

gradient = (1/n)*xTr*(g- yTr2)'+ 2*lambda*w;

% loss = (1/n)*sum(log(1+exp(-yTr.*(w'*xTr))));
% gradient = (1/n)*xTr*(-yTr./(1+exp(-yTr.*(w'*xTr))))';
% gradient = -(1/n)*xTr*yTr./(1+exp(-yTr.*(w'*xTr))

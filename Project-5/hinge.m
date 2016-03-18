function [loss,gradient]=hinge(w,xTr,yTr,lambda)
% function w=ridge(xTr,yTr,lambda)
%
% INPUT:
% xTr dxn matrix (each column is an input vector)
% yTr 1xn matrix (each entry is a label)
% lambda regression constant
% w weight vector (default w=0)
%
% OUTPUTS:
%
% loss = the total loss obtained with w on xTr and yTr
% gradient = the gradient at w
%

[d,n]=size(xTr);
loss = (1/n)*sum(max([1-yTr.*(w'*xTr);zeros(size(yTr))],[],1)) +lambda*w'*w;
id = yTr.*(w'*xTr) <=1; %1xn
gradient = -(1/n)*xTr*(yTr.*id)' + 2*lambda*w; %d*1


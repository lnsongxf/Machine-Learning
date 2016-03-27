function ybar=computeybar(xTe)
% function [ybar]=ybar(xTe);
% 
% computes the expected label 'ybar' for a set of inputs x
% generated from two standard Normal distributions (one offset by OFFSET in
% both dimensions.)
%
% INPUT:
% xTe | a 2xn matrix of column input vectors
% 
% OUTPUT:
% ybar | a 1xn vector of the expected label ybare(x)
%

global OFFSET;

[~,n]=size(xTe);
ybar=zeros(1,n);

% Feel free to use the following function to compute p(x|y)
%returns the pdf of the normal distribution
%normpdf=@(x,mu,sigma)   exp(-0.5 * ((x - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
normpdf=@(x,mu,sigma)  exp(-0.5*((x - mu)'*sigma*(x - mu)))/(2*pi*sqrt(det(sigma)));

px1 = zeros(1,n);
px2 = zeros(1,n);
%Pr(x|y = 1)
for i = 1:n; 
    px1(1,i) = normpdf(xTe(:,i),[0;0],eye(2)); %1xn
end;

%Pr(x|y = 2)
for i = 1:n;
    px2(1,i) = normpdf(xTe(:,i),[OFFSET;OFFSET],eye(2)); %1xn
end;

%Pr(y=1|x)
py1 = px1./(px1+px2);%1xn
%Pr(y=2|x)
py2 = px2./(px1+px2);

ybar = 1*py1 + 2*py2;

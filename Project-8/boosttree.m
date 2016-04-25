function BDT=boosttree(x,y,nt,maxdepth)
% function BDT=boosttree(x,y,nt,maxdepth)
%
% Learns a boosted decision tree on data x with labels y.
% It performs at most nt boosting iterations. Each decision tree has maximum depth "maxdepth".
%
% INPUT:
% x  | input vectors dxn
% y  | input labels 1xn
% nt | number of trees (default = 100)
% maxdepth | depth of each tree (default = 3)
%
% OUTPUT:
% BDT | Boosted DTree


if nargin<3
    maxdepth = 3; 
    nt = 100;
end;
if nargin<4
    maxdepth = 3; 
end;
[d,n] = size(x);
H = @(xTe) 0; %initialize classifier
w = ones(1,n)/n; % initialize weights

%AdaBoost
for t = 1:nt
    %find the best weak learner for current weighting
    T = id3tree(x,y,maxdepth, w); 
    h = @(xTe)evaltree(T,xTe);
    
    epsilon = w*(h(x)~=y)';
    if epsilon > 1/2,
        break;
    end;
    alpha = log((1-epsilon)/epsilon)/2; %the best stepsize alpha
    H = @(xTe) (H(xTe) + alpha*evaltree(T,xTe));
    w = w.*exp(-alpha*h(x).*y)/(2*sqrt(epsilon*(1-epsilon)));
end;
BDT = H; % BDT is size 1xn



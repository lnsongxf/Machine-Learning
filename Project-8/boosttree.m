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
%H = @(xTe) 0; %initialize classifier
w = ones(1,n)/n; % initialize weights

%AdaBoost
BDT = cell(2,nt);
for t = 1:nt
    %find the best weak learner for current weighting
    T = id3tree(x,y,maxdepth, w); 
    h = evaltree(T,x);
    %since y = 1, 2, rescale it to -1, 1
    h = (h-1.5).*2; 
    y = (y-1.5).*2;
    epsilon = w*(h~=y)';
    if epsilon > 1/2,
        break;
    end;
    alpha = log((1-epsilon)/epsilon)/2; %the best stepsize alpha
    %store the output in a cell array, where the first row is alpha, second
    %row is a tree
    BDT{1,t} = alpha;
    BDT{2,t} = T;
    w = w.*exp(-alpha*h.*y)/(2*sqrt(epsilon*(1-epsilon)));
    y = .5.*y + 1.5;
end;



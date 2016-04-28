function T=id3tree(xTr,yTr,maxdepth,weights)
% function T=id3tree(xTr,yTr,maxdepth,weights)
%
% The maximum tree depth is defined by "maxdepth" (maxdepth=2 means one split). 
% Each example can be weighted with "weights". 
%
% Builds an id3 tree
%
% Input:
% xTr | dxn input matrix with n column-vectors of dimensionality d
% xTe | dxm input matrix with n column-vectors of dimensionality d
% maxdepth = maximum tree depth
% weights = 1xn vector where weights(i) is the weight of example i
% 
% Output:
% T = decision tree 
[~,n] = size(xTr);

if nargin==3,
    q = 1+ (maxdepth-1)*maxdepth;
    weights=ones(1,n)/n;
elseif nargin==2
    maxdepth = inf;
    weights=ones(1,n)/n;
    %set the maximum number of nodes as every leaf has only 1 observation
    q = (1+n)*n/2;
else %nargin = 4
    q = 1+ (maxdepth-1)*maxdepth;
end

S = cell(2,q); 
T = zeros(6,q);
next_node = 2; %index of next subtree
%store the remaining data at each node in cell array S
S{1,1} = xTr; 
S{2,1} = yTr;

for i = 1:q
    %the condition takes place when nextnode does not increase because if
    %it does, it will exceed the allowed dimension of T
    if i==next_node
        T(:,i:end) = [];
        break;
    end
    x = S{1,i};
    y = S{2,i};
    [feature,cut,~] = entropysplit(x,y,weights);
    T(1,i) = mode(y);
    %no more subtrees if no better split found or if the node only has one
    %data point
    if ~(feature==0 || size(x,2)==1)
        T(2:4,i) = [feature;cut;next_node];
        S{1, next_node} = x(:,find(x(feature,:)<=cut));%left
        S{2, next_node} = y(:,find(x(feature,:)<=cut));%left
        T(6,next_node) = i;
        T(5,i) = next_node +1;
        S{1, next_node+1} = x(:,find(x(feature,:)>cut));%right
        S{2, next_node+1} = y(:,find(x(feature,:)>cut));%right
        T(6,next_node+1) = i;
     %if further split would exceed the maximum number of nodes allowed, set the index of left & right subtrees to zero
     %otherwise, move on the the next node
        if next_node+2>q
            T(4:5,i)=0;
        else
            next_node = next_node+2;
        end
    end

end     
%the if condition is needed, otherwise, the dimension of T may exceed 
%that allowed by maxdepth since we have T(6,next_node) = i in the for loop
if size(T,2)> q
    T(:, q+1:end) = [];
end;

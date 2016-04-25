function F=forest(x,y,nt)
% function F=forest(x,y,nt)
%
% INPUT:
% x | input vectors dxn
% y | input labels 1xn
% nt | number of samples

% OUTPUT:
% F | Forest (The output format should be an array of id3trees.)
%

F = cell(1,nt);
[~,n] = size(x);
for t = 1:nt
    s = randsample(n, n,true);
    X = x(:,s); % X is the sample training data;
     Y = y(:,s);
    T = id3tree(X,Y);
    T = prunetree(T,x,y) ;
    F{1, t} = T; %add the tree to a cell array
end;

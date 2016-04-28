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
    xTr = x(:,s); % xTr is the sample training data;
    yTr = y(1,s);
    T = id3tree(xTr,yTr);
    C = setxor(1:n,s);
    xTe = x(:,C);
    yTe = y(1,C);
    T = prunetree(T,xTe,yTe) ;
    F{1, t} = T; %add the tree to a cell array
end;

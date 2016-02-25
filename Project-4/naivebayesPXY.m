function [posprob,negprob] = naivebayesPXY(x,y)
% function [posprob,negprob] = naivebayesPXY(x,y);
% Computation of P(X|Y)
% Input:
% x : n input vectors of d dimensions (dxn)
% y : n labels (-1 or +1) (1xn)
% Output:
% posprob: probability vector of p(x|y=1) (dx1)
% negprob: probability vector of p(x|y=-1) (dx1)

% add one all-ones positive and negative example
[d,n]=size(x);
%x=[x ones(d,2)];
%y=[y -1 1];

[d,n] = size(x);

% Use a multinomial distribution as model
id = y==1;
posprob = zeros(d,1);
negprob = zeros(d,1);
for a = 1:d
    posprob(a,1) = sum(x(a,id))/sum(sum(x(:,id))); %sum(): the sum over each column
    %sum(x): row vector with the length of each example (1xn)
    negprob(a,1) = sum(x(a,~id))/sum(sum(x(:,~id)));
end;




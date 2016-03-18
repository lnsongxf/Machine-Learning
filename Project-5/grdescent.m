function [w]=grdescent(func,w0,stepsize,maxiter,tolerance)
% function [w]=grdescent(func,w0,stepsize,maxiter,tolerance)
%
% INPUT:
% func function to minimize
% w0 = initial weight vector 
% stepsize = initial gradient descent stepsize 
% tolerance = if norm(gradient)<tolerance, it quits
%
% OUTPUTS:
% 
% w = final weight vector
%

if nargin<5,tolerance=1e-02;end;
iter = 0;
gradient =ones(size(w0));
loss0 = 0;
w = w0;

while iter <=maxiter && norm(gradient)>tolerance;
    
    [loss,gradient]=func(w0);
    w = w0 -stepsize*gradient;
    iter = iter +1;
    w0 = w;
    if loss<loss0;
        stepsize = 1.01*stepsize;
    else
        stepsize = 0.5*stepsize;
    end;
    loss0 = loss;

end;



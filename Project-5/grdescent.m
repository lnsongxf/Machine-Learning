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
gradient_init = gradient;
loss_init= 0;
w = w0;

while iter <=maxiter && norm(gradient)>tolerance;
    
    [loss,gradient]=func(w0);
    w = w0 -stepsize*gradient;
    iter = iter +1;
    
    %stepsize = 0.5*stepsize;
    if loss<loss_init;
        stepsize = 1.01*stepsize;
    else
        stepsize = 0.5*stepsize;
    end;
    if  iter >maxiter || norm(gradient)<=tolerance;
        if loss > loss_init;
            loss = loss_init;
            gradient = gradient_init
        end;
    end;
   
    w0 = w;       
    loss_init = loss;
    gradient_init = gradient;
        

end;


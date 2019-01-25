close all;
clear all;
clc;

MAXITER=100

for k = 1:MAXITER
    disp('a')
end

function [result]=loss(f,u,lambda)
    first=sum((f-u).^2,'all')
    second=sum(sqrt(Dxt(u).^2+Dyt(u).^2),'all')
    result=lambda*first+second
end




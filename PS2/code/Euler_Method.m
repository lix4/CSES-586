clear all;
close all;
clc;

STEP_SIZE=[0.1,0.05,0.01,0.005,0.001];
t=[1,2,3,4,5];

for k = 1:size(t,2)
    for d =1:size(STEP_SIZE,2)
        t_n=0;
        y_n=1;
        current_ss=STEP_SIZE(d);
        for i=1:(t(k)/STEP_SIZE(d))
            y_n=y_n+current_ss*derivative(t_n,y_n);
            t_n=t_n+current_ss;
        end
        fprintf("Euler:: t:%f, y:%f, step_size:%i\n",t_n,y_n,current_ss);
        fprintf("Original:: t:%f, y:%f\n",t_n, original(t(k)));
    end
    fprintf("################################################\n");
end


function result=derivative(t,y)
    result=-2*y+2-exp(-4*t);
end

function result=original(t)
    result=-1/(2*exp(2*t))+1/(2*exp(4*t))+1;
end
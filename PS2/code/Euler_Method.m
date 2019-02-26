clear all;
close all;
clc;

STEP_SIZE=[0.1,0.05,0.01,0.005,0.001,1];
t=[0,1,2,3,4,5];
% part (b) step size = 0.1
e_y=[1];
o_y=[1];
for k=2:size(t,2)
    [a,b]=Euler(0.1,t(k));
    e_y=[e_y,b(end)];
    o_y=[o_y,original(t(k))];
end

figure(1)
plot(t,o_y,'r*',t,e_y,'b*')
legend('original',"euler's method")


% part (c)
[t_o,y_o]=fplot(@original,[0,5]);
[t_1,y_1]=Euler(0.1,5);
[t_2,y_2]=Euler(0.05,5);
[t_3,y_3]=Euler(0.01,5);
[t_4,y_4]=Euler(0.005,5);
[t_5,y_5]=Euler(0.001,5);
figure(2)
plot(t_o,y_o,'k',t_1,y_1,'r',t_2,y_2,'b',t_3,y_3,'y',t_4,y_4,'g',t_5,y_5,'m');
legend('original','t=0.1','t=0.05','t=0.01','t=0.005','t=0.001');

% for k = 1:size(t,2)
%     for d =1:size(STEP_SIZE,2)
%         t_n=0;
%         y_n=1;
%         current_ss=STEP_SIZE(d);
%         for i=1:(t(k)/STEP_SIZE(d))
%             y_n=y_n+current_ss*derivative(t_n,y_n);
%             t_n=t_n+current_ss;
%         end
%         fprintf("Euler:: t:%f, y:%f, step_size:%i\n",t_n,y_n,current_ss);
%         fprintf("Original:: t:%f, y:%f\n",t_n, original(t(k)));
%     end
%     fprintf("######################################################\n");
% end

function [t_r,y_r]=Euler(ss,t)
    t_n=0;
    y_n=1;
    t_r=[t_n];
    y_r=[y_n];
    for i=1:(t/ss)
        y_n=y_n+ss*derivative(t_n,y_n);
        t_n=t_n+ss;
        t_r=[t_r,t_n];
        y_r=[y_r,y_n];
    end
%     fprintf("Euler:: t:%f, y:%f, step_size:%i\n",t_n,y_n,current_ss);
%     fprintf("Original:: t:%f, y:%f\n",t_n, original(t(k)));
end

function result=derivative(t,y)
    result=-2*y+2-exp(-4*t);
end

function result=original(t)
    result=-1/(2*exp(2*t))+1/(2*exp(4*t))+1;
end
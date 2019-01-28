close all;
clear all;
clc;

% global variables
MAXITER=10;
loss_arr=zeros(1,MAXITER);
lr=0.001;
lambda=0.5;

I = imread('cameraman.tif');
f = imnoise(I,'gaussian', 0, 0.3);
% imshow(I_noise);
% f=imread('../lenaNoise.png');
f=double(f);
f=normalize(f);

u=double(repmat(0,256,256));
figure(1)
imshow(u)
title('original')

disp('----------------------------------')
for k = 1:MAXITER
    u=u-lr*cal_gradient(lambda,u,f);
    loss_arr(k)=cal_loss(f,u,lambda);
end

u=uint8(normalize(u).*255);
figure(3)
imshow(u)
title('denoised')
imwrite(u,'denoised_img.png')
figure(4)
plot(loss_arr)

% normalize a image to 0-1
function [normalized]=normalize(img)
norm_temp=img-min(img(:));
normalized = norm_temp./(max(img(:))-min(img(:)));
end

function [norm]=l1norm(img)
    norm=sum(sum(abs(img)));
end

function [norm]=l2norm(img)
    norm=sqrt(sum(sum(img.^2)));
end

function [result]=cal_loss(f,u,lambda)
    first=l2norm(f-u)^2;
    grad_u=sqrt(Dx(u).^2+Dy(u).^2);
    second=l1norm(grad_u);
    result=lambda*first+second;
end

function [grad]=cal_gradient(lambda,u,f)
first=-lambda*(f-u);
grad_u_m=sqrt(Dx(u).^2+Dy(u).^2);
grad_u_m=sqrt(dot(grad_u_m,grad_u_m));
div_u=Dx(Dx(u))+Dy(Dy(u));
second=div_u./(grad_u_m+0.00000001);
grad=first-second;
end




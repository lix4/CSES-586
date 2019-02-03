close all;
clear all;
clc;

% global variables
MAXITER=200;
loss_arr=zeros(1,MAXITER);
lr=0.1;
lambda=0.13;

% % cameraman
% I = imread('cameraman.tif');
% f = imnoise(I,'gaussian', 0, 0.3);
% lenanoise
f=imread('../lenaNoise.png');


f=double(f);
f=normalize(f);
u=f;


% optimizing
for k = 1:MAXITER
    grad_u_m=sqrt(Dxc(u).^2+Dyc(u).^2);
    div_u=Dxc(Dxc(u))+Dyc(Dyc(u));
    grad=-lambda*(f-u)-div_u./(grad_u_m+0.5);
    u=u-lr*grad;
    loss_arr(k)=cal_loss(f,u,lambda);
end


u=uint8(normalize(u)*255);
figure(3)
imshow(u)
title('denoised')
imwrite(u,'denoised_img.png')
figure(4)
plot(loss_arr)


% normalize a image to 0-1
function normalized=normalize(img)
normalized = (img-min(img(:)))/(max(img(:))-min(img(:)));
end

function result=cal_loss(f,u,lambda)
    first=norm(f-u);
    grad_u=sqrt(Dxc(u).^2+Dyc(u).^2);
    second=sum(sum(grad_u));
    result=lambda*first+second;
end


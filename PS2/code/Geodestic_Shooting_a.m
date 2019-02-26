close all;
clear all;
clc;

[I,origin,space]=loadMETA('../data/sourceImage/source.mhd');
figure
imshow(I);
title('1');
[H,W]=size(I);
% initilize fi_0
[fi_tx,fi_ty]=meshgrid(1:100);

% load as v_0 at the very beginning
v_t=loadMETA('../data/velocity/v0Spatial.mhd');
v_t=v_t(1:2,:,:);
v_tx=squeeze(v_t(1,:,:));
v_ty=squeeze(v_t(2,:,:));
% used for debug
% v_tx=zeros(100,100);
% v_ty=zeros(100,100);
v_t_flatten=reshape(v_t,[2,1,10000]);


%%%%%% Define hyper-parameters
h=0.001;
final_t=1;

%%%%%% Geodestic Shooting
for k=1:final_t/h
    % construct Jacobian Matrix
%     v_x=v_t(1,:,:);
%     v_y=v_t(2,:,:);
%     size(v_x)
%     size(Dxc(v_x))
%     size(v_x)
    a=Dxc(v_tx).*v_tx+Dxc(v_ty).*v_ty;
    b=Dyc(v_tx).*v_tx+Dyc(v_ty).*v_ty;
    
%     trans=permute(v_t_flatten, [2,1,3]);
%     square=v_t_flatten.*trans;
%     divergence=reshape(square(:,2,:)-square(:,1,:),[2,100,100]);
%     div_x=squeeze(divergence(1,:,:));
%     div_y=squeeze(divergence(2,:,:));
    div_x=Dxc(v_tx.*v_tx)+Dyc(v_tx.*v_ty);
    div_y=Dxc(v_ty.*v_tx)+Dyc(v_ty.*v_ty);
    
    sum_x=a+div_x;
    sum_y=b+div_y;
    
    v_tx=v_tx+h*double(f_smooth(sum_x,16));
    v_ty=v_ty+h*double(f_smooth(sum_y,16));
    
%     v_x=v_x+double(h*f_smooth(first+reshape(divergence,[2,100,100]),16));
%     v_y=v_y+double(h*f_smooth())
    fi_tx=fi_tx+h*interp2(v_tx,fi_tx,fi_ty,'spline');
    fi_ty=fi_ty+h*interp2(v_ty,fi_tx,fi_ty,'spline');
end

I_final=interp2(I,fi_tx,fi_ty);
figure
imshow(I_final)
title('2');
imwrite(I_final,'result_a.jpg');
% imshowpair(I,I_final)

%%%%%% Functions

% set the default window size to 16^2
function result=f_smooth(img,window_size)
% convert to frequency domain
F=fft2(img);
% shift low frequency from four corners to the center
% visualize frequency domain
S=fftshift(F);
% keep different number of high frequency
% zero out high frequency
[h,w]=size(S);
temp=S;
preserve=S;
half=window_size/2;
temp(h/2-half:h/2+half,w/2-half:w/2+half)=0;
preserve=preserve-temp;
preserve=ifftshift(preserve);
result=uint8(real(ifft2(preserve)));
end
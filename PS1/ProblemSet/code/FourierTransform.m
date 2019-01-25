close all;
clear all;
clc;

% load and image
I = imread('../lenaNoise.png');
figure(1)
imshow(I,[])
title('original image')

% convert to frequency domain
F=fft2(I);

% shift low frequency from four corners to the center
% visualize frequency domain
S=fftshift(F);
S_v = abs(S);
S_v = log(S_v+1);
S_v = mat2gray(S_v);
figure(2)
imshow(S_v,[]);
title('centered fourier transform')

% keep different number of high frequency
% zero out high frequency
[h,w]=size(S);

% 10^2
temp_10=S;
preserve_10=S;
temp_10(h/2-5:h/2+5,w/2-5:w/2+5)=0;
preserve_10=preserve_10-temp_10;
preserve_10=ifftshift(preserve_10);
% 20^2
temp_20=S;
preserve_20=S;
temp_20(h/2-10:h/2+10,w/2-10:w/2+10)=0;
preserve_20=preserve_20-temp_20;
preserve_20=ifftshift(preserve_20);
% 40^2
temp_40=S;
preserve_40=S;
temp_40(h/2-20:h/2+20,w/2-20:w/2+20)=0;
preserve_40=preserve_40-temp_40;
preserve_40=ifftshift(preserve_40);
% 100^2
temp_100=S;
preserve_100=S;
temp_100(h/2-50:h/2+50,w/2-50:w/2+50)=0;
preserve_100=preserve_100-temp_100;
preserve_100=ifftshift(preserve_100);
% full dimension
preserve_full=zeros(512);
preserve_full=ifftshift(preserve_full);


% convert back to spatial domain
reconst=uint8(ifft2(F));
reconst_10=real(ifft2(preserve_10));
reconst_20=real(ifft2(preserve_20));
reconst_40=real(ifft2(preserve_40));
reconst_100=real(ifft2(preserve_100));
reconst_full=real(ifft2(preserve_full));

figure(4)
imshow(reconst,[])
figure(5)
imshow(reconst_10,[])
figure(6)
imshow(reconst_20,[])
figure(7)
imshow(reconst_40,[])
figure(8)
imshow(reconst_100,[])
figure(9)
imshow(reconst_full,[])
title('reconstructed image')
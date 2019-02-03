close all;
clear all;
clc;


% load and image
I = imread('../lenaNoise.png');
imwrite(I,'./Fourier Results/original.png')

% convert to frequency domain
F=fft2(I);

% shift low frequency from four corners to the center
% visualize frequency domain
S=fftshift(F);
S_v=visualize_fourier(S);
imwrite(S_v,'./Fourier Results/fourier_domain.png')

% keep different number of high frequency
% zero out high frequency
[h,w]=size(S);

% 10^2
temp_10=S;
preserve_10=S;
temp_10(h/2-5:h/2+5,w/2-5:w/2+5)=0;
preserve_10=preserve_10-temp_10;
preserve_10_v=visualize_fourier(preserve_10);
imwrite(preserve_10_v,'./Fourier Results/fourier_10.png')
preserve_10=ifftshift(preserve_10);

% 20^2
temp_20=S;
preserve_20=S;
temp_20(h/2-10:h/2+10,w/2-10:w/2+10)=0;
preserve_20=preserve_20-temp_20;
preserve_20_v=visualize_fourier(preserve_20);
imwrite(preserve_20_v,'./Fourier Results/fourier_20.png')
preserve_20=ifftshift(preserve_20);

% 40^2
temp_40=S;
preserve_40=S;
temp_40(h/2-20:h/2+20,w/2-20:w/2+20)=0;
preserve_40=preserve_40-temp_40;
preserve_40_v=visualize_fourier(preserve_40);
imwrite(preserve_40_v,'./Fourier Results/fourier_40.png')
preserve_40=ifftshift(preserve_40);
% 100^2
temp_100=S;
preserve_100=S;
temp_100(h/2-50:h/2+50,w/2-50:w/2+50)=0;
preserve_100=preserve_100-temp_100;
preserve_100_v=visualize_fourier(preserve_100);
imwrite(preserve_100_v,'./Fourier Results/fourier_100.png')
preserve_100=ifftshift(preserve_100);
% full dimension
preserve_full=zeros(512);
preserve_full_v=visualize_fourier(preserve_full);
imwrite(preserve_full_v,'./Fourier Results/fourier_full.png')
preserve_full=ifftshift(preserve_full);


% convert back to spatial domain
reconst=uint8(ifft2(F));
reconst_10=uint8(real(ifft2(preserve_10)));
imwrite(reconst_10,'./Fourier Results/reconst_10.png')
reconst_20=uint8(real(ifft2(preserve_20)));
imwrite(reconst_20,'./Fourier Results/reconst_20.png')
reconst_40=uint8(real(ifft2(preserve_40)));
imwrite(reconst_40,'./Fourier Results/reconst_40.png')
reconst_100=uint8(real(ifft2(preserve_100)));
imwrite(reconst_100,'./Fourier Results/reconst_100.png')
reconst_full=uint8(real(ifft2(preserve_full)));
imwrite(reconst_full,'./Fourier Results/reconst_full.png')

% figure(4)
% imshow(reconst,[])
% figure(5)
% imshow(reconst_10,[])
% figure(6)
% imshow(reconst_20,[])
% figure(7)
% imshow(reconst_40,[])
% figure(8)
% imshow(reconst_100,[])
% figure(9)
% imshow(reconst_full,[])
% title('reconstructed image')


function res=visualize_fourier(F)
res = abs(F);
res = log(res+1);
res = mat2gray(res);
end
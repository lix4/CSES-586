I = imread('cameraman.tif');
I_noise = imnoise(I,'gaussian', 0, 0.3);
imshow(I_noise);
clc;
test1=[1,2,3;
        4,5,6;
        7,8,9];
test2=[1,2,3;
        4,5,6;
        7,8,9];
test1./test2
function [normalized]=normalize(img)
norm_temp=img-min(img(:));
disp(norm_temp)
normalized = norm_temp./(max(img(:))-min(img(:)));
end
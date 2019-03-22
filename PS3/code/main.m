close all
clear all
clc

MAXITER=20;
PSet=loadTrainingSet();

% draw aligned faces and mean face
% figure
% for k=1:size(PSet,1)
%     drawFaceParts(-squeeze(PSet(k,:,:)),'r-');
% end
% axis off
% axis equal


% part (a)
[x_n,PSet_a,e]=computeMean(PSet,MAXITER);

% draw energy curve
% figure
% x_c=1:MAXITER;
% e=reshape(e,[1,MAXITER]);
% plot(x_c,e)

% draw aligned faces and mean face
% for k=1:size(PSet,1)
%     drawFaceParts(-squeeze(PSet_a(k,:,:)),'r-');
% end
% drawFaceParts(-squeeze(x_n),'k-');
% axis off
% axis equal

% part (b)
% zero out mean face
v_PSet=reshape(PSet_a,[21, 136, 1]);
v_mean=reshape(x_n,[1, 136, 1]);
v_zero_out=v_PSet-v_mean;


covar=v_zero_out.'*v_zero_out./21;
[V,D]=eigs(covar);
% [V,D,W]=svd(covar);
% eigenvalues decay
% decay_arr=zeros([1,3]);
% for j=1:3
%     decay_arr(1,j)=D(j,j);
% end
% plot(1:1:3,decay_arr)


ev1=D(1,1);
m1=sqrt(ev1);
ev2=D(2,2);
m2=sqrt(ev2);
ev3=D(3,3);
m3=sqrt(ev3);

idx=[-2,-1,0,1,2];
for i=1:5
    face1=reshape(x_n,[136,1])+idx(i)*m1*V(:,1);
    h=figure
    drawFaceParts(-reshape(face1,[68,2]),'r-');
    saveas(h,strcat('./results/ev1_',int2str(idx(i)),'.jpg'))
    axis off
    axis equal
end

for i=1:5
    face2=reshape(x_n,[136,1])+idx(i)*m2*V(:,2);
    h=figure
    drawFaceParts(-reshape(face2,[68,2]),'r-');
    saveas(h,strcat('./results/ev2_',int2str(idx(i)),'.jpg'))
    axis off
    axis equal
end

for i=1:5
    face3=reshape(x_n,[136,1])+idx(i)*m3*V(:,3);
    h=figure
    drawFaceParts(-reshape(face3,[68,2]),'r-');
    saveas(h,strcat('./results/ev3_',int2str(idx(i)),'.jpg'))
    axis off
    axis equal
end


%%%%%%%%%%%%%%%%%utility function%%%%%%%%%%%%%%%%%
function result = loadTrainingSet()
    files=dir('./dat/*.pts');
    num=length(files);
    result=[];
    for k=1:num
        thisFileName=strcat('./dat/',files(k).name);
        cPts=readPoints(thisFileName);
        cPts=reshape(cPts,[1,68,2]);
        result=cat(1,result,cPts);
    end
end

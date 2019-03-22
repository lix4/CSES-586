function [result,PSet_a,energy]=computeMean(PSet,MAXITER)
energy=zeros([MAXITER,1]);
PSet_a=zeros([21,68,2]);
% set mean to the first pset
mean=squeeze(PSet(1,:,:));
for x=1:MAXITER
    
    %align all x_i to x_u  
    for k=1:size(PSet_a,1)
        [ptsA,~]=getAlignedPts(mean,squeeze(PSet(k,:,:)));
        PSet_a(k,:,:)=reshape(ptsA,[1,68,2]);
%         energy(x)=energy(x)+cal_E(mean,ptsA);        
    end
    
    for k=1:size(PSet_a,1)
        energy(x)=energy(x)+norm(mean-squeeze(PSet_a(k,:,:)));
    end
    
    %calculate new mean
    sum=zeros([68,2]);
    for k=1:size(PSet_a,1)
        sum=squeeze(PSet_a(k,:,:))+sum;
    end
    mean=sum./size(PSet_a,1);
    
    %align mean to x_1
    [mean,~]=getAlignedPts(squeeze(PSet(1,:,:)),mean);
    
end

result=mean;
end

function e=cal_E(mean,pts)
    e=sum(sum((mean-pts).^2));
end

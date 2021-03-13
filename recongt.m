function newgt = recongt(groundtruth,sigf)
% reconstruct groundtruth according to the signal value
% groundtruth is a boolean signal
N=length(groundtruth);
newgt=zeros(N,1);
newgt(groundtruth==1)=sigf(2);
newgt(groundtruth==0)=sigf(1);
% for inum=1:N
%     if groundtruth(inum)==1
%         newgt(inum)=sigf(2);
%     elseif groundtruth(inum)==0
%         newgt(inum)=sigf(1);
%     end
% end
end


function f_final = gfr(f,thres,sigf)
% get final result according to the threshold
% f_final is a boolean signal
N=length(f);
f_final=zeros(N,1);
for i=1:N
    if f(i)<thres
        f_final(i)=sigf(1);
    elseif f(i)>thres
        f_final(i)=sigf(2);
    else
        f_final(i)=sigf(randperm(2,1));
    end
end
end


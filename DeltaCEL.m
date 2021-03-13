function result = DeltaCEL(f,y,training)
% the gradient of the cross entropy loss function with respect to f
% IN:
% f: parameters (variables)
% y: observations
% training: the training set
% OUT:
% result

S=length(training);
N=length(f);
result=zeros(N,1);
for s=1:S
    i=training(s);
    result(i)=(-y(s)/f(i)+(1-y(s))/(1-f(i)))/S;
end

end


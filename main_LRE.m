% we determine whether the animals have feathers based on other features
% 
% size of datasets: 30
% fractions of observations: 0.4:0.05:0.70
% 
% REFERENCES:
% [1] D. Dua and C. Graff, ¡°UCI machine learning repository,¡± 2017. (the 
% zoo dataset)
% [2] Brett W. Bader, Tamara G. Kolda and others. MATLAB Tensor Toolbox 
% Version 3.1, Available online, June 2019. 
% URL: https://gitlab.com/tensors/tensor_toolbox. 

clear
% tic

%% the zoo dataset

dataset=readtable('zoo.txt');
[row,col]=size(dataset);

%% parameters

N=30;% vertex number

% signal
sigf=[0.05,0.95];
sigf3=[-1,1];
sigcol=3;

lambda=0.001;
eta1=1;
eta2=5;
iter_num=10000;% number of iterations

fraction_set=0.40:0.05:0.70;% fraction of training set
fraction_num=length(fraction_set);

method_num=1;

% accuttl=zeros(iter_num,fraction_num,method_num);
% accutr=zeros(iter_num,fraction_num,method_num);

% accuracy of testing set
accute=zeros(iter_num,fraction_num,method_num);

%% classification

for iter=1:iter_num
    
    %% the hypergraph
    
    % generate the hypergraph according to the dataset (method 1)
    [indices,datamat,hedges,groundtruth,degree_set,hindex_set] = generateHGsep_new(dataset,N,sigcol);
    x=datamat';
    
    %% the signal values
    
    gt = recongt(groundtruth,sigf);
    
    %%
    
    for nnum=1:fraction_num
        fraction=fraction_set(nnum);% vertex number
        S=round(fraction*N);% vertex number of training set
        
        %% problem formulation
        
        % training set
        training=sort(randperm(N,S));
        
        % sampling operator
        Psi=zeros(S,N);
        for snum=1:S
            Psi(snum,training(snum))=1;
        end
        
        % testing set
        testing=1:N;
        for tnum=1:S
            testing(testing==training(tnum))=[];
        end
        
        % observations
        y1=gt(training);
        
        %% gradient descent method of the Laplacian Regularization Method
        
        f=gt;
        f(testing)=0.5;
        
        for i=1:1000
            dRdf = DeltaRegul(hedges,f,degree_set,hindex_set);
            dLdf = DeltaCEL(f,y1,training);
            dJdf=dLdf+lambda*dRdf;
            f=f-dJdf*eta1;
            
            if norm(dJdf)<2e-3
                break
            end
        end
        
        f_fin = gfr(f,0.5,[0,1]);
%         accuttl(iter,nnum,1)=1-nnz(groundtruth-f_fin)/N;
%         accutr(iter,nnum,1)=1-nnz(groundtruth(training)-f_fin(training))/S;
        accute(iter,nnum,1)=1-nnz(groundtruth(testing)-f_fin(testing))/(N-S);
        
      
    end
%     disp(iter)
%     toc
end

%% plot

plot(fraction_set,mean(accute(:,:)),'-o')
ylabel('Accuracy')
xlabel('Fraction of Observations')
ylim([0.7,1])
set(gca,'FontName','Times New Roman','FontSize',15)


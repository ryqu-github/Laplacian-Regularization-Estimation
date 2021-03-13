function [indices,datamat,hedges,groundtruth,degree_set,hindex_set] = generateHGsep_new(dataset,indices_num,sigcol)
% generate a hypergraph from a dataset randomly
% IN:
% dataset: the whole dataset (type: table)
% indices_num: the number of vertices in the hypergraph
% OUT:
% indices: the selected indices
% x: the input of all vertices
% hedges: the hyperedge set
% order: the order of the tensor

[row,col]=size(dataset);

%% obtain the data corresponding to the hypergraph

% obtain the indices of the vertices randomly
indices=sort(randperm(row,indices_num));

% obtain the topology
attr=2:col;
attr(attr==sigcol)=[];
datamat=table2array(dataset(indices,attr));

% obtain the signal
groundtruth=table2array(dataset(indices,sigcol));

%% generate the hyperedges

feature_num=zeros(1,col-2);% the number of values of each feature
hedges={};% the hyperedge set
for cnum=1:(col-2)
    feature=unique(datamat(:,cnum));
    feature_num(cnum)=length(feature);
    if feature_num(cnum)==2
        edge=find(datamat(:,cnum)==1)';
        if ~isempty(edge)&&length(edge)~=1
            hedges=[hedges,{edge}];
        end
    else
        for fnum=1:feature_num(cnum)
            edge=find(datamat(:,cnum)==feature(fnum))';
            if ~isempty(edge)&&length(edge)~=1
                hedges=[hedges,{edge}];
            end
        end
    end
end

hedge_num=length(hedges);% the number of hyperedges
hedge_degree=zeros(1,hedge_num);% the degree of each hyperedge (vertex number)
for hnum=1:hedge_num
    hedge_degree(hnum)=length(hedges{hnum});
end

%% seperate the hyperedges according to degree

degree_set=unique(hedge_degree);% the set of all degree values
degree_num=length(degree_set);% number of all degree values
hindex_set=cell(1,degree_num);% the index of hyperedge corresponding to the fixed degree
for dnum=1:degree_num
    hindex_set{dnum}=find(hedge_degree==degree_set(dnum));
end

end


function result = DeltaRegul(hedges,f,degree_set,hindex_set)
% the gradient of the regularization with respect to f
% IN:
% hedges: the hyperedge set
% f: the hypergraph signal
% degree_set: the set of degree of all hyperedges
% hindex_set: hyperedge index set corresponding to the degree set
% OUT:
% hedge_num=numel(hedges);% hyperedge number
N=length(f);
result=zeros(N,1);
% hedge_degree=zeros(1,hedge_num);% degree of each hyperedge
% for hnum=1:hedge_num
%     hedge_degree=length(hedges{hnum});
% end
% degree_set=unique(hedge_degree);% the set of all degree values
% degree_num=length(degree_set);% number of all degree values
% hindex_set=cell(1,degree_num);% the index of hyperedge corresponding to the fixed degree
% for dnum=1:degree_num
%     hindex_set{dnum}=find(hedge_degree==degree_set(dnum));
% end
degree_num=length(degree_set);
for dnum=1:degree_num% for all the degree values
    edges={hedges{hindex_set{dnum}}};
    order=degree_set(dnum);
    result = result + dperorder(edges,order,f);
end

end


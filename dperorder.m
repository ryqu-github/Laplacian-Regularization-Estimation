function result = dperorder(edges,order,f)
% derivatives of a single order hyperedges of the Laplacian regularization
% IN:
% edges: hyperedges having the same degree
% order: order (degree)
% f: signal
edge_num=numel(edges);
N=length(f);
M=order+mod(order,2);
result=zeros(N,1);
if mod(order,2)==0% even order
    for enum=1:edge_num
        edge=edges{enum};
        for m=1:order
            findex=edge(m);% the mth vertex in the hyperedge
            subedge=edge;% vertices in the hyperedge except the mth vertex
            subedge(subedge==findex)=[];
            dLfe=M*f(findex)^(M-1)-M*prod(f(subedge));
            result(findex)=result(findex)+dLfe;
        end
    end
else
    for enum=1:edge_num
        edge=edges{enum};
        for m=1:order
            findex=edge(m);% the mth vertex in the hyperedge
            subedge=edge;% vertices in the hyperedge except the mth vertex
            subedge(subedge==findex)=[];
            dLfe=M*f(findex)^(M-1)+M/(M-1)*(mean(f(edge)))^(M-1)-M*prod(f(subedge))*mean(f(edge))-M/(M-1)*prod(f(edge));
            result(findex)=result(findex)+dLfe;
        end
    end
end
end


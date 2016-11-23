function [Centroid,Cluster]=kmeans(Data,C)
X=Data;
[mX,nX]=size(X);
epsilon=0.001;

%Initialize centroids
Xmax=max(max(X));
C_t=Xmax*rand(mX,C);
v=2*epsilon;


while v>epsilon
    % cluster data based on current centroids
    Y=zeros(C,nX);
    for i=1:nX
        for j=1:C
            Distance(j)=norm(X(:,i)-C_t(:,j));
        end
        index=find(Distance==min(Distance));
        Y(index,i)=1; 
    end
    
    % calculate the optimal centroids based on the current clusters
    for i=1:C
        index2=find(Y(i,:)==1);
        if length(index2)==0
            index2=ceil(nX*rand(1,1));
        end
        C_tp1(:,i)=mean(X(:,index2),2);
    end
    v=trace((C_tp1-C_t)'*(C_tp1-C_t));
    C_t=C_tp1;
end

Centroid=C_tp1;
Cluster=Y;



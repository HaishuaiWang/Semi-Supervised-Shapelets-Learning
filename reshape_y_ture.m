function Y_true_matrix=reshape_y_ture(Y_true,C)
index=find(Y_true==0);
Y_true(index)=C;
index1=find(Y_true==-1);
Y_true(index1)=C;
mY=length(Y_true);
Y_true_matrix=zeros(C,mY);
for j=1:mY;
    Y_true_matrix(Y_true(j),j)=1;
end
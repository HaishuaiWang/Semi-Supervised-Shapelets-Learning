function w_21=L21_norm(w)
[m,n]=size(w);
s=[];
for j=1:m
    s(j)=norm(w(j,:));
end
w_21=sum(s);
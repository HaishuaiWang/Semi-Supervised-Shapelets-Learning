function W=Phi_function(unlabled_X,labled_X,unlabled_Y,labled_Y,W_t,eita_t)
[f_wt,ff_wt]=ff_function(unlabled_X,labled_X,W_t,unlabled_Y,labled_Y);
U_t=W_t - 1/eita_t*ff_wt;
W=[];

for j=1:size(W_t,1)
    if norm(U_t(j,:)) > 0.01/eita_t;
        co=1-1/(eita_t*norm(U_t(j,:)));
        w_i=co*U_t(j,:);
        W=[W;w_i];
    else
        w_i=zeros(size(U_t(j,:)));
        W=[W;w_i];
    end
end

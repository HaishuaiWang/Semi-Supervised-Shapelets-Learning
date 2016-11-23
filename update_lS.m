function S_tp1=update_lS(labled_Y,labled_X,W,labled_Shape_t,labled_Xkj_tp1_skl,lSSij_sil,SS,Parameter)
DS_t=labled_Shape_t(:,2:end);
i=1;
while i<Parameter.Imax+1 
    deri_of_S=derivation_of_lS(labled_Y,labled_X,W,labled_Shape_t,labled_Xkj_tp1_skl,lSSij_sil,SS,Parameter);
    DS_t=labled_Shape_t(:,2:end);
    DS_t=DS_t-Parameter.eta*deri_of_S;
    labled_Shape_t=[labled_Shape_t(:,1) DS_t];
    i=i+1;
end
S_tp1=labled_Shape_t;

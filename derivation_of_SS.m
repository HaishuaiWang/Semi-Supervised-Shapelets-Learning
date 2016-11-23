function Deri_of_S=derivation_of_S(unlabled_Y,labled_Y,unlabled_X,labled_X,W,ST_t,unlabled_Shape_t,labled_Shape_t,unlabled_Xkj_skl,labled_Xkj_sk1,unSSij_sil,lSSij_sil,SS,Parameter)
DShape_t=unlabled_Shape_t(:,2:end);
[mST,nST]=size(ST_t);
[mDShape,nDShape]=size(DShape_t);
%Der_of_S=zeros(mDShape,nDShape);

%Part1 YLY'
parameter1=1/2*unlabled_Y'*unlabled_Y;
parameter2=Parameter.lambda_1*SS;
for k=1:mDShape
    len=unlabled_Shape_t(k,1);
    for l=1:len
        for i=1:mST
            for j=1:nST
                STij_skl(i,j,k,l)=ST_t(i,j)*(-2/Parameter.sigma^2)*(unlabled_X(k,i)-unlabled_X(k,j))*(unlabled_Xkj_skl(k,i,l)-unlabled_Xkj_skl(k,j,l));
               % derivation of ST_ij at s_kl;
            end
            if j==i
                P1(i,j)=parameter1(i,j)*sum(STij_skl(i,:,k,l));
            else
                P1(i,j)=parameter1(i,j)*STij_skl(i,j,k,l);
            end
        end
       Part1(k,l)=sum(sum(P1));
       %Part2 
       Part2(k,l)=2*sum(parameter2(k,:).*unSSij_sil(k,:,l))-parameter2(k,k)*unSSij_sil(k,k,l);
    end
end


%Part3
[mY,nY]=size(unlabled_Y);
parameter3=Parameter.lambda_2*(W'*unlabled_X-unlabled_Y);
for k=1:mDShape
    len=unlabled_Shape_t(k,1);
    for l=1:len
        for i=1:mY
            for j=1:nY
                P3(j)=parameter3(i,j)*W(k,i)*unlabled_Xkj_skl(k,j,l);
            end
            pa3(i)=sum(P3);
        end
        Part3(k,l)=sum(pa3);
    end
end

%Part4
[mY,nY]=size(labled_Y');

parameter4=Parameter.lambda_4*(W'*labled_X-labled_Y');
for k=1:mDShape
    len=labled_Shape_t(k,1);
    for l=1:len
        for i=1:mY
            for j=1:nY
                P4(j)=parameter4(i,j)*W(k,i)*labled_Xkj_sk1(k,j,l);
            end
            pa4(i)=sum(P4);
        end
        Part4(k,l)=sum(pa4);
    end
end


Deri_of_S=Part1+Part2+Part3+Part4;


  
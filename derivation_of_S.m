function Deri_of_S=derivation_of_S(Y,X,W,ST_t,Shape_t,Xkj_skl,SSij_sil,SS,Parameter)
DShape_t=Shape_t(:,2:end);
[mST,nST]=size(ST_t);
[mDShape,nDShape]=size(DShape_t);
%Der_of_S=zeros(mDShape,nDShape);

%Part1 YLY'
parameter1=(100000000)*1/2*Y'*Y;
parameter2=Parameter.lambda_1*SS;
for k=1:mDShape
    len=Shape_t(k,1);
    for l=1:len
        for i=1:mST
            for j=1:nST
                STij_skl(i,j,k,l)=ST_t(i,j)*(-2/Parameter.sigma^2)*(X(k,i)-X(k,j))*(Xkj_skl(k,i,l)-Xkj_skl(k,j,l));
               % derivation of ST_ij at s_kl;
            end
            if j==i
                P1(i,j)=parameter1(i,j)*sum(STij_skl(i,:,k,l));
            else
                P1(i,j)=parameter1(i,j)*STij_skl(i,j,k,l);
            end
        end
       Part1(k,l)=sum(sum(P1));
       
       Part2(k,l)=2*sum(parameter2(k,:).*SSij_sil(k,:,l))-parameter2(k,k)*SSij_sil(k,k,l);
    end
end


%Part2: |H|_F_2        
% for k=1:mDShape
%     len=Shape_t(k,1);
%     for l=1:len
%        Part2(k,l)=2*sum(parameter2(k,:).*SSij_sil(k,:,l))-parameter2(k,k)*SSij_sil(k,k,l);
%     end
% end

%Part3
[mY,nY]=size(Y);
parameter3=Parameter.lambda_2*(W'*X-Y);
for k=1:mDShape
    len=Shape_t(k,1);
    for l=1:len
        for i=1:mY
            for j=1:nY
                P3(j)=parameter3(i,j)*W(k,i)*Xkj_skl(k,j,l);
            end
            pa3(i)=sum(P3);
        end
        Part3(k,l)=sum(pa3);
    end
end

Deri_of_S=Part1+Part2+Part3;


  
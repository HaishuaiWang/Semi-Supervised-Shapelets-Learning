function S_0=initialization_s(T,Parameter)

S_0=zeros(Parameter.k * Parameter.R, 1+Parameter.R*Parameter.Lmin);
for j=1:Parameter.R
    length=j*Parameter.Lmin;
    Segment_matrix=segment_obtain(T,length);
    S=ones(Parameter.k,1)*mean(Segment_matrix);
    %[S,Y]=EM(Segment_matrix',Parameter.k);
    S_0((j-1)*Parameter.k+1:j*Parameter.k,1)=length*ones(Parameter.k,1);
    S_0((j-1)*Parameter.k+1:j*Parameter.k,2:length+1)=S;
    Segment_matrix=[];
end
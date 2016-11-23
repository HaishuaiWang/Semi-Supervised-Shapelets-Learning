function Segment_matrix=segment_obtain(T,length)
L=T(:,1);
DT=T(:,2:end);
[mT,nT]=size(DT);
Segment_matrix=[];
for j=1:mT
    len=L(j,1)-length+1;
    for k=1:len
        seg=DT(j,k:k+length-1);
        Segment_matrix=[Segment_matrix;seg];
    end
end
function [f_w,ff_w]=ff_function(unlabled_X,labled_X,W,unlabled_Y,labled_Y)

M1=unlabled_X'*W-unlabled_Y';
M2=W;
M3=labled_X'*W-labled_Y;
f_w=100000/2*Frobenius_norm(M1)^2+10000/2*Frobenius_norm(M2)^2+100000/2*Frobenius_norm(M3);
ff_w=10000*labled_X*labled_X'*W-labled_X*labled_Y+10000*unlabled_X*unlabled_X'*W-unlabled_X*unlabled_Y'+W;
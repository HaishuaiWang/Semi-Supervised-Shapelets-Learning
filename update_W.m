function W_tp1=update_W(labled_X_t,unlabled_X_t,unlabled_Y_t,labled_Y,Parameter)
[mX,nX]=size(unlabled_X_t);

P1=Parameter.lambda_2*unlabled_X_t*unlabled_X_t'+Parameter.lambda_4*labled_X_t*labled_X_t'+Parameter.lambda_3*eye(mX);
P2=Parameter.lambda_2*unlabled_X_t*unlabled_Y_t'+Parameter.lambda_4*labled_X_t*labled_Y;
%P1=Parameter.lambda_2*unlabled_X_t*unlabled_X_t'+Parameter.lambda_3*eye(mX)
%P2=Parameter.lambda_2* unlabled_X_t* unlabled_Y_t';
W_tp1=inv(P1)*P2;
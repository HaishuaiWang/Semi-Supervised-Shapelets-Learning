function Fun=function_value(labled_X,unlabled_X,unlabled_Y,labled_Y,L_G,H,W,Parameter)

part1=0.5*(10000000)*trace(unlabled_Y*L_G*unlabled_Y');
part2=0.5*Parameter.lambda_1*trace(H'*H);
part3=0.5*Parameter.lambda_2*trace((W'*unlabled_X-unlabled_Y)'*(W'*unlabled_X-unlabled_Y));
part4=0.5*Parameter.lambda_3*trace(W'*W);
part5=0.5*Parameter.lambda_4*trace((W'*labled_X-labled_Y')'*(W'*labled_X-labled_Y'));
Fun=part1+part2+part3+part4+part5;
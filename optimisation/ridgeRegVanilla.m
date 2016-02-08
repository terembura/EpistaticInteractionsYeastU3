function z=ridgeRegVanilla(y,X,reg)

%RIDGEREGVANILLA simple ridge regression. Assumes rectangular matrices so uses Woodbury. MUST be run on big machine!

  invMat=reg^(-2)*eye(size(X,2))- reg^(-4)*X'*inv(eye(size(X,1))+reg^(-2)*X*X')*X;
z=invMat*X'*y;

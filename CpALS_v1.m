function [lambda,A_all,error,error_all,ite]=CpALS_v1(varargin)
%% Input
%varargin(1):X in R^[I1,I2,...,Id]
%varargin(2): RANK
%varargin(3) : opt
%% Output
%lambda: weight Rx1 vector
%A_all: dx1 cell, each is a InxRANK factor
if isempty(varargin)
    X=TensorGenerator();
    RANK=length(size(X));
else
    X=varargin{1};
    RANK=varargin{2};
end
if length(varargin)<3
    opt.ite_max=5000;
    opt.tol=1e-8;
    opt.print=false;
else
    opt=varargin{3};
end
I_all=size(X);
A_all=InitFactor_Rand(I_all,RANK);
error_all=[];
for ite=1:opt.ite_max
    for n=1:length(I_all)
        V=Cal_V(A_all,n);%%element-wise product
        U=Cal_U(A_all,n);%%khatirao product
        X_modeN=tenmat(X,n);%%modeN unfolding
        A_all{n}=X_modeN.data*U/V;
        %X_modeN=reshape(X.data,size(X,n),[]);
        %A_all{n}=X_modeN*U/V;
        [A_all{n},lambda]=NormA(A_all{n});
    end
    X_CP=ktensor(lambda,A_all);
    %% Compute the error and error_diff
    error=norm(X-X_CP);
    error_all=[error_all;error];
    if ite==1
        error_diff=1;
    else
        error_diff=abs(error-error_old);
    end
    error_old=error;
    if error<opt.tol || error_diff<opt.tol
        break;
    end
    if opt.print==true
    fprintf(' @Ite=%d error= %f \n',ite, error);
    end
end
fprintf(' Final Ite=%d error %f \n',ite, error);
end
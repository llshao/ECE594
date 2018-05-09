function [lambda,A_all,error,error_all,ite]=CpALS_KTv2(varargin)
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
    opt.ite_max=1000;
    opt.tol=1e-8;
    opt.errdiff=1e-15;
    opt.print=false;
    opt.errper=0.01;
else
    opt=varargin{3};
end
I_all=size(X);
A_all=InitFactor_Rand(I_all,RANK);
error_all=[];
for ite=1:opt.ite_max
    for n=1:length(I_all)
        V=Cal_V(A_all,n);%%element-wise product
        U=KTXnKhatiro(X,A_all,n);%%modeN unfolding Khatirao product except n
        A_all{n}=U/V;%% Updating A(n)
        [A_all{n},lambda]=NormA(A_all{n});%% Normalization
    end
    X_CP=ktensor(lambda,A_all);
    %% Compute the error and error_diff
    error=norm(X-X_CP);
    error_all=[error_all;error];
    %error_percent= error/norm(X);
    if mod(ite,10)==0
        if ite==10
            error_diff=1;
        else
            error_diff=abs(error-error_old);
        end
        error_old=error;
        if error<opt.tol || error_diff< opt.errdiff
            break;
        end
    end
    if opt.print==true
        fprintf(' @Ite=%d error= %f \n',ite, error);
    end
end
fprintf(' Final Ite=%d error %f \n',ite, error);
end
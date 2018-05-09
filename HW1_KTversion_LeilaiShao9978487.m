%% Test the CP_ALS algorithm
Result.CP_Error=zeros(4,4,2);
Result.Ite_Final=zeros(4,4,2);
Result.Inner_Error=zeros(4,4);
i=0;
j=0;
for r=[2,3,4,5]
    i=i+1;
    tic
    for dim=[10,20,50,100]
        j=j+1;
        dimension=dim*ones(r,1);
        lambda_generator1=rand(r,1);
        lambda_generator1=lambda_generator1/sum(lambda_generator1);
        lambda_generator2=rand(r,1);
        lambda_generator2=lambda_generator2/sum(lambda_generator2);
        %% Generate low rank tensor
        Tensor_R1=KTensorGenerator(dimension,lambda_generator1,r);
        Tensor_R2=KTensorGenerator(dimension,lambda_generator2,r);
        %% Peform the CP Decomposition
        [lambda1,A_all1,CP_error1,CP_errorall1,ite_final1]=CpALS_KTv1(Tensor_R1,r);
        [lambda2,A_all2,CP_error2,CP_errorall2,ite_final2]=CpALS_KTv1(Tensor_R2,r);

        %% Calculate the Innerproduct error
        X_CP1=ktensor(lambda1,A_all1);
        X_CP2=ktensor(lambda2,A_all2);
        %Inner_CP=ttt(X_CP1,X_CP2,1:r);
        %Inner_Origin=ttt(Tensor_R1,Tensor_R2,1:r);
        %Inner_CP=innerprod(X_CP1,X_CP2);
        %Inner_Origin=innerprod(Tensor_R1,Tensor_R2);
        Inner_CP=KTInner(X_CP1,X_CP2);
        Inner_Origin=KTInner(Tensor_R1,Tensor_R2);
        Inner_error=Inner_Origin-Inner_CP
        %% Store the Results
        Result.CP_Error(i,j,:)=[CP_error1,CP_error2];
        Result.Ite_Final(i,j,:)=[ite_final1,ite_final2];
        Result.Inner_Error(i,j)=Inner_error;
        sprintf('Rank %d Dimension %d Inner_error %f',r,dim,Inner_error)
    end
    toc
end
save('HW1P1ResultMay7Largest.mat','Result');

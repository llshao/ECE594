%% Test the CP_ALS algorithm
clear
close all
Result.CP_Error=zeros(4,4,2);
Result.Ite_Final=zeros(4,4,2);
Result.Inner_Error=zeros(4,4);
Result.Inner_Errorall=cell(4,4,2);
i=0;
%% plot && store control
PLOT=true;
STORE=true;
for r=[6]
    i=i+1;
    j=0;
    tic
    for dim=[500]
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
        [lambda1,A_all1,CP_error1,CP_errorall1,ite_final1]=CpALS_KTv2(Tensor_R1,r);
        [lambda2,A_all2,CP_error2,CP_errorall2,ite_final2]=CpALS_KTv2(Tensor_R2,r);
        %% Calculate the Innerproduct error
        X_CP1=ktensor(lambda1,A_all1);
        X_CP2=ktensor(lambda2,A_all2);
        Inner_CP=KTInner(X_CP1,X_CP2);
        Inner_Origin=KTInner(Tensor_R1,Tensor_R2);
        Inner_error=Inner_Origin-Inner_CP;
        disp('Inner Error:')
        disp(Inner_error)
        %% Plot or Store the Results
        if PLOT==true
            figure()
            plot(CP_errorall1);
            figure()
            plot(CP_errorall2);
        end
        if STORE==true
            Result.CP_Error(i,j,:)=[CP_error1,CP_error2];
            Result.Ite_Final(i,j,:)=[ite_final1,ite_final2];
            Result.Inner_Error(i,j)=Inner_error;
            Result.Inner_Errorall{i,j,1}=CP_errorall1;
            Result.Inner_Errorall{i,j,2}=CP_errorall2;
        end
        sprintf('Rank %d Dimension %d Inner_error %5f',r,dim,Inner_error)
    end
end
if STORE==true
    filename=[char(datetime) 'HW1P1ResultMay7Largest.mat'];
    filename=strrep(filename,':','-');
    save(filename,'Result');
end
toc
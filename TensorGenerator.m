function Tensor_R=TensorGenerator(varargin)
%% varargin(1):[I1,I2,...,Id]
%% varargin(2): [lambda1,lambda2,...,lambdad]
%% varargin(3): RANK
l_var=length(varargin);
switch l_var
    case 0
        disp('Default Input d=3,I=[100,200,100],lambda=[1/3,1/3,1/3]')
        I=[100,200,100];
        Way=length(I);
        Lambda=[1/3,1/3,1/3];
        RANK=3;
    case 1
        disp('One Input I=varargin(1),lambda=[1/3,1/3,1/3]')
        I=varargin{1};
        Way=length(I);
        RANK=3;
        Lambda=1/RANK*ones(Way,1);
    case 2
        disp('2 Input I & lambda')
        I=varargin{1};
        Lambda=varargin{2};
        Way=length(I);
        RANK=3;
    case 3
        disp('3 Inputs')
        I=varargin{1};
        Lambda=varargin{2};
        Way=length(I);
        RANK=varargin{3};
    otherwise
        disp('Too much Input Default Input d=3,I=[100,200,100],lambda=[1/3,1/3,1/3]')
        I=[100,200,100];
        Way=length(I);
        Lambda=[1/3,1/3,1/3];
end

for rank=1:RANK
    for i=1:Way
        A=rand(I(i),1);
        T = tensor(A,I(i));
        if i==1
            Tensor_X=T;
        else
            Tensor_X=ttt(Tensor_X,T);
        end
    end
    if rank==1
        Tensor_R=Lambda(rank)*Tensor_X;
    else
        Tensor_R=Tensor_R+Lambda(rank)*Tensor_X;
    end
end
ndims(Tensor_R)
size(Tensor_R)
end
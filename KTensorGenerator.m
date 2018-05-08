function Tensor_R=KTensorGenerator(varargin)
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
U=cell(RANK,1);
for i=1:Way
    U{i}=rand(I(i),RANK);
end

Tensor_R=ktensor(Lambda,U);

end
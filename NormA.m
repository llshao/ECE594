function [A_nor,lambda]=NormA(A)
R=size(A,2);
lambda=zeros(R,1);
A_nor=zeros(size(A));
for i=1:R
   lambda(i)=norm(A(:,i));
   A_nor(:,i)=A(:,i)/lambda(i);
end
end
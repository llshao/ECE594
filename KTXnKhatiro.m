function U=KTXnKhatiro(X,U,n)
N = ndims(X);
if (n==1)
    R = size(U{2},2);
else
    R = size(U{1},2);
end
% Compute matrix of weights
W = repmat(X.lambda,1,R);
for i = [1:n-1,n+1:N]
  W = W .* (X.u{i}' * U{i});
end    
% Find each column of answer by multiplying columns of X.u{n} with weights 
U = X.u{n} * W;
end
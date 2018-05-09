function Inner=KTInner(X,Y)
L = X.u{1}' * Y.u{1};
for i = 2:ndims(X)
    L = L .* (X.u{i}' * Y.u{i});
end
Inner = X.lambda'*L*Y.lambda;
end
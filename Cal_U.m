function U=Cal_U(A_all,n)%%khatirao product
A_new={A_all{[1:n-1,n+1:length(A_all)]}};
U=khatrirao(A_new,'r');
end
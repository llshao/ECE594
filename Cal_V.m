function V=Cal_V(A_all,n)
V=[];
for i=1:length(A_all)
   if i~=n
       if ~isempty(V)
           V=V.*(A_all{i}'*A_all{i});
       else
           V=A_all{i}'*A_all{i};
       end
   end
end
end
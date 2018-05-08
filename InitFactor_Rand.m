function A_all=InitFactor_Rand(I_all,RANK)
A_all=cell(RANK,1);
for i=1:length(I_all)
   A_all{i}=rand(I_all(i),RANK);
end
end
function C_Mutual_E= C_M_ME(FMatrix_A,Matrix_B,C)
size_sample = size(FMatrix_A,1);
M1 = min(C,Matrix_B);
M2 = max(FMatrix_A,M1);
M3 = max(FMatrix_A,C);
C_Mutual_E=0;
for i = 1:size_sample
    C_Mutual_E = C_Mutual_E - log2(sum(M2(i,:),"all") / sum(M3(i,:),"all"));
end
C_Mutual_E=C_Mutual_E/size_sample;
end


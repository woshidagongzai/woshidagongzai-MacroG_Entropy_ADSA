function CGRAN = C_ME(FMatrix_A,C)
%C_ME 
CGRAN=0;
size_sample = size(FMatrix_A,1);
MM=max(FMatrix_A,C);
for i = 1:size_sample
    CGRAN = CGRAN - log2(sum(FMatrix_A(i,:),"all") / sum(MM(i,:),"all"));
end
CGRAN=CGRAN/size_sample;
end


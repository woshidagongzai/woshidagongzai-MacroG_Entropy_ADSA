function TR = ERelation(A)

%% The equivalence relation
[m,n] = size(A);
TR = eye(m);
for i = 1:m
    for k = i:m
            if A(i,:) == A(k,:)
                TR(i,k)=1;TR(k,i)=1;
            else
                continue
            end
    end
end

end
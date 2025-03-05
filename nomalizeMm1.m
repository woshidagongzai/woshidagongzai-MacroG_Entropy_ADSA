function [liA1] = nomalizeMm1(A)
%LIM1 将属性归一化
%   返回的是0-1之间的矩阵
ma=min(A,[],1);
Ma=max(A,[],1);
da=Ma-ma;

for i=1:size(A,2)
%     if da(1,i) ==0
%         A(:,i)=0.5;
%         continue
%     else
   A(:,i)= (A(:,i)-ma(1,i))./da(1,i);
%     end
end
liA1=A;
end



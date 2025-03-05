function [joint_ME] = Join_FME(Matrix_A,Matrix_B)
%JOIN_ME 此处显示有关此函数的摘要
%   此处显示详细说明
joint_ME=0;
M1=max(Matrix_A,Matrix_B);
n=size(M1,1);
for i =1 :n
joint_ME=joint_ME-log2(sum(Matrix_B(i,:),"all")*sum(Matrix_A(i,:),"all")/(n*sum(M1(i,:),"all")));
end
joint_ME=joint_ME/n;
end


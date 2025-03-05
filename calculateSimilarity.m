function [ similarityMatrix ] = calculateSimilarity( fea,type )
%����������ģ������feature��ʾ�����У�type��ʾ��ȡ�ķ�ʽ
% 1:1-4*(~);     2:;   3: ���ڼ�����������ݵ����ƹ�ϵ
% 4��mmmm 5��1-abs(~)/abs(max-min) 13=��˹�˺���
% 6:�����������;����µ����ƹ�ϵ
values=fea;
% similarityMatrix=[]
[m,n]=size(fea);
if type==1
    maxValue = max(values );
    minValue = min(values);
    numel(values);
    similarityMatrix =1-4*abs(repmat(values(:),1,numel(values))-repmat(values(:)',numel(values),1))/abs(maxValue-minValue);
    similarityMatrix(similarityMatrix<0)=0;
elseif type==2
    stdValue = repmat(std(values ), numel(values), numel(values));
    m1 = repmat(values(:), 1, numel(values)) ;
    m2 = repmat(values(:)', numel(values), 1);
    similarityMatrix =exp(-(m2-m1).^2./(2*(stdValue).^2));
elseif type==4
    stdValue = std(values );
    m1 = repmat(values(:), 1, numel(values)) ;
    m2 = repmat(values(:)', numel(values), 1);
    similarityMatrix = max( min( ( m2-(m1-stdValue))/stdValue,( (m1+stdValue)-m2)/stdValue),0); 
elseif type==5
    vmax=max(values);
    vmin=min(values);    
    m1 = repmat(values(:), 1, numel(values)) ;
    m2 = repmat(values(:)', numel(values), 1);
    similarityMatrix = 1.-(abs(m1-m2)/abs(vmax-vmin));     
elseif type==3
    similarityMatrix=repmat(values(:),1,numel(values))==repmat(values(:)',numel(values),1) ;  
elseif type==6
    % ������Լ������ƾ���
    similarityMatrix=ones(m,m);
    for i=1:m
        for j=i+1:m
            if(sum(fea(i,:)==fea(j,:))==n)
                similarityMatrix(i,j)=1;
                similarityMatrix(j,i)=1;
            else
                similarityMatrix(i,j)=0;
                similarityMatrix(j,i)=0;
            end
        end
    end 
elseif type==7
    % ������Լ������ƾ���
    similarityMatrix=ones(m,m);
    for i=1:m
        for j=i+1:m
            similarityMatrix(i,j)=sum(fea(i,:)==fea(j,:))/n;
            similarityMatrix(j,i)=similarityMatrix(i,j);
        end
    end 
    similarityMatrix(similarityMatrix>=0.75)=1;
    similarityMatrix(similarityMatrix<=0.25)=0;
elseif type==8
    %
    similarityMatrix=ones(m,m);
    C=ones(m,m);
    for i=1:m
        for j=i+1:m
            C(i,j)=sum(fea(i,:)==fea(j,:))/n;
            C(j,i)=C(i,j);
        end
    end 
    for i=1:m
        for j=i+1:m
            temp=(C(i,:)-C(j,:)).^2;
%             temp=temp.^2;
            similarityMatrix(i,j)=sum(temp)^0.5;
            similarityMatrix(j,i)=similarityMatrix(i,j);
        end
    end
    gap=max(max(similarityMatrix))-min(min(similarityMatrix));
    similarityMatrix=1-similarityMatrix/gap;
elseif type==9
    pn1=sum(fea==1);
    pn0=sum(fea==-1);
    p1=(pn1+1)./(pn1+pn0+2);
    similarityMatrix=ones(m,m);
    for i=1:m
        for j=i+1:m
            re=1;
            for k=1:n
                if fea(i,k)*fea(j,k)==-1
                     re=0;
                     break;
                elseif fea(i,k)+fea(j,k)==1
                        re=min(re,p1(k));
                elseif fea(i,k)+fea(j,k)==-1
                        re=min(re,1-p1(k));
                elseif fea(i,k)==0 && fea(j,k)==0
                    re=min(re,p1(k)^2+(1-p1(k))^2);
                else
                    re=min(re,1);
                end
            end
            similarityMatrix(i,j)=re;
            similarityMatrix(j,i)=re;
        end
    end 
    similarityMatrix(similarityMatrix<0.5)=0;
    similarityMatrix(similarityMatrix>=0.5)=1;
elseif type==10
    pn1=sum(fea==1);
    pn0=sum(fea==-1);
    p1=(pn1+1)./(pn1+pn0+2);
    similarityMatrix=ones(m,m);
    for i=1:m
        for j=i+1:m
            re=0;
            for k=1:n
                if fea(i,k)*fea(j,k)==-1
                     re=0;
                     continue;
                elseif fea(i,k)+fea(j,k)==1
%                     if fea(j,k)==0
                        re=re+p1(k);
%                     end
                elseif fea(i,k)+fea(j,k)==-1
%                     if fea(j,k)==0
                        re=re+1-p1(k);
%                     end
                elseif fea(i,k)==0 && fea(j,k)==0
                    re=re+p1(k)^2+(1-p1(k))^2;
                else
                    re=re+1;
                end
            end
            similarityMatrix(i,j)=re/n;
            similarityMatrix(j,i)=re/n;
        end
    end
    similarityMatrix(similarityMatrix<=0.8)=0;
    similarityMatrix(similarityMatrix>=0.8)=1;
elseif type==11  %�������ݹ�ϵ�������ƹ�ϵ
    similarityMatrix=ones(m,m);
    for i=1:m
        for j=i+1:m
            re=1;
            for k=1:n
                if fea(i,k)*fea(j,k)==-1
                     re=0;
                     break;
                else
                    re=1;
                end
            end
            similarityMatrix(i,j)=re;
            similarityMatrix(j,i)=re;
        end
    end 
elseif type==12
    pn1=sum(fea==1);
    pn0=sum(fea==-1);
    p1=(pn1+1)./(pn1+pn0+2);
    similarityMatrix=ones(m,m);
    for i=1:m
        for j=i+1:m
            re=1;
            for k=1:n
                if fea(i,k)*fea(j,k)==-1
                     re=0;
                     break;
                elseif fea(i,k)+fea(j,k)==1
                        re=min(re,p1(k));
                elseif fea(i,k)+fea(j,k)==-1
                        re=min(re,1-p1(k));
                elseif fea(i,k)==0 && fea(j,k)==0
                    re=min(re,p1(k)^2+(1-p1(k))^2);
                else
                    re=min(re,1);
                end
            end
            similarityMatrix(i,j)=re;
            similarityMatrix(j,i)=re;
        end
    end 
    similarityMatrix(similarityMatrix<=0.25)=0;
    similarityMatrix(similarityMatrix>=0.75)=1;
% end
elseif type == 13
    [m,~] = size(fea);
similarityMatrix = zeros(m,m);
std_a = std(fea(:,1));
T=ones(1,m);
    similarityMatrix(:,:)=exp((-1)*(fea(:,1)*T-T'*fea(:,1)').^2/(2.*std_a(1).^2));
end
end


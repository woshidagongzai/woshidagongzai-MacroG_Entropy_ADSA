function [fea_red] = Main_MCME(C,D,paramet_halt)
%paramet_halt stop paprameter
%C:feture data  D:decision data
%type=2

n=size(C,1);%样本数量
MATRIX_D=ERelation(D);

DIM=size(C,2);

ATTlab=1:DIM;
% ATTsig=zeros(1,DIM);
FEA_MATRIX=cell(1,DIM);
red=[];%约简结果
all_matrix=ones(n);

for i=ATTlab
    FEA_MATRIX{1,i}=calculateSimilarity(C(:,i),2);
    all_matrix=min(all_matrix,FEA_MATRIX{1,i});
end
C_ALLFIG=C_ME(MATRIX_D,all_matrix);

MAXAT=[];
MAXSIG=n*n;
for i=ATTlab
    sig=C_ME(MATRIX_D,FEA_MATRIX{1,i});
    if sig<MAXSIG
        MAXSIG=sig;
        MAXAT=i;
    end
end
red=[red,MAXAT];
red_CD=C_ME(MATRIX_D,FEA_MATRIX{1,MAXAT});
red_MATRIX=FEA_MATRIX{1,MAXAT};
ATTlab=setdiff(ATTlab,red);


while  red_CD~=C_ALLFIG
% while  1
    SIG_MAX=0;
    MAXATT=[];
    for i=ATTlab
        TEM_MATRIX=min(red_MATRIX,FEA_MATRIX{1,i});
        C_TEMP=C_ME(MATRIX_D,TEM_MATRIX);
        sig_att=red_CD-C_TEMP;
        if sig_att>SIG_MAX
            SIG_MAX=sig_att;
            MAXATT=i;
        else
            continue
        end
    end

    if SIG_MAX>paramet_halt
        red_MATRIX=min(red_MATRIX,FEA_MATRIX{1,MAXATT});
        red=[red,MAXATT];
        ATTlab=setdiff(ATTlab,MAXATT);
        red_CD=red_CD-SIG_MAX;
    else
        break
    end
end
fea_red=red;
end

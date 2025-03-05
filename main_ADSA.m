function [fea_red] = main_ADSA(C,D,paramet_halt)
%paramet_halt stop paprameter
%C:feture data  D:decision data
%type=2
n=size(C,1);%样本数量
MATRIX_D=ERelation(D);

DIM=size(C,2);

ATTlab=1:DIM;
% ATTsig=zeros(1,DIM);
FEA_MATRIX=cell(2,DIM);
red=[];%约简结果


for i=ATTlab
    FEA_MATRIX{1,i}=calculateSimilarity(C(:,i),2);
    FEA_MATRIX{2,i}=Join_FME(FEA_MATRIX{1,i},MATRIX_D);
end


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


% while  red_CD~=C_ALLFIG
while  1
    SIG_MAX=0;
    MAXATT=[];
    for i=ATTlab
        sig_att=0;
        sig_att1=0;
        for j = red
            sig_att1=sig_att1+FEA_MATRIX{2,j};
            sig_att = sig_att+C_M_ME(MATRIX_D,FEA_MATRIX{1,j},FEA_MATRIX{1,i})+C_M_ME(MATRIX_D,FEA_MATRIX{1,i},FEA_MATRIX{1,j});
        end
        ASDA=(sig_att)/((size(red,2))*FEA_MATRIX{2,i}+sig_att1);
        if ASDA>SIG_MAX
            SIG_MAX=ASDA;
            MAXATT=i;
        else
            continue
        end
    end
    c_m_decent=red_CD-C_ME(MATRIX_D,min(red_MATRIX,FEA_MATRIX{1,MAXATT}));
    if c_m_decent>paramet_halt
        red_MATRIX=min(red_MATRIX,FEA_MATRIX{1,MAXATT});
        red=[red,MAXATT];
        ATTlab=setdiff(ATTlab,MAXATT);
        red_CD=red_CD-c_m_decent;
    else
        break
    end
end
fea_red=red;
end

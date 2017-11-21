function AROHap_V2(varargin)
% Mohammad Olyaee 2017
clc
clear
if nargin==0
    Mpath=uigetdir('D:\','Select Dataset'); %one can change the file path and file name(for one length value).
    directory=[Mpath,'\exp-700-*-h0.7'];%Change the name for other lengths
    D1=dir(directory);
    Pivot1=0.65;
    Pivot2=0.35;
    dthr1=0.75;
    dthr2=0.15;
    ng=2000;
    TT=400;
end
if isempty(D1)
    fprintf(['ERROR! Fail to find ',Mpath,'\n']);
    return;
end
Num_paras=length(D1);
for d=1:Num_paras
    D=dir([Mpath,'\',D1(d).name,'\*.m.4.err']);
    if isempty(D)
        fprintf('ERROR! Fail to find %s *.m.4.err!\n',D1(d).name);
        return;
    end
    fprintf('Succeed to find %s \\*.m.4.err!\n',D1(d).name);
    Num_exps=length(D);
    rrs=zeros(1,Num_exps);
    for i=1:Num_exps  %for each instance
        tStart=tic;
        [M0,m0,n0,H_real]=inputdata(Mpath,D1(d).name,D(i).name,i); % set frags on M0 and target haps in H_real
        [M,m,n,H_assem,Most]=Heter4to2(M0,m0,n0);
        init=zeros(1,m);
        [C1,C2,Mask]=FCGraph(M,Pivot1,Pivot2,dthr1,dthr2);
        init(C2)=1;
        CHR=init;
        H_rec=MakeHapbyMajority(CHR,M);
        ParentScore=MEC(H_rec,M);
        ing=1;
        BestScore=1000;
        ch=0;
        while ing<=ng && BestScore>0
            [bud]=Reproduce(CHR,Mask);%%%%%
            H_rec=MakeHapbyMajority(bud,M);
            BudScore=MEC(H_rec,M);
            if ParentScore>BudScore
                CHR=bud;
                ParentScore=BudScore;
            end
            if BestScore>ParentScore% for termination
                BestScore=ParentScore;
                ch=0;
                BestCHR=CHR;
            end
            if ch>=TT
                break;
            end
            if ParentScore==0
                break;
            end
            ch=ch+1;
            ing=ing+1;
        end
        H_rec=MakeHapbyMajority(CHR,M);
        H_assem=CompleteHap(H_rec,H_assem);
        H_assem4=H_assem2to4(H_assem,Most);
        rrs(i)=RR4(H_real,H_assem4);
        tElapsed(i)=toc(tStart);
        fprintf('The instance %d is finished!\n',i);
        ING(i)=ing;
    end %end for each instance
    str=['AROHap_',D1(d).name,'_RR.txt'];
    fprintf('\n%s',str);
    fid=fopen(['AROHap_',D1(d).name,'_RR.txt'],'w+');
    for j=1:Num_exps
        fprintf(fid,'%d\t%1.4f\t%d\t%d \n',j,rrs(j),tElapsed(j),ING(j));
    end
    average_rr=mean(rrs);
    fprintf(fid,'%1.4f\n\n',average_rr);
    average_t=mean(tElapsed);
    average_ing=mean(ING);
    fprintf(fid,'%1.4f\t%1.4f\t%1.4f\n',average_rr,average_t,average_ing);
    fclose(fid);
end 
fprintf('one paramenter set of one length value ends£¡');










function GAHAP(varargin)
clc
clear
if nargin==0
    Mpath=uigetdir('D:\MyClasses\BioInspired\My Project\Haplotype\Data\SurveyDataset\','Select Dataset'); %one can change the file path and file name(for one length value).
    directory=[Mpath,'\exp-700-*-h0.7'];
    D1=dir(directory);
    PS=500;% population size
    Pc=0.75; % Crossover rate
    Pm=0.01; % Mutation rate
    ES=0.2; % Elitism rate
    MNG=1000; % maximum number of generation
    K=30; % iteration number
    
end
if isempty(D1)
    fprintf(['ERROR! Fail to find ',Mpath,'\n']);
    return;
end
Num_paras=length(D1);
for d=11:11
    D1(d).name%for each parameter set
    %ss=[Mpath,D1(d).name,'\*.m.4.err']
    D=dir([Mpath,'\',D1(d).name,'\*.m.4.err']);
    if isempty(D)
        fprintf('ERROR! Fail to find %s *.m.4.err!\n',D1(d).name);
        return;
    end
    fprintf('Succeed to find %s \\*.m.4.err!\n',D1(d).name);
    Num_exps=length(D);
    %________________________
    Num_exps=8;
    %________________________
    rrs=zeros(1,Num_exps);
    for i=1:Num_exps  %for each instance
        tStart=tic;
        
        [M0,m0,n0,H_real]=inputdata(Mpath,D1(d).name,D(i).name,i); % set frags on M0 and target haps in H_real
        [M,m,n,H_assem,Most]=Heter4to2(M0,m0,n0);
        %H_rec=rand_gen(n);% Initial sample
        %K=5;  %  parameter k in the SkNN, one can change it.
        %C=2;   %  parameter cs the support count threshold, one can change it.
        sss=D1(d).name;
        t=10;
        j=1;
        t1=1000;
        thr=0;
        CHR=Create_rand(PS,m);
        previous=2000;
        Best=1;
        while (j<=MNG && thr<=K && Best>0)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if mod(j,50)==0
                fprintf('\n iteration:%d\t best=%d',j,Best);
            end
            F=HapFitness(CHR,M);
            Best=min(F);
            index=find(F==Best);
            BestChr=CHR(index(1),:);            
            MatingPool=Rank(F);
            NewGen=SinglePoint(MatingPool,CHR,Pc);
            CHR=mutation(NewGen,Pm);
            %F=HapFitness(CHR,M);
            j=j+1;
            if Best==previous
                thr=thr+1;
            else
                thr=0;
                previous=Best;
            end
            %C=C+1;
        end
        H_rec=MakeHapbyMajority(BestChr,M);
        tElapsed(i)=toc(tStart);
        H_assem=CompleteHap(H_rec,H_assem);
        H_assem4=H_assem2to4(H_assem,Most);
        rrs(i)=RR4(H_real,H_assem4);
        fprintf('\nRR=%f\t time=%f\n ',rrs(i),tElapsed(i));
        fprintf('The instance %d is finished!\n',i);
    end %end for each instance
    fid=fopen([D1(d).name,'_RR.txt'],'w+');
    for j=1:Num_exps
        fprintf(fid,'%d\t%1.4f\t%d\n',j,rrs(j),tElapsed(j));
    end
    average_rr=mean(rrs);
    average_t=mean(tElapsed);
    fprintf(fid,'%1.4f\t%1.4f\n',average_rr,average_t);
    fclose(fid);
end %end for each parameter set
fprintf('one paramenter set of one length value ends£¡');










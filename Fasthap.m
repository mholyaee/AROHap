function Fasthap(varargin)
% Implementation of Fasthap article (Mazrouee 2014)
clc
clear
if nargin==0
    Mpath=uigetdir('D:\Bioinformatics\Hapdata\SurveyDataset\','Select Dataset'); %one can change the file path and file name(for one length value).
    directory=[Mpath,'\exp-100-*-h0.7'];
    D1=dir(directory);
end
if isempty(D1)
    fprintf(['ERROR! Fail to find ',Mpath,'\n']);
    return;
end
Num_paras=length(D1);
for d=1:Num_paras
    D1(d).name%for each parameter set
    %ss=[Mpath,D1(d).name,'\*.m.4.err']
    D=dir([Mpath,'\',D1(d).name,'\*.m.4.err']);
    if isempty(D)
        fprintf('ERROR! Fail to find %s *.m.4.err!\n',D1(d).name);
        return;
    end
    fprintf('Succeed to find %s \\*.m.4.err!\n',D1(d).name);
    %Num_exps=length(D);
    Num_exps=10;
    rrs=zeros(1,Num_exps);
    for i=1:Num_exps  %for each instance
        tStart=tic;
        [M0,m0,n0,H_real]=inputdata(Mpath,D1(d).name,D(i).name,i); % set frags on M0 and target haps in H_real
        [M,m,n,H_assem,Most]=Heter4to2(M0,m0,n0);
        BestChr=zeros(1,m);
        [C1,C2]=FuzzyConflictGraph(M);
        BestChr(C2)=1;
        H_rec=MakeHapbyMajority(BestChr,M);
        H_rec=ImproveHap(H_rec,BestChr,M);%%%%%
        H_assem=CompleteHap(H_rec,H_assem);
        H_assem4=H_assem2to4(H_assem,Most);
        rrs(i)=RR4(H_real,H_assem4);
        tElapsed(i)=toc(tStart);
        fprintf('The instance %d is finished!\n',i);
    end %end for each instance
    fid=fopen(['FastHap_',D1(d).name,'_RR.txt'],'w+');
    for j=1:Num_exps
        fprintf(fid,'%d\t%1.4f\t%d\n',j,rrs(j),tElapsed(j));
    end
    average_rr=mean(rrs);
    fprintf(fid,'%1.4f\n\n',average_rr);
    average_t=mean(tElapsed);
    fprintf(fid,'%1.4f\t%1.4f\n',average_rr,average_t);
    fclose(fid);
end %end for each parameter set
fprintf('one paramenter set of one length value ends£¡');










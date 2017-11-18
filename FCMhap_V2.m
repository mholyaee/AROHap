function FCMhap_V2(varargin)
% Implementation of Fasthap article (Mazrouee 2014)
clc
clear
Pivot1=0.65;
Pivot2=0.35;
dthr1=0.75;
dthr2=0.15;
expo = 2;		% Exponent for U
max_iter = 1000;		% Max. iteration
min_impro = 1e-5;		% Min. improvement
display = 0;		% Display info or not
if nargin==0
    Mpath=uigetdir('D:\Bioinformatics\Hapdata\SurveyDataset\','Select Dataset'); %one can change the file path and file name(for one length value).
    directory=[Mpath,'\exp-700-*-h0.7'];
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
        obj_fcn = zeros(max_iter, 1);
        [M0,m0,n0,H_real]=inputdata(Mpath,D1(d).name,D(i).name,i); % set frags on M0 and target haps in H_real
        [M,m,n,H_assem,Most]=Heter4to2(M0,m0,n0);
        BestChr=zeros(1,m);
        [C1,C2,~]=FCGraph(M,Pivot1);
        BestChr(C2)=1;
        H_rec=MakeHapbyMajority(BestChr,M);
        H_rec=ImproveHap(H_rec,BestChr,M);%%%%%
        H_rec2=H_rec;
        for ind=1:length(H_rec)
            if H_rec(ind)=='t'
                H_rec2(ind)='a';
            else
               H_rec2(ind)='t';
            end
        end
        U = initdist(H_rec,H_rec2,M);% Initial fuzzy partition
        tmp = U.^(-2);      % calculate new U, suppose expo != 1
        U = tmp./(ones(2, 1)*sum(tmp));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        data=mapfag(M);
        % Main loop
        for j = 1:max_iter,
            [U, center, obj_fcn(j)] = stepfcmhap(data, U,expo);
            if display,
                fprintf('Iteration count = %d, obj. fcn = %f\n', j, obj_fcn(j));
            end
            % check termination condition
            if j > 1,
                if abs(obj_fcn(j) - obj_fcn(j-1)) < min_impro, break; end,
            end
        end
        
        iter_n = j;	% Actual number of iterations
        [H_rec,H_rec2]=maphap(center);
        H_assem=CompleteHap(H_rec,H_assem);
        H_assem4=H_assem2to4(H_assem,Most);
        rrs(i)=RR4(H_real,H_assem4);
        tElapsed(i)=toc(tStart);
        fprintf('The instance %d is finished!\n',i);
    end %end for each instance
    fid=fopen(['FCMHapV2_',D1(d).name,'_RR.txt'],'w+');
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










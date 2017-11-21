function [M,m,n,H_real]=inputdata(Mpath,name1,name2,k)  
%input filename
%output SNP matrix M, m, n and real haplotypes H_real
M=[];
filename=[Mpath,'\',name1,'\',name2];
disp(filename);
fidin=fopen(filename);
if fidin==-1
    fprintf('ERROR��fail to open the M file %d!\n',k);
    return;
else
    tline=fgetl(fidin);  
    if ~isempty(tline)   
        M=tline;
    end
    while ~feof(fidin)        
        tline=fgetl(fidin);
        if ~isempty(tline)    
            M=[M;tline];
        end
    end
    fprintf('Succeed to read the M data %d!\n',k);
    fclose(fidin);
end
[m,n]=size(M); 

head=strtok(name2,'m');       
name2_h=strcat(head,'h.4'); 
filename_h=[Mpath,'\',name1,'\',name2_h];
fidin_h=fopen(filename_h);
if fidin_h==-1
    fprintf('ERROR��fail to open the H file %d!\n',k);
    return;
else
    L0=fgetl(fidin_h);   
    if ~isempty(L0)
        H_real(1,:)=L0;
    end
    L1=fgetl(fidin_h);  
    if ~isempty(L1)
        H_real(2,:)=L1;
    end
    fprintf('Succeed to read the H data %d!\n',k);
    fclose(fidin_h);
end

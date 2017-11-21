function H_assem=GetWholeHap(M,P_best,H_assem)
v=P_best;
[m,n]=size(M);    
aaa=sum(v,1);  
m1=aaa(1,1);  
m0=aaa(1,2);  
C0=char(ones(m0,n)*97);   
C1=char(ones(m1,n)*97);
H0=char(ones(1,n)*97); 
H1=char(ones(1,n)*97);
k0=1;
k1=1;
for i=1:m
    if v(i,1)==1    
        C0(k0,:)=M(i,:);
        k0=k0+1;
    else
        C1(k1,:)=M(i,:);
        k1=k1+1;
    end
end
h0=zeros(2,n);  
h1=zeros(2,n);  
for j=1:n       
    for i=1:m0
        if C0(i,j)=='a'
            h0(1,j)=h0(1,j)+1;
        elseif C0(i,j)=='t'
            h0(2,j)=h0(2,j)+1;
        end
    end
    if  h0(1,j)>h0(2,j)
        H0(j)='a';
    elseif h0(1,j)<h0(2,j)
        H0(j)='t';
    else
        H0(j)='-';
    end
end
for j=1:n       
    for i=1:m1
        if C1(i,j)=='a'
            h1(1,j)=h1(1,j)+1;
        elseif C1(i,j)=='t'
            h1(2,j)=h1(2,j)+1;
        end
    end
    if  h1(1,j)>h1(2,j)
        H1(j)='a';
    elseif h1(1,j)<h1(2,j)
        H1(j)='t';
    else
        H1(j)='-';
    end
end
for j=1:n
    if (H0(j)=='-') && (H1(j)~='-')
        if H1(j)=='a'
            H0(j)='t';
        else
            H0(j)='a';
        end
    elseif (H0(j)~='-') && (H1(j)=='-')
        if H0(j)=='a'
            H1(j)='t';
        else
            H1(j)='a';
        end
    elseif (H0(j)=='-') && (H1(j)=='-')  
        if rand(1)>0.5
            H0(j)='a';
            H1(j)='t';
        elseif rand(1)<=0.5
            H0(j)='t';
            H1(j)='a';
        end
    end
end
    H_heter(1,:)=H0;
    H_heter(2,:)=H1;
k=1;
for j=1:size(H_assem,2)
    if H_assem(1,j)=='-'
        H_assem(1,j)=H_heter(1,k);
        H_assem(2,j)=H_heter(2,k);
        k=k+1;
    end
end

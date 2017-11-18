function Hap=MakeHapbyMajority(BestChr,Frags)
[R,C]=size(Frags);
[N,L]=size(BestChr);
for n=1:N
    n1=find(BestChr(n,:)==0);
    n2=find(BestChr(n,:)==1);
    c1='';
    c2='';
    c1=Frags(n1,:);
    c2=Frags(n2,:);
    for cc=1:C
        a1=find(c1(:,cc)=='a');
        t1=find(c1(:,cc)=='t');
        a2=find(c2(:,cc)=='a');
        t2=find(c2(:,cc)=='t');
        if length(a1)+length(t2)>length(t1)+length(a2)
            Hap(cc)='a';
        else
            Hap(cc)='t';
        end
    end
end
end


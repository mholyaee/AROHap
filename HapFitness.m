function Score=HapFitness(CHR,Frags)
[R,C]=size(Frags);
[N,L]=size(CHR);
Score=zeros(1,N);
for n=1:N
    ff=CHR(n,:);
    n1=find(CHR(n,:)==0);
    n2=find(CHR(n,:)==1);
    c1='';
    c2='';
    c1=Frags(n1,:);
    c2=Frags(n2,:);
    temp=0;
    for cc=1:C
        rr=c1(:,cc);
        rr=rr';
        a=find(c1(:,cc)=='a');
        t=find(c1(:,cc)=='t');
        temp=min(length(a),length(t));
        Score(n)=Score(n)+temp;
    end
    temp=0;
    for cc=1:C
        a=find(c2(:,cc)=='a');
        t=find(c2(:,cc)=='t');
        temp=min(length(a),length(t));
        Score(n)=Score(n)+temp;
    end
end


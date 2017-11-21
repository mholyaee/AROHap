function score = MEC(H1,M)
score=0;
[R,~]=size(M);
for h=1:length(H1)
    if H1(h)=='a'
        H2(h)='t';
    else
        H2(h)='a';
    end
end
for r=1:R
    d1=dist(H1,M(r,:));
    d2=dist(H2,M(r,:));
    if d1>d2
        score=d2+score;
    else
        score=d1+score;
    end
end


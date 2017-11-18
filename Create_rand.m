function  CHR=Create_rand(PS,L)
CHR=zeros(PS,L);
for i=1:PS
    for j=1:L
        CHR(i,j)=round(rand(1));
    end
end
end


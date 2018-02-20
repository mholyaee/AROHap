function bud=merge(parent,Larva,a,b,Mask,E)
%called by reproduction
g=b-a+1;
bud=parent;
for i=1:g
    p=rand(1);
    if E==0
        if p<1/(1+log(g))
            bud(a)=Larva(i);
        end
    else
        p2=rand(1);
        if Mask(i)<1 && p2<Mask(i)%p<1/(1+log(g)) && p2<Mask(i)
            bud(a)=Larva(i);
        elseif p<1/(1+log(g))
            bud(a)=Larva(i);
        end
    end
    a=a+1;
end


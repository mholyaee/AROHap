function [Larva,a,b]=ProduceLarva(Parent,L)
%called by reproduction
a=0;
b=0;
while a==0
    a=round(rand(1)*L);
end
while b==0
    b=round(rand(1)*L);
end
if a>b
    temp=a;a=b;b=temp;
end
Larva=Parent(a:b);
temp=ones(1,length(Larva));
Larva=mod(Larva+temp,2);
end


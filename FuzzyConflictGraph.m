function [C1,C2]=FuzzyConflictGraph(frags)

[n,~]=size(frags);
dist=zeros(n,n);
%All Sequences is added to Cluster
for i=1:n
    for j=i+1:n
        dist(i,j)=FuzzyDis(frags(i,:),frags(j,:));
        dist(j,i)=dist(i,j);
    end
end
% I and J are index of two sequnences that their distance is farest!
k=1;
maxdist=max(max(dist));
[I,J]=find(dist==maxdist,1,'first');
[It,Jt]=find(dist==maxdist);

C1(1)=I; % C1 and C2 are clusters
C2(1)=J;
dist(I,J)=0;
C1index=2;
C2index=2;

pivot=0.5;

while Union(C1,C2,n)==1 && maxdist>pivot
    maxdist=max(max(dist));
    [i1,j1]=find(dist==maxdist,1,'first');
    dist(i1,j1)=0;
    dist(j1,i1)=0;
    f1=find(C1==i1);
    f2=find(C1==j1);
    f3=find(C2==i1);
    f4=find(C2==j1);
    ch1=0;
    ch2=0;
    ch3=0;
    ch4=0;
    ch5=0;
    ch6=0;
    
    add=0;
    if length(f1)>0
        C2(C2index)=j1;
        C2index=C2index+1;
        add=1;
        ch1=1;
    end
    if length(f2)>0 && add==0
        C2(C2index)=i1;
        C2index=C2index+1;
        add=1;
        ch2=1;
    end
    if length(f3)>0 && add==0
        C1(C1index)=j1;
        C1index=C1index+1;
        add=1;
        ch3=1;
    end
    if length(f4)>0 && add==0
        C1(C1index)=i1;
        C1index=C1index+1;
        add=1;
        ch4=1;
    end
    if add==0
        temp1(1:length(C1))=i1;
        temp2(1:length(C1))=j1;
        if mean(dist(C1,temp1))<mean(dist(C1,temp2))
            C1(C1index)=i1;
            C2(C2index)=j1;
            C1index=C1index+1;
            C2index=C2index+1;
            add=1;
            ch5=1;
        else
            C1(C1index)=j1;
            C2(C2index)=i1;
            C1index=C1index+1;
            C2index=C2index+1;
            add=1;
            ch6=1;
        end
    end
    C = intersect(C1,C2);
    if length(C)>0
        if ch1==1 || ch2==1
            C2=C2(1:C2index-2);
            C2index=C2index-1;
        elseif ch2==1 || ch3==1
            C1=C1(1:C1index-2);
            C1index=C1index-1;
        else
            C1=C1(1:C1index-2);
            C2=C2(1:C2index-2);
            C1index=C1index-1;
            C2index=C2index-1;
        end
    end
end
C1 = unique(C1);
C2 = unique(C2);
C1index=length(C1)+1;
C2index=length(C2)+1;
if Union(C1,C2,n)==1
    tmp=isinf(1./dist)*100;
    dist=tmp+dist;
end
while Union(C1,C2,n)==1
    ch1=0;
    ch2=0;
    ch3=0;
    ch4=0;
    ch5=0;
    ch6=0;
    mindist=min(min(dist));
    [i2,j2]=find(dist==mindist,1,'first');
    dist(i2,j2)=1000;
    dist(j2,i2)=1000;
    f5=find(C1==j2);
    f6=find(C1==i2);
    f7=find(C2==i2);
    f8=find(C2==j2);
    add=0;
    if length(f5)>0
        C1(C1index)=i2;
        C1index=C1index+1;
        add=1;
        ch1=1;
    end
    if length(f6)>0 && add==0
        C1(C1index)=j2;
        C1index=C1index+1;
        add=1;
        ch2=1;
    end
    if length(f7)>0 && add==0
        C2(C2index)=j2;
        C2index=C2index+1;
        add=1;
        ch3=1;
    end
    if length(f8)>0 && add==0
        C2(C2index)=i2;
        C2index=C2index+1;
        add=1;
        ch4=1;
    end
    if add==0
        temp1(1:length(C1))=i2;
        temp2(1:length(C1))=j2;
        if mean(dist(C1,temp1))+mean(dist(C1,temp2))<mean(dist(C2,temp1))+mean(dist(C2,temp2))
            C1(C1index)=i2;
            C1index=C1index+1;
            C1(C1index)=j2;
            C1index=C1index+1;
            add=1;
            ch5=1;
        else
            C2(C2index)=j2;
            C2index=C2index+1;
            C2(C2index)=i2;
            C2index=C2index+1;
            add=1;
            ch6=1;
        end
    end
    C = intersect(C1,C2);
    if length(C)>0
        if ch1==1 || ch2==1
            C2=C2(1:C2index-2);
            C2index=C2index-1;
        elseif ch2==1 || ch3==1
            C1=C1(1:C1index-2);
            C1index=C1index-1;
        else
            C1=C1(1:C1index-2);
            C2=C2(1:C2index-2);
            C1index=C1index-1;
            C2index=C2index-1;
        end
    end
end
C1 = unique(C1);
C2 = unique(C2);
C1index=length(C1)+1;
C2index=length(C2)+1;


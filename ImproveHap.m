function H_rec=ImproveHap(H_rec,BestChr,frags)
Hnew=H_rec;
MecH_rec=MEC(H_rec,frags);
Last=MecH_rec;
MecHnew=0;
while MecHnew<Last
    C1=find(BestChr==0);
    C2=find(BestChr==1);
    cluster1=frags(C1,:);
    cluster2=frags(C2,:);
    L=length(H_rec);
    % Find centers of clusters
    for cc=1:L
        a1=find(cluster1(:,cc)=='a');
        t1=find(cluster1(:,cc)=='t');
        a2=find(cluster2(:,cc)=='a');
        t2=find(cluster2(:,cc)=='t');
        if length(a1)>length(t1)
            Center1(cc)='a';
        else
            Center1(cc)='t';
        end
        if length(a2)>length(t2)
            Center2(cc)='a';
        else
            Center2(cc)='t';
        end
    end
    % Find frags with max distances from their centers
    [R,~]=size(cluster1);
    dist1=zeros(1,R);
    for i=1:R
        dist1(i)=FuzzyDis(cluster1(i,:),Center1);
    end
    Maxdist1=max(dist1);
    f1=find(dist1==Maxdist1,1,'first');
    %+++++++++++++++++++++++++++++++++++++++++++
    [R,~]=size(cluster2);
    dist2=zeros(1,R);
    for i=1:R
        dist2(i)=FuzzyDis(cluster2(i,:),Center2);
    end
    Maxdist2=max(dist2);
    f2=find(dist2==Maxdist2,1,'first');
    BestChr(f1)=1;
    BestChr(f2)=0;
    Hnew=MakeHapbyMajority(BestChr,frags);
    MecHnew=MEC(Hnew,frags);
    if MecH_rec> MecHnew
        H_rec=Hnew;
        Last=MecH_rec;
        MecH_rec=MecHnew;
    else
        Last=MecHnew;
    end
end
end


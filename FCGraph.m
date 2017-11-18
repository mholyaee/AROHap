function [C1,C2,Mask]=FCGraph(varargin)
%M,Pivot1,Pivot2,dthr1,dthr2
if nargin==1
    frags=varargin(1);
    pivot1=0.6;
    pivot2=0.3;
    dthr1=0.7;
    dthr2=0.2;
elseif nargin==5
    frags=varargin{1};
    pivot1=varargin{2};
    pivot2=varargin{3};
    dthr1=varargin{4};
    dthr2=varargin{5};
elseif nargin==2
    frags=varargin{1};
    pivot1=varargin{2};
        pivot2=0.3;
    dthr1=0.7;
    dthr2=0.2;
end
% indiv=ones(1,n)*-1;
% Mask=ones(1,n);%Mask=ones(1,n);
[n,~]=size(frags);
Mask=zeros(1,n)+1;
dist=zeros(n,n);
%All Sequences is added to Cluster
for i=1:n
    for j=i+1:n
        dist(i,j)=FuzzyDis(frags(i,:),frags(j,:));
        dist(j,i)=dist(i,j);
    end
end
%xlswrite('dist.xls',dist);
% I and J are index of two sequnences that their distance is farest!
k=1;
maxdist=max(max(dist));
[I,J]=find(dist==maxdist,1,'first');
[It,Jt]=find(dist==maxdist);

%sparse
C1(1)=I; % C1 and C2 are clusters
C2(1)=J;
dist(I,J)=0;
C1index=2;
C2index=2;

% j=length(sparse);
%pivot=0.5;
%[R,C]=size(M);

while Union(C1,C2,n)==1 && maxdist>pivot1%&& (d1>pivot && d2>pivot)%&& (length(C1)+length(C2))/n<=THR
    maxdist=max(max(dist));
    %mindist=min(min(dist));
    [i1,j1]=find(dist==maxdist,1,'first');
    %[i2,j2]=find(dist==mindist,'first');
    dist(i1,j1)=0;
    dist(j1,i1)=0;
    %dist(i2,j2)=0;
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
        if maxdist>dthr1
            Mask(i1)= Mask(i1)+1;
            Mask(j1)= Mask(j1)+1;
        end
    end
    if length(f2)>0 && add==0
        C2(C2index)=i1;
        C2index=C2index+1;
        add=1;
        ch2=1;
        if maxdist>dthr1
            Mask(i1)= Mask(i1)+1;
            Mask(j1)= Mask(j1)+1;
        end
    end
    if length(f3)>0 && add==0
        C1(C1index)=j1;
        C1index=C1index+1;
        add=1;
        ch3=1;
        if maxdist>dthr1
            Mask(i1)= Mask(i1)+1;
            Mask(j1)= Mask(j1)+1;
        end
    end
    if length(f4)>0 && add==0
        C1(C1index)=i1;
        C1index=C1index+1;
        add=1;
        ch4=1;
        if maxdist>dthr1
            Mask(i1)= Mask(i1)+1;
            Mask(j1)= Mask(j1)+1;
        end
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
        %fprintf('error');
        if ch1==1 || ch2==1
            C2=C2(1:C2index-2);
            C2index=C2index-1;
            if maxdist>dthr1
                Mask(i1)= Mask(i1)-1;
                Mask(j1)= Mask(j1)-1;
            end
        elseif ch2==1 || ch3==1
            C1=C1(1:C1index-2);
            C1index=C1index-1;
            if maxdist>dthr1
                Mask(i1)= Mask(i1)-1;
                Mask(j1)= Mask(j1)-1;
            end
        else
            C1=C1(1:C1index-2);
            C2=C2(1:C2index-2);
            C1index=C1index-1;
            C2index=C2index-1;
        end
    end
    %+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
end
%C = intersect(C1,C2);
C1 = unique(C1);
C2 = unique(C2);
Mask=1./Mask;
% C1index=length(C1)+1;
% C2index=length(C2)+1;
% if Union(C1,C2,n)==1
% dist=double(subs(dist,0.0,100.5));end
% %dist(i,j)=1000;
% while Union(C1,C2,n)==1
%     ch1=0;
%     ch2=0;
%     ch3=0;
%     ch4=0;
%     ch5=0;
%     ch6=0;
%     %[i,j]=find(dist>0 & dist<0.5);
%     mindist=min(min(dist));
%     [i2,j2]=find(dist==mindist,1,'first');
%     dist(i2,j2)=1000;
%     dist(j2,i2)=1000;
%     f5=find(C1==j2);
%     f6=find(C1==i2);
%     f7=find(C2==i2);
%     f8=find(C2==j2);
%     add=0;
%     if length(f5)>0
%         C1(C1index)=i2;
%         C1index=C1index+1;
%         add=1;
%         ch1=1;
%     end
%     if length(f6)>0 && add==0
%         C1(C1index)=j2;
%         C1index=C1index+1;
%         add=1;
%         ch2=1;
%     end
%     if length(f7)>0 && add==0
%         C2(C2index)=j2;
%         C2index=C2index+1;
%         add=1;
%         ch3=1;
%     end
%     if length(f8)>0 && add==0
%         C2(C2index)=i2;
%         C2index=C2index+1;
%         add=1;
%         ch4=1;
%     end
%     if add==0
%         temp1(1:length(C1))=i2;
%         temp2(1:length(C1))=j2;
%         if mean(dist(C1,temp1))+mean(dist(C1,temp2))<mean(dist(C2,temp1))+mean(dist(C2,temp2))
%             C1(C1index)=i2;
%             C1index=C1index+1;
%             C1(C1index)=j2;
%             C1index=C1index+1;
%             add=1;
%             ch5=1;
%         else
%             C2(C2index)=j2;
%             C2index=C2index+1;
%             C2(C2index)=i2;
%             C2index=C2index+1;
%             add=1;
%             ch6=1;
%         end
%     end
%     C = intersect(C1,C2);
%     if length(C)>0
%         %fprintf('error');
%         if ch1==1 || ch2==1
%             C2=C2(1:C2index-2);
%             C2index=C2index-1;
%         elseif ch2==1 || ch3==1
%             C1=C1(1:C1index-2);
%             C1index=C1index-1;
%         else
%             C1=C1(1:C1index-2);
%             C2=C2(1:C2index-2);
%             C1index=C1index-1;
%             C2index=C2index-1;
%         end
%     end
% end
% C1 = unique(C1);
% C2 = unique(C2);
% C1index=length(C1)+1;
% C2index=length(C2)+1;


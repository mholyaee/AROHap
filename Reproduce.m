function  [bud]=Reproduce(CHR,Mask)
% called by CAROHAP
% frags are changed by reproduction2
%[FR,FC]=size(Frags);
%budfrags=Frags;
[~,C]=size(CHR);
bud=zeros(1,C);
Permisson=0;% Permission of Mask
SW=1;
if SW==1
    [Larva,a,b]=ProduceLarva(CHR,C);
    %expolitaion
    bud=merge(CHR,Larva,a,b,Mask,Permisson);
end
end



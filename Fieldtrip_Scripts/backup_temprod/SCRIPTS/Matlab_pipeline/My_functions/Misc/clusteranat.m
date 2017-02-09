
function [FIND,BIND,VIND,LIND,RIND,FCHANS,BCHANS,VCHANS,LCHANS,RCHANS] = clusteranat(tag)

% set root
root = SetPath(tag);

Findex = [92 91 81 52 51 93 94 82 53 54 102 101 61 103 62 64];
Bindex = [254 213 214 174 251 233 212 193 173 232 234 211 192 194 231 203 204 191 223 202 201 184 224 183];
Vindex = [221 73 74 182 114 72 71 43 111 104 63 42];
Lindex = [33 32 31 41 22 34 12 11 21 13 14 44 23 24 151 154 181 162 161 152 153 163 164 172 171];
Rindex = [121 142 141 122 123 124 143 144 132 131 112 262 261 133 134 113 263 264 242 241 222 253 252 243 244];

Clusters{1} = Findex;
Clusters{2} = Bindex;
Clusters{3} = Vindex;
Clusters{4} = Lindex;
Clusters{5} = Rindex;

for j = 1:length(Findex)
    if Findex(j) < 100
        M_Fchans(1,j)           = cellstr(['MEG0' num2str(Findex(j)) '1']);
        G_Fchans(1,j)           = cellstr(['MEG0' num2str(Findex(j)) '2']);
        G_Fchans(1,j+length(Findex)) = cellstr(['MEG0' num2str(Findex(j)) '3']);
    else
        M_Fchans(1,j)           = cellstr(['MEG' num2str(Findex(j)) '1' ]);
        G_Fchans(1,j)           = cellstr(['MEG' num2str(Findex(j)) '2' ]);
        G_Fchans(1,j+length(Findex)) = cellstr(['MEG' num2str(Findex(j)) '3' ]);
    end
end
for j = 1:length(Bindex)
    if Bindex(j) < 100
        M_Bchans(1,j)           = cellstr(['MEG0' num2str(Bindex(j)) '1']);
        G_Bchans(1,j)           = cellstr(['MEG0' num2str(Bindex(j)) '2']);
        G_Bchans(1,j+length(Bindex)) = cellstr(['MEG0' num2str(Bindex(j)) '3']);
    else
        M_Bchans(1,j)           = cellstr(['MEG' num2str(Bindex(j)) '1' ]);
        G_Bchans(1,j)           = cellstr(['MEG' num2str(Bindex(j)) '2' ]);
        G_Bchans(1,j+length(Bindex)) = cellstr(['MEG' num2str(Bindex(j)) '3' ]);
    end
end
for j = 1:length(Vindex)
    if Vindex(j) < 100
        M_Vchans(1,j)           = cellstr(['MEG0' num2str(Vindex(j)) '1']);
        G_Vchans(1,j)           = cellstr(['MEG0' num2str(Vindex(j)) '2']);
        G_Vchans(1,j+length(Vindex)) = cellstr(['MEG0' num2str(Vindex(j)) '3']);
    else
        M_Vchans(1,j)           = cellstr(['MEG' num2str(Vindex(j)) '1' ]);
        G_Vchans(1,j)           = cellstr(['MEG' num2str(Vindex(j)) '2' ]);
        G_Vchans(1,j+length(Vindex)) = cellstr(['MEG' num2str(Vindex(j)) '3' ]);
    end
end
for j = 1:length(Lindex)
    if Lindex(j) < 100
        M_Lchans(1,j)           = cellstr(['MEG0' num2str(Lindex(j)) '1']);
        G_Lchans(1,j)           = cellstr(['MEG0' num2str(Lindex(j)) '2']);
        G_Lchans(1,j+length(Lindex)) = cellstr(['MEG0' num2str(Lindex(j)) '3']);
    else
        M_Lchans(1,j)           = cellstr(['MEG' num2str(Lindex(j)) '1' ]);
        G_Lchans(1,j)           = cellstr(['MEG' num2str(Lindex(j)) '2' ]);
        G_Lchans(1,j+length(Lindex)) = cellstr(['MEG' num2str(Lindex(j)) '3' ]);
    end
end
for j = 1:length(Rindex)
    if Rindex(j) < 100
        M_Rchans(1,j)           = cellstr(['MEG0' num2str(Rindex(j)) '1']);
        G_Rchans(1,j)           = cellstr(['MEG0' num2str(Rindex(j)) '2']);
        G_Rchans(1,j+length(Rindex)) = cellstr(['MEG0' num2str(Rindex(j)) '3']);
    else
        M_Rchans(1,j)           = cellstr(['MEG' num2str(Rindex(j)) '1' ]);
        G_Rchans(1,j)           = cellstr(['MEG' num2str(Rindex(j)) '2' ]);
        G_Rchans(1,j+length(Rindex)) = cellstr(['MEG' num2str(Rindex(j)) '3' ]);
    end
end

% define Mags, Grads1 & Grads2
[A B] = xlsread([root '/SCRIPTS/Layouts_fieldtrip/NM306gradlow.xls']);
G1 = cell(1,102); 
for a = 1:102
    if A(a,1) < 1000
        G1(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G1(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end
[A B] = xlsread([root '/SCRIPTS/Layouts_fieldtrip/NM306mags.xls']);
M = cell(1,102); 
for a = 1:102
    if A(a,1) < 1000
        M(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        M(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end
[A B] = xlsread([root '/SCRIPTS/Layouts_fieldtrip/NM306GradLat.xls']);
G2 = cell(1,102); 
for a = 1:102
    if A(a,1) < 1000
        G2(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G2(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

% matchs channels for grad1 & grads2
a1 = 1;
a2 = 1;
a3 = 1;
for i = 1:(length(G_Fchans))
   if sum(ismember(G1,G_Fchans{i}))
       G1_Find(a1) = find(ismember(G1,G_Fchans{i}));
       a1 = a1+1;
   else 
       G2_Find(a2) = find(ismember(G2,G_Fchans{i}));
       a2 = a2 + 1;
   end
end
for i = 1:(length(M_Fchans))
   if sum(ismember(M,M_Fchans{i}))
       M_Find(a3) = find(ismember(M,M_Fchans{i}));
       a3 = a3+1;
   end
end
a1 = 1;
a2 = 1;
a3 = 1;
for i = 1:(length(G_Bchans))
   if sum(ismember(G1,G_Bchans{i}))
       G1_Bind(a1) = find(ismember(G1,G_Bchans{i}));
       a1 = a1+1;
   else 
       G2_Bind(a2) = find(ismember(G2,G_Bchans{i}));
       a2 = a2 + 1;
   end
end
for i = 1:(length(M_Bchans))
   if sum(ismember(M,M_Bchans{i}))
       M_Bind(a3) = find(ismember(M,M_Bchans{i}));
       a3 = a3+1;
   end
end
a1 = 1;
a2 = 1;
a3 = 1;
for i = 1:(length(G_Vchans))
   if sum(ismember(G1,G_Vchans{i}))
       G1_Vind(a1) = find(ismember(G1,G_Vchans{i}));
       a1 = a1+1;
   else 
       G2_Vind(a2) = find(ismember(G2,G_Vchans{i}));
       a2 = a2 + 1;
   end
end
for i = 1:(length(M_Vchans))
   if sum(ismember(M,M_Vchans{i}))
       M_Vind(a3) = find(ismember(M,M_Vchans{i}));
       a3 = a3+1;
   end
end
a1 = 1;
a2 = 1;
a3 = 1;
for i = 1:(length(G_Lchans))
   if sum(ismember(G1,G_Lchans{i}))
       G1_Lind(a1) = find(ismember(G1,G_Lchans{i}));
       a1 = a1+1;
   else 
       G2_Lind(a2) = find(ismember(G2,G_Lchans{i}));
       a2 = a2 + 1;
   end
end
for i = 1:(length(M_Lchans))
   if sum(ismember(M,M_Lchans{i}))
       M_Lind(a3) = find(ismember(M,M_Lchans{i}));
       a3 = a3+1;
   end
end
a1 = 1;
a2 = 1;
a3 = 1;
for i = 1:(length(G_Rchans))
   if sum(ismember(G1,G_Rchans{i}))
       G1_Rind(a1) = find(ismember(G1,G_Rchans{i}));
       a1 = a1+1;
   else 
       G2_Rind(a2) = find(ismember(G2,G_Rchans{i}));
       a2 = a2 + 1;
   end
end
for i = 1:(length(M_Rchans))
   if sum(ismember(M,M_Rchans{i}))
       M_Rind(a3) = find(ismember(M,M_Rchans{i}));
       a3 = a3+1;
   end
end

G1_Fchans = G1(G1_Find);
G1_Bchans = G1(G1_Bind);
G1_Vchans = G1(G1_Vind);
G1_Lchans = G1(G1_Lind);
G1_Rchans = G1(G1_Rind);

G2_Fchans = G1(G2_Find);
G2_Bchans = G1(G2_Bind);
G2_Vchans = G1(G2_Vind);
G2_Lchans = G1(G2_Lind);
G2_Rchans = G1(G2_Rind);

FCHANS = [M_Fchans ; G1_Fchans ; G2_Fchans];
BCHANS = [M_Bchans ; G1_Bchans ; G2_Bchans];
VCHANS = [M_Vchans ; G1_Vchans ; G2_Vchans];
LCHANS = [M_Lchans ; G1_Lchans ; G2_Lchans];
RCHANS = [M_Rchans ; G1_Rchans ; G2_Rchans];

FIND = [M_Find ; G1_Find ; G2_Find];
BIND = [M_Bind ; G1_Bind ; G2_Bind];
VIND = [M_Vind ; G1_Vind ; G2_Vind];
LIND = [M_Lind ; G1_Lind ; G2_Lind];
RIND = [M_Rind ; G1_Rind ; G2_Rind];

% 
% topoplot(cfg, datavector)
% topoplot(cfg, X, Y, datavector)
% topoplot(cfg, X, Y, datavector, Labels)
% 





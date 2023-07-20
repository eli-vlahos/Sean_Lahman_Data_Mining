use baseballdb;

select h.playerID, 
		b.B_AB, b.B_R, b.B_H, b.B_HR, b.B_RBI, b.B_SB, b.B_SO,
        pi.PI_W, pi.PI_L, pi.PI_CG, pi.PI_SV, pi.PI_H, 
			pi.PI_HR, pi.PI_BB, pi.PI_SO, pi.PI_AVG_ERA, pi.PI_R,
		fi.FI_GS, fi.FI_InnOuts, fi.FI_A, fi.FI_E, fi.FI_DP,
        asf.ASF_NUM_YEARS,
		A.A_G_ALL, A.A_GP,
        h.inducted
from 
(select playerID, max(inducted) as inducted 
	from HallOfFame as hof
	group by playerID) as h
left join 
(select playerID, sum(AB) as B_AB, sum(R) as B_R, 
		sum(H) as B_H, sum(2B) as 2B, sum(3B) as 3B, sum(HR) as B_HR, 
		sum(RBI) as B_RBI, sum(SB) as B_SB, sum(SO) as B_SO
	from Batting
    group by playerID) as b on h.playerID = b.playerID
left join
(select playerID, sum(W) as PI_W, sum(L) as PI_L, 
		sum(GS) as PI_GS, sum(CG) as PI_CG, 
		sum(SHO) as PI_SHO, sum(SV) as PI_SV, sum(IPOuts) as PI_IPOuts, 
        sum(H) as PI_H, sum(HR) as PI_HR, 
        sum(BB) as PI_BB, sum(SO) as PI_SO, avg(ERA) as PI_AVG_ERA, sum(R) as PI_R
	from Pitching 
    group by playerID) as pi on h.playerID = pi.playerID
left join
(select playerID, sum(GS) as FI_GS, sum(InnOuts) as FI_InnOuts,
		sum(A) as FI_A, sum(E) as FI_E, sum(DP) as FI_DP
	from Fielding
    group by playerID) as fi on h.playerID = fi.playerID
left join
(select playerID, count(distinct yearID) as ASF_NUM_YEARS
	from AllStarFull
    group by playerID) as asf on h.playerID = asf.playerID
left join 
(select playerID, sum(G_all) as A_G_ALL, sum(G_p) as A_GP
	from Appearances
    group by playerID) as A on h.playerID = A.playerID
;

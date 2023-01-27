
/* TPC_H  Query 2 - Minimum Cost Supplier */ --20 secs
SELECT s_acctbal
	,s_name
	,n_name
	,p_partkey
	,p_mfgr
	,s_address
	,s_phone
	s_comment
from
     TPC_DV_OPT.SAT_SUPPLIER         sat_s
join TPC_DV_OPT.REF_NATION           ref_n  on ref_n.NATIONCODE                  = sat_s.NATIONCODE
join TPC_DV_OPT.REF_REGION           ref_r  on ref_r.REGIONCODE              = ref_n.REGIONCODE
join TPC_DV_OPT.LNK_PART_SUPPLIER    lnk_ps on lnk_ps.DVS_HUB_SUPPLIER      = sat_s.DVS_HUB_SUPPLIER
join TPC_DV_OPT.SAT_LNK_PART_SUPPLIER sat_ps on sat_ps.DVS_LNK_PART_SUPPLIER = lnk_ps.DVS_LNK_PART_SUPPLIER
join TPC_DV_OPT.HUB_PART             hub_po on hub_po.DVS_HUB_PART           = lnk_ps.DVS_HUB_PART
join TPC_DV_OPT.SAT_PART             sat_p  on sat_p.DVS_HUB_PART           = hub_po.DVS_HUB_PART
where
	    p_size = 34
	and p_type like '%COPPER'
	and r_name = 'MIDDLE EAST'
	and ps_supplycost = (
		select
			min(ps_supplycost)
		from
			  TPC_DV_OPT.REF_NATION ref_n
         join TPC_DV_OPT.REF_REGION           ref_r  on ref_r.REGIONCODE             = ref_n.REGIONCODE
         join TPC_DV_OPT.SAT_SUPPLIER         sat_su on sat_su.NATIONCODE            = ref_n.NATIONCODE
         join TPC_DV_OPT.LNK_PART_SUPPLIER    lnk_ps on lnk_ps.DVS_HUB_SUPPLIER      = sat_su.DVS_HUB_SUPPLIER
         join TPC_DV_OPT.SAT_LNK_PART_SUPPLIER sat_ps on sat_ps.DVS_LNK_PART_SUPPLIER = lnk_ps.DVS_LNK_PART_SUPPLIER
         join TPC_DV_OPT.HUB_PART             hub_p  on hub_p.DVS_HUB_PART           = lnk_ps.DVS_HUB_PART
         join TPC_DV_OPT.SAT_PART             sat_p  on sat_p.DVS_HUB_PART           = hub_p.DVS_HUB_PART
		where r_name = 'MIDDLE EAST'
          and p_type like '%COPPER'
          and p_size = 16
          and hub_po.p_partkey   = hub_p.p_partkey
	)
order by
	s_acctbal desc,
	n_name,
	s_name,
	p_partkey
LIMIT 100
;
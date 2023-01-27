
--
/*Q5 DVopt*/ select -- 340 secs
	nation,
	o_year,
	sum(amount) as sum_profit
from
	(
		select
			n_name as nation,
			extract(year from o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
		from
			     TPC_DV_OPT.REF_NATION            ref_n
            inner join TPC_DV_OPT.SAT_SUPPLIER          sat_s    on sat_s.NATIONCODE             = ref_n.NATIONCODE
            inner join TPC_DV_OPT.LNK_PART_SUPPLIER     lnk_ps   on lnk_ps.DVS_HUB_SUPPLIER      = sat_s.DVS_HUB_SUPPLIER
            inner join TPC_DV_OPT.SAT_LNK_PART_SUPPLIER sat_ps   on sat_ps.DVS_LNK_PART_SUPPLIER = lnk_ps.DVS_LNK_PART_SUPPLIER
            inner join TPC_DV_OPT.SAT_PART              sat_p    on sat_p.DVS_HUB_PART           = lnk_ps.DVS_HUB_PART
            inner join TPC_DV_OPT.LNK_LINE_ITEM         lnk_li   on lnk_li.DVS_HUB_SUPPLIER      = lnk_ps.DVS_HUB_SUPPLIER and lnk_li.DVS_HUB_PART          = lnk_ps.DVS_HUB_PART
            inner join TPC_DV_OPT.SAT_LNK_LINE_ITEM     sat_li   on sat_li.DVS_LNK_LINE_ITEM     = lnk_li.DVS_LNK_LINE_ITEM
            inner join TPC_DV_OPT.SAT_ORDER             sat_o    on sat_o.DVS_HUB_ORDER          = lnk_li.DVS_HUB_ORDER
	   where
			p_name like '%green%'
	) as profit
group by
	nation,
	o_year
order by
	nation,
	o_year desc;
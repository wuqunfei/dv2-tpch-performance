
/*Q7 DVopt*/ select -- 90 secs
	o_year,
	sum(
		case when nation = 'ARGENTINA' then volume else 0 end
	) / sum(
		volume
	) as mkt_share
from
	(
		select
			extract(
					year
				from
					o_orderdate
			) as o_year,
			l_extendedprice * (
				1 - l_discount
			) as volume,
			ref_n2.n_name as nation
		from
			TPC_DV_OPT.REF_NATION ref_n1 INNER join TPC_DV_OPT.REF_REGION ref_r on ref_n1.REGIONCODE = ref_r.REGIONCODE
			INNER join TPC_DV_OPT.SAT_CUSTOMER sat_cu on ref_n1.NATIONCODE = sat_cu.NATIONCODE
			INNER join TPC_DV_OPT.LNK_CUSTOMER_ORDER lco on sat_cu.DVS_HUB_CUSTOMER = lco.DVS_HUB_CUSTOMER
			INNER join TPC_DV_OPT.SAT_ORDER so on so.DVS_HUB_ORDER = lco.DVS_HUB_ORDER
			INNER join TPC_DV_OPT.LNK_LINE_ITEM lli on lli.DVS_HUB_ORDER = lco.DVS_HUB_ORDER
			INNER join TPC_DV_OPT.SAT_LNK_LINE_ITEM slli on slli.DVS_LNK_LINE_ITEM = lli.DVS_LNK_LINE_ITEM
			INNER join TPC_DV_OPT.LNK_PART_SUPPLIER lps on lps.DVS_HUB_SUPPLIER = lli.DVS_HUB_SUPPLIER and lps.DVS_HUB_PART = lli.DVS_HUB_PART
			INNER join TPC_DV_OPT.SAT_PART sp on sp.DVS_HUB_PART = lps.DVS_HUB_PART
			INNER join TPC_DV_OPT.SAT_SUPPLIER sat_su on sat_su.DVS_HUB_SUPPLIER = lps.DVS_HUB_SUPPLIER
			INNER join TPC_DV_OPT.REF_NATION ref_n2 on sat_su.NATIONCODE = ref_n2.NATIONCODE
		where
			r_name = 'AMERICA' and
			o_orderdate between date '1995-01-01' and
			date '1996-12-31' and
			p_type = 'LARGE BURNISHED BRASS'
	) as all_nations
group by
	o_year
order by
	o_year;

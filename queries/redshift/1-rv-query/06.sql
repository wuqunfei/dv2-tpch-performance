
/* TPC_H  Query 6 - Forecasting Revenue Change */
/*HOTQ13 DVopt*/ select -- 6 secs
	sum(l_extendedprice * l_discount) as revenue
from
	TPC_DV_OPT.SAT_LNK_LINE_ITEM
where
	l_shipdate >= date '1994-01-01'
	and l_shipdate < cast(DATE '1994-01-01' + interval '1 year' AS DATE)
	and l_discount between 0.05 - 0.01 and 0.05 + 0.01
	and l_quantity < 25;

/* TPC_H  Query 7 - Volume Shipping */
--SELECT supp_nation
--	,cust_nation
--	,l_year
--	,sum(volume) AS revenue
--FROM (
--	SELECT sat_n1.n_name AS supp_nation
--		,sat_n2.n_name AS cust_nation
--		,extract(year FROM l_shipdate) AS l_year
--		,l_extendedprice * (1 - l_discount) AS volume
--	FROM dv2.SAT_LNK_LINE_ITEM sat_li
--	INNER JOIN dv2.LNK_LINE_ITEM lnk_li ON lnk_li.DVS_LNK_LINE_ITEM = sat_li.DVS_LNK_LINE_ITEM
--	INNER JOIN dv2.LNK_PART_SUPPLIER lnk_ps ON lnk_ps.DVS_LNK_PART_SUPPLIER = lnk_li.DVS_LNK_PART_SUPPLIER
--	INNER JOIN dv2.LNK_SUPPLIER_NATION lnk_sn ON lnk_sn.DVS_HUB_SUPPLIER = lnk_ps.DVS_HUB_SUPPLIER
--	INNER JOIN dv2.SAT_NATION sat_n1 ON sat_n1.DVS_HUB_NATION = lnk_sn.DVS_HUB_NATION
--	INNER JOIN dv2.LNK_CUSTOMER_ORDER lnk_co ON lnk_co.DVS_HUB_ORDER = lnk_li.DVS_HUB_ORDER
--	INNER JOIN dv2.LNK_CUSTOMER_NATION lnk_cn ON lnk_cn.DVS_HUB_CUSTOMER = lnk_co.DVS_HUB_CUSTOMER
--	INNER JOIN dv2.SAT_NATION sat_n2 ON sat_n2.DVS_HUB_NATION = lnk_cn.DVS_HUB_NATION
--	WHERE (
--			(
--				sat_n1.n_name = 'UNITED STATES'
--				AND sat_n2.n_name = 'JAPAN'
--				)
--			OR (
--				sat_n1.n_name = 'JAPAN'
--				AND sat_n2.n_name = 'UNITED STATES'
--				)
--			)
--		AND l_shipdate BETWEEN DATE '1995-01-01'
--			AND DATE '1996-12-31'
--	) AS shipping
--GROUP BY supp_nation
--	,cust_nation
--	,l_year
--ORDER BY supp_nation
--	,cust_nation
--	,l_year;
/*Q16 DVopt*/ select  --213 secs
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
from
	(
		select
			ref_n1.n_name as supp_nation,
			ref_n2.n_name as cust_nation,
			extract(year from l_shipdate) as l_year,
			l_extendedprice * (1 - l_discount) as volume
		from   TPC_DV_OPT.SAT_LNK_LINE_ITEM   sat_li
          join TPC_DV_OPT.LNK_LINE_ITEM       lnk_li  on lnk_li.DVS_LNK_LINE_ITEM                 = sat_li.DVS_LNK_LINE_ITEM
          join TPC_DV_OPT.LNK_PART_SUPPLIER   lnk_ps  on lnk_ps.DVS_HUB_SUPPLIER = lnk_li.DVS_HUB_SUPPLIER and lnk_ps.DVS_HUB_PART = lnk_li.DVS_HUB_PART
          join TPC_DV_OPT.SAT_SUPPLIER        sat_su  on sat_su.DVS_HUB_SUPPLIER      = lnk_ps.DVS_HUB_SUPPLIER
          join TPC_DV_OPT.REF_NATION          ref_n1  on ref_n1.NATIONCODE                 = sat_su.NATIONCODE

          join TPC_DV_OPT.LNK_CUSTOMER_ORDER  lnk_co  on lnk_co.DVS_HUB_ORDER         = lnk_li.DVS_HUB_ORDER
          join TPC_DV_OPT.SAT_CUSTOMER        sat_cu  on sat_cu.DVS_HUB_CUSTOMER      = lnk_co.DVS_HUB_CUSTOMER
          join TPC_DV_OPT.REF_NATION          ref_n2  on ref_n2.NATIONCODE            = sat_cu.NATIONCODE
		where
		    (
				(ref_n1.n_name = 'IRAQ' and ref_n2.n_name = 'CHINA')
				or (ref_n1.n_name = 'CHINA' and ref_n2.n_name = 'IRAQ')
			)
			and l_shipdate between date '1995-01-01' and date '1996-12-31'
	) as shipping
group by
	supp_nation,
	cust_nation,
	l_year
order by
	supp_nation,
	cust_nation,
	l_year;


/* TPC_H  Query 13 - Customer Distribution */
WITH cte --447
AS (
	SELECT hub_order.DVS_HUB_ORDER
		,O_ORDERKEY
	FROM TPC_DV_OPT.HUB_ORDER hub_order
	INNER JOIN TPC_DV_OPT.SAT_ORDER sat_order ON sat_order.DVS_HUB_ORDER = hub_order.DVS_HUB_ORDER
		AND O_COMMENT NOT LIKE '%special%requests%'
	)
SELECT C_COUNT
	,COUNT(*) AS CUSTDIST
FROM (
	SELECT C_CUSTKEY
		,COUNT(O_ORDERKEY)
	FROM TPC_DV_OPT.SAT_CUSTOMER sat_cust
	INNER JOIN TPC_DV_OPT.HUB_CUSTOMER hub_c ON hub_c.DVS_HUB_CUSTOMER = sat_cust.DVS_HUB_CUSTOMER
	LEFT JOIN TPC_DV_OPT.LNK_CUSTOMER_ORDER lnk_custorder ON lnk_custorder.DVS_HUB_CUSTOMER = sat_cust.DVS_HUB_CUSTOMER
	LEFT JOIN cte c ON c.DVS_HUB_ORDER = lnk_custorder.DVS_HUB_ORDER
	GROUP BY C_CUSTKEY
	) AS C_ORDERS(C_CUSTKEY, C_COUNT)
GROUP BY C_COUNT
ORDER BY CUSTDIST DESC
	,C_COUNT DESC;


/* TPC_H  Query 15 - Create View for Top Supplier Query */
 WITH revenue1 --100 secs
AS (
	SELECT hub_s.dvs_hub_supplier
	,sat_s.s_name
	,sat_s.s_address
	,sat_s.s_phone
	,hub_s.s_suppkey
	,sum(l_extendedprice * (1 - l_discount)) AS total_revenue
	FROM  tpc_dv_opt.hub_supplier hub_s
	inner join tpc_dv_opt.SAT_SUPPLIER sat_s on hub_s.dvs_hub_supplier  = sat_s.dvs_hub_supplier
	--INNER JOIN tpc_dv_opt.LNK_PART_SUPPLIER lnk_ps ON lnk_ps.DVS_HUB_SUPPLIER = hub_s.DVS_HUB_SUPPLIER
	INNER JOIN tpc_dv_opt.LNK_LINE_ITEM lnk_li ON lnk_li.dvs_hub_supplier  = sat_s.dvs_hub_supplier
	INNER JOIN tpc_dv_opt.SAT_LNK_LINE_ITEM sat_li ON sat_li.DVS_LNK_LINE_ITEM = lnk_li.DVS_LNK_LINE_ITEM
	WHERE L_SHIPDATE >= '1995-02-01'
		AND L_SHIPDATE < cast(DATE '1995-02-01' + interval '3 months' AS DATE)
	GROUP BY  hub_s.dvs_hub_supplier
	,sat_s.s_name
	,sat_s.s_address
	,sat_s.s_phone
	,hub_s.s_suppkey
	)
select *
from (select revenue1.*, dense_rank () over ( order by total_revenue) revenue_rank
      from revenue1 )
where revenue_rank = 1 ;
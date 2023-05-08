
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

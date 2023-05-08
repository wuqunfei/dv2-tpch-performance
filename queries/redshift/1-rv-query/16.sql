
/* TPC_H  Query 16 - Parts/Supplier Relationship */
SELECT p_brand -- 16 secs
	,p_type
	,p_size
	,count(DISTINCT s_suppkey) AS supplier_cnt
FROM tpc_dv_opt.SAT_PART sat_part
INNER JOIN tpc_dv_opt.LNK_PART_SUPPLIER lnk_partsupp ON sat_part.DVS_HUB_PART = lnk_partsupp.DVS_HUB_PART
INNER JOIN tpc_dv_opt.HUB_SUPPLIER hub_supp ON hub_supp.DVS_HUB_SUPPLIER = lnk_partsupp.DVS_HUB_SUPPLIER
INNER JOIN tpc_dv_opt.SAT_SUPPLIER sat_supp ON hub_supp.DVS_HUB_SUPPLIER = sat_supp.DVS_HUB_SUPPLIER
WHERE p_brand <> 'Brand#23'
	AND p_type NOT LIKE 'MEDIUM ANODIZED%'
	AND p_size IN (
		1
		,32
		,33
		,46
		,7
		,42
		,21
		,40
		)
	AND s_comment NOT LIKE '%Customer%Complaints%'
GROUP BY p_brand
	,p_type
	,p_size
ORDER BY supplier_cnt DESC
	,p_brand
	,p_type
	,p_size;
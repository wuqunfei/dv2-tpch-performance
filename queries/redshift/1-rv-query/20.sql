


/* TPC_H  Query 20 - Potential Part Promotion */
SELECT s_name --65 secs
	,s_address
FROM tpc_dv_opt.SAT_SUPPLIER sat_s
INNER JOIN tpc_dv_opt.HUB_SUPPLIER hub_s ON hub_s.DVS_HUB_SUPPLIER = sat_s.DVS_HUB_SUPPLIER
--INNER JOIN tpc_dv_opt.LNK_SUPPLIER_NATION lnk_sn ON lnk_sn.DVS_HUB_SUPPLIER = hub_s.DVS_HUB_SUPPLIER
INNER JOIN tpc_dv_opt.ref_nation sat_n ON sat_n.nationcode  = SAT_S.nationcode
WHERE hub_s.DVS_HUB_SUPPLIER IN (
		SELECT hub_s.DVS_HUB_SUPPLIER
		FROM tpc_dv_opt.HUB_SUPPLIER hub_s
		INNER JOIN tpc_dv_opt.LNK_PART_SUPPLIER lnk_ps ON lnk_ps.DVS_HUB_SUPPLIER = hub_s.DVS_HUB_SUPPLIER
		INNER JOIN tpc_dv_opt.SAT_LNK_PART_SUPPLIER sat_ps ON sat_ps.DVS_LNK_PART_SUPPLIER = lnk_ps.DVS_LNK_PART_SUPPLIER
		INNER JOIN tpc_dv_opt.HUB_PART hub_p ON hub_p.DVS_HUB_PART = lnk_ps.DVS_HUB_PART
		WHERE hub_p.DVS_HUB_PART IN (
				SELECT hub_p.DVS_HUB_PART
				FROM tpc_dv_opt.SAT_PART sat_p
				INNER JOIN tpc_dv_opt.HUB_PART hub_p ON hub_p.DVS_HUB_PART = sat_p.DVS_HUB_PART
				WHERE p_name LIKE 'olive%'
				)
			AND ps_availqty > (
				SELECT 0.5 * sum(l_quantity)
				FROM tpc_dv_opt.SAT_LNK_LINE_ITEM sat_li
				INNER JOIN tpc_dv_opt.LNK_LINE_ITEM lnk_li ON lnk_li.DVS_LNK_LINE_ITEM = sat_li.DVS_LNK_LINE_ITEM
				INNER JOIN tpc_dv_opt.LNK_PART_SUPPLIER lnk_ps ON lnk_ps.dvs_hub_supplier  = lnk_li.dvs_hub_supplier and lnk_ps.dvs_hub_part  = lnk_li.dvs_hub_part
				WHERE hub_p.DVS_HUB_PART = lnk_ps.DVS_HUB_PART
					AND hub_s.DVS_HUB_SUPPLIER = lnk_ps.DVS_HUB_SUPPLIER
					AND l_shipdate >= DATE '1996-01-01'
					AND l_shipdate < cast(DATE '1996-01-01' + interval '1 year' as daTE)
				)
		)
	AND n_name = 'RUSSIA'
ORDER BY s_name;

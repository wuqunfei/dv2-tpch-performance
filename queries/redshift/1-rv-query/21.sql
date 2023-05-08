
/* TPC_H  Query 21 - Suppliers Who Kept Orders Waiting */
SELECT s_name -- 240 secs
              ,count(*) AS numwait
FROM tpc_dv_opt.SAT_SUPPLIER sat_s
--INNER JOIN tpc_dv_opt.LNK_PART_SUPPLIER lnk_ps ON lnk_ps.DVS_HUB_SUPPLIER = sat_s.DVS_HUB_SUPPLIER
INNER JOIN tpc_dv_opt.LNK_LINE_ITEM lnk_li ON lnk_li.DVS_hub_SUPPLIER = sat_s.DVS_hub_SUPPLIER
INNER JOIN tpc_dv_opt.SAT_LNK_LINE_ITEM sat_li ON sat_li.DVS_LNK_LINE_ITEM = lnk_li.DVS_LNK_LINE_ITEM
INNER JOIN tpc_dv_opt.SAT_ORDER sat_o ON sat_o.DVS_HUB_ORDER = lnk_li.DVS_HUB_ORDER
INNER JOIN tpc_dv_opt.REF_NATION ref_n ON ref_n.nationcode = sat_s.nationcode
WHERE sat_o.o_orderstatus = 'F'
              AND l_receiptdate > l_commitdate
              AND EXISTS (
                             SELECT 1
                             FROM tpc_dv_opt.lnk_line_item i_lnk_li
                             WHERE lnk_li.DVS_HUB_ORDER = i_lnk_li.DVS_HUB_ORDER
                                           AND lnk_li.DVS_hub_SUPPLIER <> i_lnk_li.DVS_hub_SUPPLIER
                             )
              AND NOT EXISTS (
                             SELECT 1
                             FROM tpc_dv_opt.LNK_LINE_ITEM i_lnk_li2
                             INNER JOIN tpc_dv_opt.SAT_LNK_LINE_ITEM i_sat_li ON i_sat_li.DVS_LNK_LINE_ITEM = i_lnk_li2.DVS_LNK_LINE_ITEM
                             WHERE lnk_li.DVS_HUB_ORDER = i_lnk_li2.DVS_HUB_ORDER
                                           AND lnk_li.DVS_HUB_SUPPLIER <> i_lnk_li2.DVS_HUB_SUPPLIER
                                           AND i_sat_li.l_receiptdate > i_sat_li.l_commitdate
                             )
AND ref_n.n_name = 'MOROCCO'
GROUP BY s_name
ORDER BY numwait DESC
              ,s_name LIMIT 100;

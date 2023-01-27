

/* TPC_H  Query 11 - Important Stock Indentification */
SELECT p_partkey AS ps_partkey -- 11 secs
	,sum(ps_supplycost * ps_availqty) AS "VALUE"
FROM TPC_DV_OPT.HUB_PART              hub_p
    join TPC_DV_OPT.LNK_PART_SUPPLIER     lnk_ps on lnk_ps.DVS_HUB_PART          = hub_p.DVS_HUB_PART
    join TPC_DV_OPT.SAT_SUPPLIER          sat_su on sat_su.DVS_HUB_SUPPLIER      = lnk_ps.DVS_HUB_SUPPLIER
    join TPC_DV_OPT.SAT_LNK_PART_SUPPLIER sat_ps on sat_ps.DVS_LNK_PART_SUPPLIER = lnk_ps.DVS_LNK_PART_SUPPLIER
    join TPC_DV_OPT.REF_NATION            ref_n  on ref_n.NATIONCODE             = sat_su.NATIONCODE
WHERE n_name = 'SAUDI ARABIA'
GROUP BY p_partkey
HAVING sum(ps_supplycost * ps_availqty) > (
		SELECT sum(ps_supplycost * ps_availqty) * 0.0000000333
		FROM   TPC_DV_OPT.LNK_PART_SUPPLIER     lnk_ps
             join TPC_DV_OPT.SAT_LNK_PART_SUPPLIER sat_ps on sat_ps.DVS_LNK_PART_SUPPLIER = lnk_ps.DVS_LNK_PART_SUPPLIER
             join TPC_DV_OPT.SAT_SUPPLIER          sat_su on sat_su.DVS_HUB_SUPPLIER      = lnk_ps.DVS_HUB_SUPPLIER
             join TPC_DV_OPT.REF_NATION            ref_n  on ref_n.NATIONCODE             = sat_su.NATIONCODE
		WHERE n_name = 'SAUDI ARABIA'
		)
ORDER BY "VALUE" DESC;

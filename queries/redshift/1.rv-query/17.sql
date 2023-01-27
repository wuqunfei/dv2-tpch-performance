

/* TPC_H  Query 17 - Small-Quantity-Order Revenue */
	select -- 180 secs
	sum(l_extendedprice) / 7.0 as avg_yearly
from	TPC_DV_OPT.SAT_LNK_LINE_ITEM sat_li
  join  TPC_DV_OPT.LNK_LINE_ITEM     lnk_li on lnk_li.DVS_LNK_LINE_ITEM                 = sat_li.DVS_LNK_LINE_ITEM
  join  TPC_DV_OPT.LNK_PART_SUPPLIER lnk_ps on lnk_ps.DVS_HUB_SUPPLIER = lnk_li.DVS_HUB_SUPPLIER and lnk_ps.DVS_HUB_PART = lnk_li.DVS_HUB_PART
  join  TPC_DV_OPT.HUB_PART          hub_p  on hub_p.DVS_HUB_PART           = lnk_ps.DVS_HUB_PART
  join  TPC_DV_OPT.SAT_PART          sat_p  on sat_p.DVS_HUB_PART           = hub_p.DVS_HUB_PART

where
	    p_brand = 'Brand#42'
	and p_container = 'MED JAR'
	and l_quantity < (
		select
			0.2 * avg(l_quantity)
		from  TPC_DV_OPT.SAT_LNK_LINE_ITEM sat_li
        join  TPC_DV_OPT.LNK_LINE_ITEM     lnk_li   on lnk_li.DVS_LNK_LINE_ITEM                 = sat_li.DVS_LNK_LINE_ITEM
        join  TPC_DV_OPT.LNK_PART_SUPPLIER lnk_ps   on lnk_ps.DVS_HUB_SUPPLIER = lnk_li.DVS_HUB_SUPPLIER and lnk_ps.DVS_HUB_PART = lnk_li.DVS_HUB_PART
        join  TPC_DV_OPT.HUB_PART          i_hub_p  on i_hub_p.DVS_HUB_PART         = lnk_ps.DVS_HUB_PART
        join  TPC_DV_OPT.SAT_PART          i_sat_p    on i_hub_p.DVS_HUB_PART       = i_sat_p.DVS_HUB_PART

		where hub_p.p_partkey = i_hub_p.p_partkey
          and p_brand = 'Brand#42'
	      and p_container = 'MED JAR'

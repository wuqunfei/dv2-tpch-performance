
/*Q4 DVopt*/ select -- 274 secs
	n_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue
from TPC_DV_OPT.REF_NATION           ref_n
join TPC_DV_OPT.REF_REGION           ref_r    on ref_r.REGIONCODE         = ref_n.REGIONCODE
join TPC_DV_OPT.SAT_CUSTOMER         sat_cu   on sat_cu.NATIONCODE                 = ref_n.NATIONCODE
join TPC_DV_OPT.LNK_CUSTOMER_ORDER   lnk_co   on lnk_co.DVS_HUB_CUSTOMER      = sat_cu.DVS_HUB_CUSTOMER
join TPC_DV_OPT.SAT_ORDER            sat_o    on sat_o.DVS_HUB_ORDER          = lnk_co.DVS_HUB_ORDER
join TPC_DV_OPT.LNK_LINE_ITEM        lnk_li   on lnk_li.DVS_HUB_ORDER         = lnk_co.DVS_HUB_ORDER
join TPC_DV_OPT.SAT_LNK_LINE_ITEM    sat_li   on sat_li.DVS_LNK_LINE_ITEM                 = lnk_li.DVS_LNK_LINE_ITEM
join TPC_DV_OPT.LNK_PART_SUPPLIER    lnk_ps   on lnk_ps.DVS_HUB_PART = lnk_li.DVS_HUB_PART
                                             and lnk_ps.DVS_HUB_SUPPLIER = lnk_li.DVS_HUB_SUPPLIER
where r_name = 'MIDDLE EAST'
  and o_orderdate >= date '1994-01-01'
  and o_orderdate < cast(DATE '1994-01-01' + interval '1 year' AS DATE)
  and sat_li.ledts = timestamp '9999-12-31 23:59:59'
group by
	n_name
order by
	revenue desc;



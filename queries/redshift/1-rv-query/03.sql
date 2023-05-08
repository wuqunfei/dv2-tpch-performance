select -- 378 secs
	o_orderkey,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	o_orderdate,
	o_shippriority
from TPC_DV_OPT.sat_CUSTOMER       sat_cust
join TPC_DV_OPT.LNK_CUSTOMER_ORDER lnk_custorder on lnk_custorder.DVS_HUB_CUSTOMER = sat_cust.DVS_HUB_CUSTOMER
join TPC_DV_OPT.HUB_ORDER          hub_order     on hub_order.DVS_HUB_ORDER        = lnk_custorder.DVS_HUB_ORDER
join TPC_DV_OPT.SAT_ORDER          sat_order     on sat_order.DVS_HUB_ORDER        = lnk_custorder.DVS_HUB_ORDER
join TPC_DV_OPT.LNK_LINE_ITEM      lnk_lineitem  on lnk_lineitem.DVS_HUB_ORDER     = hub_order.DVS_HUB_ORDER
join TPC_DV_OPT.SAT_LNK_LINE_ITEM  sat_lnk_li    on sat_lnk_li.DVS_LNK_LINE_ITEM   = lnk_lineitem.DVS_LNK_LINE_ITEM
where
	c_mktsegment = 'BUILDING'
	and
	o_orderdate < date '1995-03-24'
	and l_shipdate > date '1995-03-24'
group by
	o_orderkey,
	o_orderdate,
	o_shippriority
order by
	revenue desc,
	o_orderdate
LIMIT 10
;

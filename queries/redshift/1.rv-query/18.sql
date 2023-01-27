
/*Q18 DVopt*/ select -- 80 secs
	c_custkey,
	c_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	c_acctbal,
	n_name,
	c_address,
	c_phone,
	c_comment
from   TPC_DV_OPT.SAT_CUSTOMER        sat_c
  join TPC_DV_OPT.HUB_CUSTOMER        hub_c   on hub_c.DVS_HUB_CUSTOMER = sat_c.DVS_HUB_CUSTOMER
  join TPC_DV_OPT.REF_NATION          ref_n   on ref_n.NATIONCODE       = sat_c.NATIONCODE
  join TPC_DV_OPT.LNK_CUSTOMER_ORDER  lnk_co  on lnk_co.DVS_HUB_CUSTOMER = hub_c.DVS_HUB_CUSTOMER
  join TPC_DV_OPT.SAT_ORDER           sat_o   on sat_o.DVS_HUB_ORDER     = lnk_co.DVS_HUB_ORDER
  join TPC_DV_OPT.LNK_LINE_ITEM       lnk_li  on lnk_li.DVS_HUB_ORDER    = lnk_co.DVS_HUB_ORDER
  join TPC_DV_OPT.SAT_LNK_LINE_ITEM   sat_li  on sat_li.DVS_LNK_LINE_ITEM            = lnk_li.DVS_LNK_LINE_ITEM
where
        o_orderdate >= date '1994-02-01'
	and o_orderdate < cast(DATE '1994-01-01' + interval '3 months' AS DATE)
	and l_returnflag = 'R'
group by
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
order by
	revenue desc
LIMIT 20
;
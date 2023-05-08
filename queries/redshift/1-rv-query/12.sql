

/* TPC_H  Query 12 - Shipping Modes and Order Priority */
/*Q3 DVopt*/ select -- 122 secs
	l_shipmode,
	sum(case
		when o_orderpriority = '1-URGENT'
			or o_orderpriority = '2-HIGH'
			then 1
		else 0
	end) as high_line_count,
	sum(case
		when o_orderpriority <> '1-URGENT'
			and o_orderpriority <> '2-HIGH'
			then 1
		else 0
	end) as low_line_count
from TPC_DV_OPT.SAT_LNK_LINE_ITEM sat_li
join TPC_DV_OPT.LNK_LINE_ITEM lnk_li on lnk_li.DVS_LNK_LINE_ITEM         = sat_li.DVS_LNK_LINE_ITEM
join TPC_DV_OPT.SAT_ORDER sat_or     on lnk_li.DVS_HUB_ORDER = sat_or.DVS_HUB_ORDER
where L_SHIPMODE in ('AIR', 'REG AIR')
  and L_COMMITDATE < l_receiptdate
  and L_SHIPDATE < l_commitdate
  and L_RECEIPTDATE >= date '1997-01-01'
  and l_receiptdate < cast(DATE '1997-01-01' + interval '1 year' AS DATE)
group by
	l_shipmode
order by
	l_shipmode
;
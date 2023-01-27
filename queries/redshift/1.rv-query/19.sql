

/* TPC_H  Query 19 - Discounted Revenue */
select --180 secs
	sum(l_extendedprice* (1 - l_discount)) as revenue
from    TPC_DV_OPT.SAT_LNK_LINE_ITEM sat_li
  join  TPC_DV_OPT.LNK_LINE_ITEM     lnk_li  on lnk_li.DVS_LNK_LINE_ITEM                 = sat_li.DVS_LNK_LINE_ITEM
  join  TPC_DV_OPT.LNK_PART_SUPPLIER lnk_ps  on lnk_ps.DVS_HUB_SUPPLIER = lnk_li.DVS_HUB_SUPPLIER and lnk_ps.DVS_HUB_PART = lnk_li.DVS_HUB_PART
  join  TPC_DV_OPT.SAT_PART          sat_p   on sat_p.DVS_HUB_PART           = lnk_ps.DVS_HUB_PART
where
	(
		    p_brand = 'Brand#31'
		and p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
		and l_quantity >= 3 and l_quantity <= 3 + 10
		and p_size between 1 and 5
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		    p_brand = 'Brand#33'
		and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
		and l_quantity >= 14 and l_quantity <= 14 + 10
		and p_size between 1 and 10
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		    p_brand = 'Brand#52'
		and p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		and l_quantity >= 23 and l_quantity <= 23 + 10
		and p_size between 1 and 15
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	);

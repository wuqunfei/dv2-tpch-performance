/* TPC_H  Query 1 - Pricing Summary Report */ -- 41 secs
SELECT l_returnflag
	,l_linestatus
	,sum(l_quantity) AS sum_qty
	,sum(l_extendedprice) AS sum_base_price
	,sum(l_extendedprice * (1 - l_discount)) AS sum_disc_price
	,sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge
	,avg(l_quantity) AS avg_qty
	,avg(l_extendedprice) AS avg_price
	,avg(l_discount) AS avg_disc
	,count(*) AS count_order
FROM TPC_DV_OPT.SAT_LNK_LINE_ITEM lineitem
WHERE l_shipdate <= cast(DATE '1998-12-01' - interval '62 days' AS DATE)
GROUP BY l_returnflag
	,l_linestatus
ORDER BY l_returnflag
	,l_linestatus;


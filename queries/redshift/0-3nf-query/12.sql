/* TPC_H  Query 12 - Shipping Modes and Order Priority */

SELECT	L_SHIPMODE,
	SUM(	CASE	WHEN O_ORDERPRIORITY  = '1-URGENT'	OR
			     O_ORDERPRIORITY  = '2-HIGH'
			THEN 1
			ELSE 0
		END)	AS HIGH_LINE_COUNT,
	SUM(	CASE	WHEN O_ORDERPRIORITY <> '1-URGENT'	AND
			     O_ORDERPRIORITY <> '2-HIGH'
			THEN 1
			ELSE 0
		END)	AS LOW_LINE_COUNT
FROM	ORDERS,
	LINEITEM
WHERE	O_ORDERKEY	= L_ORDERKEY		AND
	L_SHIPMODE	IN ('FOB','REG AIR')		AND
	L_COMMITDATE	< L_RECEIPTDATE		AND
	L_SHIPDATE	< L_COMMITDATE		AND
	L_RECEIPTDATE	>= '1995-01-01'			AND
	L_RECEIPTDATE < cast (date '1995-01-01' + interval '1 year' as date)
GROUP	BY	L_SHIPMODE
ORDER	BY	L_SHIPMODE
;

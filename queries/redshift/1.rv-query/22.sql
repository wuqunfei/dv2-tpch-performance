


/* TPC_H  Query 22 - Global Sales Opportunity */
SELECT cntrycode -- 25 secs
	,count(*) AS numcust
	,sum(c_acctbal) AS totacctbal
FROM (
	SELECT substring(c_phone FROM 1 FOR 2) AS cntrycode
		,c_acctbal
	FROM tpc_dv_opt.SAT_CUSTOMER sat_c
	INNER JOIN tpc_dv_opt.HUB_CUSTOMER hub_c ON hub_c.DVS_HUB_CUSTOMER = sat_c.DVS_HUB_CUSTOMER
	LEFT JOIN tpc_dv_opt.LNK_CUSTOMER_ORDER lnk_co ON lnk_co.DVS_HUB_CUSTOMER = hub_c.DVS_HUB_CUSTOMER
	WHERE substring(c_phone FROM 1 FOR 2) IN (
			'32'
			,'12'
			,'30'
			,'20'
			,'29'
			,'16'
			,'13'
			)
		AND c_acctbal > (
			SELECT avg(c_acctbal)
			FROM tpc_dv_opt.SAT_CUSTOMER
			WHERE c_acctbal > 0.00
				AND substring(c_phone FROM 1 FOR 2) IN (
					'32'
					,'12'
					,'30'
					,'20'
					,'29'
					,'16'
					,'13'
					)
			)
		AND lnk_co.DVS_HUB_CUSTOMER IS NULL
	) AS custsale
GROUP BY cntrycode
ORDER BY cntrycode;

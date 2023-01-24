jmeter  -n \
        -p redshift.conf/redshift.loading.0.properties \
        -t loadrunner.jmx \
        -l ../reports/jmeter-redshift-dv2-$(date +%F_%H%M)-10T.csv \
        -j ../logs/jmeter-redshift-dv2-$(date +%F_%H%M).log
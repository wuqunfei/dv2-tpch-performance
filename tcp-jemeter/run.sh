jmeter  -n \
        -p hydra.conf/hydra.properties \
        -t loadrunner.jmx \
        -l ../reports/jmeter-hydyra-$(date +%F_%H%M)-1T.csv \
        -j ../logs/jmeter-hydra-$(date +%F_%H%M)-1T.log



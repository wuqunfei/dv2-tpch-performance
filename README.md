# Data Vault 2.0 Performance Test with TPC-H
Performance Test on Data Vault 2.0 with TCP-H

## 1. Configure TPCH-TOOL
```shell
# Build TPC-H Tool
# Down load from https://www.tpc.org/tpch/
mkdir /opt/db/tpch-tool
# Save the TCPH Tool zip to /opt/db/tpch-tool directory as tpc-h-tool_2_17_0.zip
unzip tpc-h-tool_2_17_0.zip
cd tpch_2_17_0/dbgen
cp makefile.suite Makefile
# Update the Makefile with the lines below
CC=gcc
DATABASE=ORACLE
MACHINE=LINUX
WORKLOAD=TPCH
# Fix bug 
echo "#define EOL_HANDLING 1" >> config.h # remove the tail '|'
make
```

# 2. Generate Data

```shell
VOLUME_SIZE=1000
CHUNKS=100
#for table_name in "lineitem" "orders" "partsupp" "part" "customer" "supplier"
for table_name in "partsupp" "orders" "lineitem"
do
  for((step=1;step<=$CHUNKS;step++));
    do
        table_prefix=""
        if [ $table_name = "lineitem" ] ; then
          table_prefix="L"
          sleep 5
        elif [ $table_name = "orders" ] ; then
          table_prefix="O"
          sleep 2
        elif [ $table_name = "partsupp" ] ; then
          table_prefix="S"
          sleep 1
        elif [ $table_name = "part" ] ; then
          table_prefix="P"
        elif [ $table_name = "customer" ] ; then
          table_prefix="c"
        elif [ $table_name = "supplier" ] ; then
          table_prefix="s"
        else
          echo "No Plan Table"
        fi
        ./dbgen -s $VOLUME_SIZE -S $step -C $CHUNKS -T $table_prefix -f &
  done
  echo "${table_name} @ $(date +%F_%H%M)"
  sleep 60
done
echo "ALL Generated!!! $(date +%F_%H%M)"

# rm -fr *.tbl.*
# ps -fe|grep dbgen
# killall -r dbgen
# nohup ./data.gen.sh > T10generation.log 2>&1 &
```

# 3. Test Query
```shell
jmeter  -n \
        -p redshift.conf/redshift.properties \
        -t loadrunner.jmx \
        -l ../reports/jmeter-redshift-$(date +%F_%H%M)-10T.csv \
        -j ../logs/jmeter-redshift-$(date +%F_%H%M).log
        
# output in tpc-output folder
# logs, reports with csv
```

# 4. Validate Query
# Data Vault 2.0 Performance Test Data Generation
Create Data with TPCH tool

## 1. Configure TPCH-TOOL, configure the parameter for different database
```shell
# Build TPC-H Tool
# Down load from https://www.tpc.org/tpch/
mkdir /opt/db/tpch-tool
# Save the TCPH Tool zip to /opt/db/tpch-tool directory as tpc-h-tool.zip
unzip tpc-h-tool.zip
cd tpch-h-tool/dbgen
cp makefile.suite Makefile
# Update the Makefile with the lines below, Oracle is also used for Postgresql, Aurora, Redshift
CC=gcc
DATABASE=ORACLE
MACHINE=LINUX
WORKLOAD=TPCH
# Fix bug with in configuration 
echo "#define EOL_HANDLING 1" >> config.h # remove the tail '|'
make
```
after make done, It will create a dbgen folder and dbgen cmd inside. 

# 2. Generate Data By Scale
 - ./dbgen --help 
 - parameters scale: -S example 1 = 1GB, 1000 = 1TB 
 - parameters files: -C example -C 10 -S 1, create 10 files for 1 GB 

A Shell make different big files in different chunks, Please put some sleep of your computer memory limitation.
```shell
VOLUME_SIZE=1000
CHUNKS=100
for table_name in "lineitem" "orders" "partsupp" "part" "customer" "supplier" 
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

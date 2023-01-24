# Data Vault 2.0 Performance Test with TPC-H
Performance Test on Data Vault 2.0 with TCP-H

## Configure TPCH-TOOL
```shell
# Build TPC-H Tool
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
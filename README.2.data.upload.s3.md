# Loading data into big cloud storage 
- there is no big space on your PC/MAC/EC2
- loading S3 csv files into Redshift/snowfake/Oracle is much faster

## Example

```shell
export AWS_DEFAULT_REGION=eu-central-1
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
#export AWS_SESSION_TOKEN="..."

DATA_PATH=/app/t10

for table in 'region' 'nation' 'supplier' 'part' 'partsupp' 'customer' 'orders'
  do
    echo "aws s3 cp ${DATA_PATH}/${table}  s3://tpch-10t-tbl/${table} --recursive > s3.cp.${table}.log 2>&1 &"
    # nohup aws s3 cp $DATA_PATH/$table s3://tpch-10t-tbl/$table --recursive  > s3.cp.$table.log 2>&1 &
    sleep 60
  done

```

to be aware that it consumes cpu and memory with parallel upload.
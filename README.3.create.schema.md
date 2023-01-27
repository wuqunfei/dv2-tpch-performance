# Create schema 

## 1. check connection between your device to database
install pgsql client/service on EC2 or Mac, for example
```shell
brew install postgres
psql 
```
AWS aurora postgresql, redshift are compatible with postgresql client.

```shell
export PGOPTIONS=--search_path=tpch,public
export PGPASSWORD='...'
psql -h database-1.cluster-ro-ckiwabi96jwu.eu-central-1.rds.amazonaws.com -U postgres -d postgres


export PGCLIENTENCODING=UTF8
export PGOPTIONS=--search_path=tpch,public
export PGPASSWORD='...'

psql -h tpc-redshift.cnnli1dum1im.eu-central-1.redshift.amazonaws.com -U awsuser -d sample_data_dev -p 5439
```

## 2. Layers of Tables in Data Vault 2.0
Schema definition is under /schema/database/steps folder
- 0-3nf is the original tpch 8 DDL 
- 1-raw vault is the raw vault layer with link,hub, satellite table DDL
- 2-business-vault is the business layer with Point of Time Table, Bridge, Reference Tables DDL
- 3-Information-vault is the information vault(Data Mart) layer

## 3. Different patterns in information Vault for consumptions 
1. virtual table
```sql
create view my_view as 
    select * from my_table;

```
2. materialized  table
```sql
create materialized view my_m_view 
    backup no 
    auto refersh YES
    as select * from my_table
```
3. Physical table
```sql
create table my_dm();
insert my_dm select * from bridge_table left join satellite_table;

```


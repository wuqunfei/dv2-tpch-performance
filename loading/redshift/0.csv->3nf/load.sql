copy region from 's3://redshift-downloads/TPC-H/2.18/3TB/region/' iam_role default delimiter '|';
copy nation from 's3://redshift-downloads/TPC-H/2.18/3TB/nation/' iam_role default delimiter '|';
copy lineitem from 's3://redshift-downloads/TPC-H/2.18/3TB/lineitem/' iam_role default delimiter '|';
copy orders from 's3://redshift-downloads/TPC-H/2.18/3TB/orders/' iam_role default delimiter '|';
copy part from 's3://redshift-downloads/TPC-H/2.18/3TB/part/' iam_role default delimiter '|';
copy supplier from 's3://redshift-downloads/TPC-H/2.18/3TB/supplier/' iam_role default delimiter '|';
copy partsupp from 's3://redshift-downloads/TPC-H/2.18/3TB/partsupp/' iam_role default delimiter '|';
copy customer from 's3://redshift-downloads/TPC-H/2.18/3TB/customer/' iam_role default delimiter '|';
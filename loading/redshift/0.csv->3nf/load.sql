copy region from 's3://redshift-downloads/TPC-H/2.18/3TB/region/' iam_role 'arn:aws:iam::309786454627:role/role-redshift-s3-access' delimiter '|';
copy nation from 's3://redshift-downloads/TPC-H/2.18/3TB/nation/' iam_role 'arn:aws:iam::309786454627:role/role-redshift-s3-access' delimiter '|';
copy lineitem from 's3://redshift-downloads/TPC-H/2.18/3TB/lineitem/' iam_role 'arn:aws:iam::309786454627:role/role-redshift-s3-access' delimiter '|';
copy orders from 's3://redshift-downloads/TPC-H/2.18/3TB/orders/' iam_role 'arn:aws:iam::309786454627:role/role-redshift-s3-access' delimiter '|';
copy part from 's3://redshift-downloads/TPC-H/2.18/3TB/part/' iam_role 'arn:aws:iam::309786454627:role/role-redshift-s3-access' delimiter '|';
copy supplier from 's3://redshift-downloads/TPC-H/2.18/3TB/supplier/' iam_role 'arn:aws:iam::309786454627:role/role-redshift-s3-access' delimiter '|';
copy partsupp from 's3://redshift-downloads/TPC-H/2.18/3TB/partsupp/' iam_role 'arn:aws:iam::309786454627:role/role-redshift-s3-access' delimiter '|';
copy customer from 's3://redshift-downloads/TPC-H/2.18/3TB/customer/' iam_role 'arn:aws:iam::309786454627:role/role-redshift-s3-access' delimiter '|';
#!/bin/bash

base_dir=$(cd $(dirname $0); pwd)

cd $base_dir/dss

./dbgen -s 20  -T a


sed -i 's/$/"1999-01-01"/' customer.tbl
sed -i 's/$/"1999-01-01"/' supplier.tbl
sed -i '1,100s/1999-01-01/2000-01-01/g' supplier.tbl
cat customer.tbl | clickhouse-client --host=vm1.centos74.com --query "INSERT INTO customerd FORMAT CSV"
cat lineorder.tbl | clickhouse-client --host=vm1.centos74.com --query "INSERT INTO lineorderd FORMAT CSV"
cat part.tbl | clickhouse-client --host=vm1.centos74.com --query "INSERT INTO partd FORMAT CSV"
cat supplier.tbl | clickhouse-client --host=vm1.centos74.com --query "INSERT INTO supplierd FORMAT CSV"

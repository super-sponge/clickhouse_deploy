drop table if exists lineorder on cluster ck_cluster;
drop table if exists customer on cluster ck_cluster;
drop table if exists part on cluster ck_cluster;
drop table if exists supplier on cluster ck_cluster;
drop table if exists lineorderd on cluster ck_cluster;
drop table if exists customerd on cluster ck_cluster;
drop table if exists partd on cluster ck_cluster;
drop table if exists supplierd on cluster ck_cluster;
 

CREATE TABLE lineorder on cluster ck_cluster ( 
        LO_ORDERKEY             UInt32,
        LO_LINENUMBER           UInt8,
        LO_CUSTKEY              UInt32,
        LO_PARTKEY              UInt32,
        LO_SUPPKEY              UInt32,
        LO_ORDERDATE            Date,
        LO_ORDERPRIORITY        String,
        LO_SHIPPRIORITY         UInt8,
        LO_QUANTITY             UInt8,
        LO_EXTENDEDPRICE        UInt32,
        LO_ORDTOTALPRICE        UInt32,
        LO_DISCOUNT             UInt8,
        LO_REVENUE              UInt32,
        LO_SUPPLYCOST           UInt32,
        LO_TAX                  UInt8,
        LO_COMMITDATE           Date,
        LO_SHIPMODE             String
)Engine=MergeTree(LO_ORDERDATE,(LO_ORDERKEY,LO_LINENUMBER),8192);

CREATE TABLE customer on cluster ck_cluster ( 
        C_CUSTKEY       UInt32,
        C_NAME	        String,
        C_ADDRESS       String,
        C_CITY          String,
        C_NATION        String,
        C_REGION        String,
        C_PHONE         String,
        C_MKTSEGMENT    String,
        C_FAKEDATE      Date
)Engine=MergeTree(C_FAKEDATE,(C_CUSTKEY),8192);

CREATE TABLE part on cluster ck_cluster ( 
        P_PARTKEY       UInt32,
        P_NAME          String,
        P_MFGR          String,
        P_CATEGORY      String,
        P_BRAND         String,
        P_COLOR         String,
        P_TYPE          String,
        P_SIZE          UInt8,
        P_CONTAINER     String,
        P_FAKEDATE      Date
)Engine=MergeTree(P_FAKEDATE,(P_PARTKEY),8192);

CREATE TABLE supplier on cluster ck_cluster ( 
        S_SUPPKEY    UInt32,
        S_NAME   String,
        S_ADDRESS String,
        S_CITY String,
        S_NATION String,
        S_REGION String,
        S_PHONE String,
        S_FAKEDATE Date
)Engine=MergeTree(S_FAKEDATE,(S_SUPPKEY),8192);


CREATE TABLE lineorderd on cluster ck_cluster AS lineorder ENGINE = Distributed(ck_cluster, default, lineorder, rand());
CREATE TABLE customerd on cluster ck_cluster AS customer ENGINE = Distributed(ck_cluster, default, customer, rand());
CREATE TABLE partd on cluster ck_cluster AS part ENGINE = Distributed(ck_cluster, default, part, rand());
CREATE TABLE supplierd on cluster ck_cluster AS supplier ENGINE = Distributed(ck_cluster, default, supplier, rand());

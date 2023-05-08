-- Sccsid:     @(#)dss.ri	2.1.8.1
-- TPCD Benchmark Version 8.0

-- For table REGION
ALTER TABLE REGION
ADD PRIMARY KEY (R_REGIONKEY);

COMMIT WORK;

-- For table NATION
ALTER TABLE NATION
ADD PRIMARY KEY (N_NATIONKEY);


COMMIT WORK;

-- For table PART
ALTER TABLE PART
ADD PRIMARY KEY (P_PARTKEY);

COMMIT WORK;

-- For table SUPPLIER
ALTER TABLE SUPPLIER
ADD PRIMARY KEY (S_SUPPKEY);


COMMIT WORK;

-- For table CUSTOMER
ALTER TABLE CUSTOMER
ADD PRIMARY KEY (C_CUSTKEY);


COMMIT WORK;


-- For table PARTSUPP
ALTER TABLE PARTSUPP
ADD PRIMARY KEY (PS_PARTKEY,PS_SUPPKEY);
COMMIT WORK;


-- For table ORDERS
ALTER TABLE ORDERS
ADD PRIMARY KEY (O_ORDERKEY);

COMMIT WORK;


-- For table LINEITEM
ALTER TABLE LINEITEM
ADD PRIMARY KEY (L_ORDERKEY,L_LINENUMBER);

COMMIT WORK;



CREATE INDEX IDX_SUPPLIER_NATION_KEY ON SUPPLIER (S_NATIONKEY);
CREATE INDEX IDX_PARTSUPP_PARTKEY ON PARTSUPP (PS_PARTKEY);
CREATE INDEX IDX_PARTSUPP_SUPPKEY ON PARTSUPP (PS_SUPPKEY);
CREATE INDEX IDX_CUSTOMER_NATIONKEY ON CUSTOMER (C_NATIONKEY);
CREATE INDEX IDX_ORDERS_CUSTKEY ON ORDERS (O_CUSTKEY);
CREATE INDEX IDX_LINEITEM_ORDERKEY ON LINEITEM (L_ORDERKEY);
CREATE INDEX IDX_LINEITEM_PART_SUPP ON LINEITEM (L_PARTKEY,L_SUPPKEY);
CREATE INDEX IDX_LINEITEM_SUPP ON LINEITEM (L_SUPPKEY);
CREATE INDEX IDX_NATION_REGIONKEY ON NATION (N_REGIONKEY);

CREATE INDEX IDX_LINEITEM_SHIPDATE ON LINEITEM (L_SHIPDATE);
CREATE INDEX IDX_LINEITEM_COMMITDATE ON LINEITEM (L_COMMITDATE);
CREATE INDEX IDX_LINEITEM_RECEIPTDATE ON LINEITEM (L_RECEIPTDATE);
CREATE INDEX IDX_ORDERS_ORDERDATE ON ORDERS (O_ORDERDATE);
COMMIT WORK;

--
--
-- -- For table ORDERS
-- ALTER TABLE ORDERS
-- ADD CONSTRAINT ORDERS_FK1 FOREIGN KEY (O_CUSTKEY) REFERENCES CUSTOMER(C_CUSTKEY);
--
--
-- ALTER TABLE NATION
-- ADD CONSTRAINT NATION_FK1 FOREIGN KEY (N_REGIONKEY) REFERENCES REGION(R_REGIONKEY);
--
--
-- ALTER TABLE SUPPLIER
-- ADD CONSTRAINT SUPPLIER_FK1 FOREIGN KEY (S_NATIONKEY) REFERENCES NATION(N_NATIONKEY);
--
--
-- ALTER TABLE CUSTOMER
-- ADD CONSTRAINT CUSTOMER_FK1 FOREIGN KEY (C_NATIONKEY) REFERENCES NATION(N_NATIONKEY);
--
--
-- -- For table PARTSUPP
-- ALTER TABLE PARTSUPP
-- ADD CONSTRAINT PARTSUPP_FK1 FOREIGN KEY (PS_SUPPKEY) REFERENCES SUPPLIER(S_SUPPKEY);
--
--
-- ALTER TABLE PARTSUPP
-- ADD CONSTRAINT PARTSUPP_FK2 FOREIGN KEY (PS_PARTKEY) REFERENCES PART(P_PARTKEY);
--
--
--
-- -- For table LINEITEM
-- ALTER TABLE LINEITEM
-- ADD CONSTRAINT LINEITEM_FK1 FOREIGN KEY (L_ORDERKEY) REFERENCES ORDERS(O_ORDERKEY);
--
--
-- ALTER TABLE LINEITEM
-- ADD CONSTRAINT LINEITEM_FK2 FOREIGN KEY  (L_PARTKEY,L_SUPPKEY) REFERENCES PARTSUPP(PS_PARTKEY, PS_SUPPKEY);
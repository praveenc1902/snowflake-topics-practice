CREATE OR REPLACE DYNAMIC TABLE product
TARGET_LAG = '1 minutes'
WAREHOUSE = 'PRAVEEN_WAREHOUSE'
AS
SELECT id,name, city from CPR_TAB_1

SELECT id,name, city from CPR_TAB_1

-- insert into CPR_TAB_1 select 111,'ohmygod','god'
SELECT * FROM product

-- DROP DYNAMIC TABLE  product

desc dynamic table product

show dynamic tables

show dynamic tables product

-- ALTER DYNAMIC TABLE product ACTIVE;


SELECT id,name, city from CPR_TAB_1

UPDATE CPR_TAB_1 SET NAME ='CPREDDY' where ID =1






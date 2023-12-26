  create storage integration praveen_storage_integ
      type = external_stage
      storage_provider = 's3'
      storage_aws_role_arn = 'arn:aws:iam:::role/' 'praveen_snow_flk_s3'
      enabled = true
      storage_allowed_locations = ( 's3://praveen-snow-practice/data.txt' )
       storage_blocked_locations = ( 's3://<location1>', 's3://<location2>' )
       comment = '<comment>';

  show integrations
  show stages

  TEST_PRAVEEN.CPR

  copy into test_praveen.cpr.chinna from @TEST_CPR_AWS_STG

  get_ddl('table','EXT_PRAVEEN_TABLE')

   create or replace external table TEST_PRAVEEN.CPR.EXT_PRAVEEN_TABLE(
   	ID NUMBER(38,0) AS (TO_NUMBER(GET(VALUE, 'id'))),
   	NAME VARCHAR(16777216) AS (CAST(GET(VALUE, 'name') AS VARCHAR(16777216))),
   	CITY VARCHAR(16777216) AS (CAST(GET(VALUE, 'city') AS VARCHAR(16777216))))
   location=@TEST_CPR_AWS_STG/
   file_format=(TYPE=csv)
   ;

  ALTER EXTERNAL TABLE TEST_PRAVEEN.CPR.EXT_PRAVEEN_TABLE REFRESH;

  select * from TEST_PRAVEEN.CPR.EXT_PRAVEEN_TABLE

 create or replace external table TEST_PRAVEEN.CPR.EXT_PRAVEEN_TABLE_3(
 	ID VARCHAR(16777216) AS (CAST(GET(VALUE, 'id') AS VARCHAR(16777216))),
 	NAME VARCHAR(16777216) AS (CAST(GET(VALUE, 'name') AS VARCHAR(16777216))),
 	CITY VARCHAR(16777216) AS (CAST(GET(VALUE, 'city') AS VARCHAR(16777216))))
 location=@TEST_CPR_AWS_STG/
 file_format=(TYPE=csv)
 ;

 ALTER EXTERNAL TABLE TEST_PRAVEEN.CPR.EXT_PRAVEEN_TABLE_3 REFRESH;

 select * from TEST_PRAVEEN.CPR.EXT_PRAVEEN_TABLE_3

 LIST @PRAVEEN_INTERNAL_STG

 LIST @%

 create table TEST_PRAVEEN.CPR.int_praveen
 (
 id varchar,
 name varchar,
 city varchar
 )
 COPY INTO TEST_PRAVEEN.CPR.int_praveen from @TEST_CPR_AWS_STG

 select * from TEST_PRAVEEN.CPR.int_praveen

 show INTEGRATIONs @TEST_CPR_AWS_STG
 desc integration PRAVEEN_STORAGE_INTEG

 CREATE STORAGE INTEGRATION s3_inte_aws_praveen
 TYPE = EXTERNAL_STAGE
 ENABLED = TRUE
 STORAGE_PROVIDER='s3'
 STORAGE_ALLOWED_LOCATIONS = ('s3://praveen-snow-practice/')
 STORAGE_AWS_ROLE_ARN = 'arn:aws:iam:::role/'

DESC INTEGRATION s3_inte_aws_praveen
arn:aws:iam:::user/aidh0000-s



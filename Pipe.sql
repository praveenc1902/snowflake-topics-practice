 use schema test_praveen.cpr;

 show integrations
 DROP INTEGRATION PRAVEEN_STORAGE_INTEG;
 DROP INTEGRATION S3_INTE_AWS_PRAVEEN;
 DROP INTEGRATION STG_INTEG_12_23_NEW;

 show stages

 DROP STAGE CPR_STAGE_PIPE;
 DROP STAGE CPR_STAGE_PIPE2;
 DROP STAGE PRAVEEN_INTERNAL_STG;
 DROP STAGE TEST_CPR_AWS_STG;

 desc integration s3_integ_cpr

 create stage s3_stg_cpr
 URL = 's3://praveen-snow-practice/test/'
 DIRECTORY=(ENABLE=TRUE)
 STORAGE_INTEGRATION = s3_integ_cpr
 COPY_OPTIONS = (ON_ERROR='skip_file');

 ALTER STAGE s3_stg_cpr REFRESH 

 create or replace external table test_praveen.cpr.ext_cpr_tab_1
 (
 id INT as (value:c1:INT),
 name varchar as (value:c2:varchar),
 city varchar as (value:c3:varchar)
  )
 LOCATION = @test_praveen.cpr.s3_stg_cpr
  PATTERN='*.csv'
 FILE_FORMAT = (TYPE = CSV)
 ;

 create table test_praveen.cpr.cpr_tab_1
 (
 id INT,
 name varchar,
 city varchar
 )

 COPY INTO cpr_tab_1
 FROM @s3_stg_cpr;

 SELECT * FROM cpr_tab_1

 create pipe test_praveen.cpr.cpr_pipe1 auto_ingest=true as 
 copy into test_praveen.cpr.cpr_tab_1
 from @s3_stg_cpr
 file_format =  (type = 'CSV');

 show pipes
 copy the arn from above output to event notification in s3

 select system$get_aws_sns_iam_policy('arn:aws:sns:us-east-1::praveen-snow-practice');

 select system$get_aws_sns_iam_policy('arn:aws:sns:us-east-1::snow_topic');

 show pipes

 create pipe test_praveen.cpr.cpr_pipe2
 auto_ingest = true
 aws_sns_topic = 'arn:aws:sns:us-east-1::snow_topic'
 as 
 copy into test_praveen.cpr.cpr_tab_1 from @s3_stg_cpr file_format =  (type = 'CSV')


show channels






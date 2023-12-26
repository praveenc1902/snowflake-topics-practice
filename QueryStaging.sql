use test_praveen.cpr;

LIST @S3_STG_CPR 

ALTER STAGE S3_STG_CPR REFRESH

SELECT t.$1,t.$2 from @S3_STG_CPR t

CREATE OR REPLACE file format my_csv TYPE = 'csv'

SELECT t.$1,t.$2 from @S3_STG_CPR (file_format => my_csv ) t;

SELECT METADATA$FILENAME, METADATA$FILE_ROW_NUMBER, METADATA$FILE_CONTENT_KEY, t.$1,t.$2 from @S3_STG_CPR t

show integrations

desc integration PRAVEEN_STORAGE_INTEG
desc integration S3_INTEG_CPR

create or replace storage integration cpr_json_integ
    type = external_stage
    storage_provider = s3
    storage_aws_role_arn = 'arn:aws:iam:::role/snowflake_s3_full_access_3'
    enabled = true
    storage_allowed_locations = ( 's3://praveen-snow-practice/sample_json' )

desc integration cpr_json_integ

CREATE or replace STAGE cpr_stg_json
URL='s3://praveen-snow-practice/sample_json/'
STORAGE_INTEGRATION = cpr_json_integ
;
create or replace file format myjsonformat type = 'JSON';

select $1,$1[0],
 $1[0]:location.city::varchar,
 $1[0]:location.zip::varchar,
 $1:location.city::varchar,
 $1:location.zip::varchar,
 $1:dimensions.sq_ft::number,
 $1:sale_date::date,
 $1:price::number
-- $1:location.city::varchar
-- ,$1:dimensions.sq_ft::varchar
from @test_praveen.cpr.cpr_stg_json 
-- file_format = (format_name = myjsonformat);
(file_format => myjsonformat ) ;


--schema evolution 
create or replace table test_praveen.cpr.cpr_evol_tab1
using template(
select array_agg(object_construct(*))
from table(infer_schema(LOCATION => '@test_praveen.cpr.cpr_stg_json'));
select * from test_praveen.cpr.cpr_evol_tab1









CREATE OR REPLACE STORAGE INTEGRATION s3_int_parquet
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam:::role/snfke_s3_full_access'
  ENABLED = TRUE
  STORAGE_ALLOWED_LOCATIONS = ('s3://praveen-snow-practice/parquet_files/');

CREATE STAGE parquet_stage
  STORAGE_INTEGRATION = s3_int_parquet
  URL = 's3://praveen-snow-practice/parquet_files/'
  FILE_FORMAT = (type='PARQUET');


select $1,$1:am from @parquet_stage
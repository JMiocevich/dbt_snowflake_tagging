

### Snowflake Tagging in DBT



How does one scour the dbt manifest
https://docs.getdbt.com/reference/dbt-jinja-functions/graph


```
CREATE SCHEMA MASKING_POLICIES;
USE SCHEMA MASKING_POLICIES;

CREATE OR REPLACE MASKING POLICY account_name_mask
AS (val string) RETURNS string ->
  CASE
    WHEN CURRENT_ROLE() IN ('ACCOUNTING_ADMIN') THEN val
    ELSE '***MASKED***'
  END;
  
  
CREATE OR REPLACE MASKING POLICY account_number_mask
AS (val number) RETURNS number ->
  CASE
    WHEN CURRENT_ROLE() IN ('ACCOUNTING_ADMIN') THEN val
    ELSE -1
  END;
  
  CREATE TAG pii COMMENT = 'pii tag';
  
  ALTER TAG pii SET
  MASKING POLICY account_name_mask,
  MASKING POLICY account_number_mask;
  
```
-- CIDM-10485 - Used for DevDB masking for overall Masking info.
drop view if exists cjams.cjams_devdb_masking;

create or replace view cjams.cjams_devdb_masking as
select 
    table_schema, 
    table_name, 
    column_name, 
    data_type, 
    pii_type, 
    pii_default, 
    pii_format
from cjams_columns_metadata where is_pii = 'Yes'
and activeflag = 1
order by 1, 2, 3;
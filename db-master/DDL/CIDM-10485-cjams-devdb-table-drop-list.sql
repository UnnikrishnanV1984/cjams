-- CIDM-10485 - Used for DevDB masking Validation
drop view if exists cjams.cjams_devdb_table_drop_list;

create or replace view cjams.cjams_devdb_table_drop_list as
select 
    ist.table_schema, 
    ist.table_name, 
    count(isc.column_name) as actual_column_count,
    coalesce(ctm.column_count,0) as expected_column_count, 
    case 
        when ctm.table_name is null then 'new table' 
        when count(isc.column_name) != ctm.column_count then 'column count mismatch'	
    end as table_drop_reason 
    from information_schema.tables ist 
    join information_schema.columns isc on ist.table_schema = isc.table_schema and ist.table_name = isc.table_name
    left join cjams_tables_metadata ctm on ist.table_schema = ctm.table_schema and ist.table_name = ctm.table_name
    where ist.table_schema in ('cjams', 'prov')
    and ist.table_type = 'BASE TABLE' and ctm.activeflag = 1
    group by ist.table_schema, ist.table_name, ctm.column_count, ctm.table_name
    having ctm.table_name is null or count(isc.column_name) != ctm.column_count;

--retrieve relevant table information
drop FUNCTION if exists addtoexpungementlookup(TEXT,TEXT,TEXT,TEXT);
create or replace FUNCTION addtoexpungementlookup(
    IN inputtablename TEXT,
    IN inputunencryptedcolumns TEXT,
    IN inputencryptedcolumns TEXT,
    IN inputobjecttype TEXT
)
RETURNS VOID 
language plpgsql
as $function$
BEGIN

-- initialize the entry into the encryption lookup table
    insert into cjams.expungementlookup(
        tablename, 
        expungedtablename, 
        tablepk, 
        tablecolumns, 
        untouchedcolumns, 
        nullyfiedcolumns,
        objecttype
        )
    values(
        inputtablename,
        CONCAT(inputtablename, '_expunge'),
        '',
        '',
        inputunencryptedcolumns,
        inputencryptedcolumns,
        inputobjecttype
    );

-- add in the table columns
    update cjams.expungementlookup el
    set tablecolumns= (
        select
        string_agg(column_name, ',') as table_columns
        from information_schema.columns isc
        where table_schema = 'cjams'
        and isc.table_name = inputtablename
    )where el.tablename = inputtablename;

--get and update table_pk
    update cjams.expungementlookup el
    set tablepk = (
        select
        column_name
        from information_schema.key_column_usage kcu 
        where kcu.table_name = inputtablename
        and kcu.constraint_name like 'pk_%'
    )
    where el.tablename = inputtablename;

end
$function$;

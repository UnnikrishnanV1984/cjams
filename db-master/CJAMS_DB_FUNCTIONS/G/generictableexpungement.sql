-- parameters are table_name, record_pk
-- call generictableexpungement('intakeservicerequest', '659583dc-d0fd-4fa5-a212-dfe39ec8464d')
-- generic record expungement function
DROP FUNCTION IF EXISTS generictableexpungement(TEXT,TEXT[]);
CREATE OR REPLACE FUNCTION generictableexpungement(
    IN input_table_name TEXT,
    IN input_record_pk TEXT[]
)
RETURNS integer 
LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 11/17/2025 Micheal Youngdahl/Manasa Kasula - Implementation for Expungement Job for Sexual Abuse Cases expungement (CIDM-10890)
-- 02/03/2026 Manasa/Vineet - Implementation for Expungement Job for Sexual Abuse Cases with out data expungement (CIDM-10890)
------------------------------------------------------------------------ 
DECLARE
    expungement_schema text = 'expunge';
    expunged_table_name TEXT;
    table_pk TEXT;
    v_tablecolumns TEXT;
    v_nullyfiedcolumns TEXT;
    rows_to_null_str TEXT := '';
    expunged_insert_query TEXT;
    nullify_query TEXT;
    null_uuid_value UUID := '00000000-0000-0000-0000-000000000000';
BEGIN
    -- Lookup expungement metadata
    SELECT
        el.expungedtablename,
        el.tablepk,
        el.tablecolumns,
        el.nullyfiedcolumns
    INTO
        expunged_table_name,
        table_pk,
        v_tablecolumns,
        v_nullyfiedcolumns
    FROM expungementlookup el
    WHERE el.tablename = input_table_name;

    -- Build insert query
    expunged_insert_query := format(
        'INSERT INTO %I.%I (%s) SELECT %s FROM %I WHERE %I::TEXT = ANY($1)',
        expungement_schema,
        expunged_table_name,
        v_tablecolumns,
        v_tablecolumns,
        input_table_name,
        table_pk       
    );

    -- Build nullify query
    SELECT string_agg(
        format('%I = NULL', col),
        ', '
    )
    INTO rows_to_null_str
    FROM unnest(string_to_array(v_nullyfiedcolumns, ',')) AS col;

    SELECT concat(
        'updatedby= ''EXPUNG'',activeflag = 0,updatedon = now(),isexpunged = 1,',
        rows_to_null_str
    )
    INTO rows_to_null_str;

    nullify_query := format(
        'UPDATE %I SET %s WHERE %I::TEXT = ANY($1)',
        input_table_name,
        rows_to_null_str,
        table_pk
    );

    if(input_table_name = 'actor') then    
         nullify_query :=  format('UPDATE cjams.actor
                            SET
                            personid = %L,
                            actortype = '''',
                            mentalillnessdetail = NULL,
                            mentalimpairdetail = NULL,
                            dangertoworkerreason = NULL,
                            intakenumber = NULL,
                            updatedby= ''EXPUNG'',
                            activeflag = 0,
                            updatedon = now(),
                            isexpunged = 1
                    WHERE actorid::TEXT = ANY($1) and servicecaseid is null',
                    null_uuid_value);   
    end if;  
    if(input_table_name = 'intakeservicerequestactor') then    
         nullify_query :=  format('UPDATE cjams.intakeservicerequestactor
                            SET
                            personid = NULL,
                            intakeservicerequestpersontypekey = NULL,
                            intakenumber = NULL,
                            updatedby= ''EXPUNG'',
                            activeflag = 0,
                            updatedon = now(),
                            isexpunged = 1
                    WHERE intakeservicerequestactorid::TEXT = ANY($1) and servicecaseid is null',
                    null_uuid_value);   
    end if;  
    if(input_table_name = 'intakeservrequestsdmmaltreatment') then    
         nullify_query :=  format('UPDATE cjams.intakeservrequestsdmmaltreatment
                            SET
                            maltreatmenttype = '''',
                            maltreatorsname  = ''''
                    WHERE sdmmaltreatmentid::TEXT = ANY($1)');   
    end if;  
    if(input_table_name = 'progressnotedetail') then    
         nullify_query :=  format('UPDATE cjams.progressnotedetail
                            SET
                            description = '''',
                            updatedby= ''EXPUNG'',
                            activeflag = 0,
                            updatedon = now(),
                            isexpunged = 1                            
                    WHERE progressnotedetailid::TEXT = ANY($1)');   
    end if;      
    if(input_table_name = 'progressnote') then    
         nullify_query :=  format('UPDATE cjams.progressnote
                            SET
                            title                        = NULL,
                            description                  = NULL,
                            entitytype                   = '''',
                            contactname                  = NULL,
                            contactphone                 = NULL,
                            contactemail                 = NULL,
                            traveltime                   = NULL,
                            totaltime                    = NULL,
                            progressnotereasontypekey    = NULL,
                            locationname                 = NULL,
                            otherpersonname              = NULL,
                            uploadedfile                 = NULL,
                            adjustmentfostercaretext     = NULL,
                            screeningfortheservicetext   = NULL,
                            qualityofcaretochildtext     = NULL,
                            fk_user_id                   = NULL,
                            witsid                       = 0,
                            servicesprovided             = NULL,
                            otherservices                = NULL,
                            otherrisk                    = NULL,
                            focusperson                  = NULL,
                            updatedby                    = ''EXPUNG'',
                            activeflag                   = 0,
                            updatedon                    = now(),
                        isexpunged                       = 1                              
                    WHERE progressnoteid::TEXT = ANY($1)');   
    end if;      

    -- Debug output    
    -- Execute queries
    EXECUTE expunged_insert_query using input_record_pk;
    EXECUTE nullify_query using input_record_pk;

    return 1;

    EXCEPTION
    WHEN OTHERS THEN
        RAISE WARNING 'Error occurred: %', SQLERRM;
        return -1;
   
END;
$function$;

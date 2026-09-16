CREATE OR REPLACE FUNCTION cjams.get_audittrail_field_difference(v_new json, v_old json, audittype character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$  
---------------------------------------------
--  Revisions -----
--- 01/31/2024 Manasa Kasula : special characters[] are entered in the narrative text field(CIDM-8373)
--- 01/19/2025 Naresh moola : special characters[] are entered in the 'actionsTaken' field(CDM-44588)
--- 12/11/2025 Vinesh Puthan : Code fix to Allow special characters ' [] ' entered in the caseworker and supervisor comments section for safe-c assessment(CDM-44618)
----------------------------------------------
DECLARE
    modifieddata_v jsonb;
    lukupdata_v json;    
    _rec record;
    _jsonrec record;
    _jsonarray_diff json;
    
BEGIN
   
    modifieddata_v := '[]';    

    SELECT fieldjson INTO lukupdata_v
    FROM audittraillukup
    WHERE typekey = $3
            AND activeflag = 1;
   
    IF $2 is not null then
   
        FOR _rec in
            SELECT
              o.key
              , o.value AS old_value
              , n.value AS new_value
              , lukup.displayname AS display_name
              , coalesce (lukup."datatype", 'text') as data_type
            FROM json_each($1) n
            INNER JOIN json_each($2) o ON o.key = n.key
            INNER JOIN (SELECT * FROM json_to_recordset(lukupdata_v) AS x("key" text, "displayname" text, "datatype" text, "alias" text)) lukup on lower(coalesce(lukup.alias, lukup.key))::text = lower(n.key)
        LOOP
            IF (_rec.old_value::text IS DISTINCT FROM _rec.new_value::text) then

            IF(_rec.data_type = 'json') then

                 raise debug '_rec check inside if %', _rec;
             
                         FOR _jsonrec in
                            SELECT
                              o.key
                              , o.value AS old_value
                              , n.value AS new_value
                              , lukup.displayname AS display_name
                            FROM json_each(_rec.new_value) n
                            INNER JOIN json_each(_rec.old_value) o ON o.key = n.key
                            INNER JOIN (SELECT * FROM json_to_recordset(lukupdata_v) AS x("key" text, "displayname" text, "datatype" text, "alias" text)) lukup on lower(coalesce(lukup.alias, lukup.key))::text = lower(n.key)
                        loop
                        
                        		  raise debug '_rec check inside nested loop %', _jsonrec; 
                                IF (_jsonrec.old_value::text IS DISTINCT FROM _jsonrec.new_value::text) then
                                    modifieddata_v = modifieddata_v || row_to_json(_jsonrec)::jsonb;
                                end if;
                        END LOOP;

            ELSIF(_rec.data_type = 'json_array') THEN
              
            IF (COALESCE(_rec.old_value::text,'[]') !='[]' AND COALESCE(_rec.new_value::text,'[]') !='[]') THEN 
                SELECT * INTO _jsonarray_diff FROM get_audittrail_array_difference(_rec.new_value, _rec.old_value); 
            ELSIF  (COALESCE(_rec.old_value::text,'[]') ='[]' OR COALESCE(_rec.new_value::text,'[]') !='[]') THEN

              SELECT 	json_agg(JSON_BUILD_OBJECT('key', n.KEY,'data_type','text','display_name',n.key ,'old_value', NULL,'new_value', n.value)) INTO _jsonarray_diff
              FROM  	jsonb_each( (SELECT json_array_elements(_rec.new_value))::jsonb) n ;
            ELSIF  (COALESCE(_rec.old_value::text,'[]') !='[]' OR COALESCE(_rec.new_value::text,'[]') =='[]') THEN 

              SELECT 	json_agg(JSON_BUILD_OBJECT('key', n.KEY,'data_type','text','display_name',n.key ,'new_value', NULL,'old_value', n.value)) INTO _jsonarray_diff
              FROM  	jsonb_each( (SELECT json_array_elements(_rec.old_value))::jsonb) n ;
            END IF;
                    IF(_jsonarray_diff::text != '[]') THEN

                    -- select JSON_BUILD_OBJECT('key',_rec.key,'data_type','json_array' , 'display_name', _rec.display_name
                    -- ,'jsondata', _jsonarray_diff) into _jsonobj;
                    SELECT  json_Agg(t.value)::jsonb into modifieddata_v FROM (
                    SELECT  t.value FROM  json_array_elements(modifieddata_v::json)t union all 
                     SELECT t.value FROM  json_array_elements(_jsonarray_diff::json) t
                    ) t ;
                           --  modifieddata_v = modifieddata_v ||  CONCAT('{"key": "', _rec.key, '",
                          --   "data_type": "json_array",  "display_name": "', _rec.display_name, '", "jsondata": ', _jsonarray_diff, '}'); 
                    END IF;
            ELSE
                    SELECT  json_Agg(t.value)::jsonb into modifieddata_v FROM (
                    SELECT  t.value FROM  json_array_elements(modifieddata_v::json)t union all 
                     SELECT row_to_json(_rec) t
                    ) t ;
                  --  modifieddata_v = modifieddata_v || row_to_json(_rec)::jsonb;

             end if;
            END IF;
          END LOOP;

    ELSE 
   
            FOR _rec IN
                SELECT
                    n.key
                    , n.value AS new_value
                    , null as old_value
                    , lukup.displayname AS display_name
                    , coalesce (lukup."datatype", 'text') as data_type
                FROM json_each(to_json($1)) n
                INNER JOIN (SELECT * FROM json_to_recordset(lukupdata_v) AS x("key" text, "displayname" text, "datatype" text, "alias" text)) lukup on lower(coalesce(lukup.alias, lukup.key))::text = lower(n.key)
             LOOP
            -- IF (_rec.old_value::text IS DISTINCT FROM _rec.new_value::text) then
            raise debug 'new_value %',_rec. display_name;
            _jsonarray_diff:='[]';
             IF(_rec.data_type = 'json') then
             
                         FOR _jsonrec in
                            SELECT
                              n.key
                              , n.value AS new_value
                              , null as old_value
                              , lukup.displayname AS display_name
                            FROM json_each(_rec.new_value) n
                            INNER JOIN (SELECT * FROM json_to_recordset(lukupdata_v) AS x("key" text, "displayname" text, "datatype" text, "alias" text)) lukup on lower(coalesce(lukup.alias, lukup.key))::text = lower(n.key)
                        loop
                        			 raise debug '_rec check inside nested loop else block %', _jsonrec; 
                                IF (_jsonrec.old_value::text IS DISTINCT FROM _jsonrec.new_value::text) then
                                    modifieddata_v = modifieddata_v || row_to_json(_jsonrec)::jsonb;
                                end if;
                        END LOOP;
             
             ELSIF ((_rec.data_type ='json_array' OR (_rec.new_value::text ilike '%[%' and _rec.key != 'comments' and _rec.key != 'justification'  and _rec.key != 'actionsTaken' and _rec.key != 'caseworkercomments' and _rec.key != 'supervisorcomments' )) and _rec.key != 'safeccaregivers' ) THEN 
               raise debug 'json_Arr %', _rec.new_value;
                SELECT * INTO _jsonarray_diff FROM get_audittrail_array_difference(_rec.new_value, '[]'::json); 
                IF(_jsonarray_diff::text != '[]') THEN

                     SELECT  json_Agg(t.value)::jsonb into modifieddata_v FROM (
                    SELECT  t.value FROM  json_array_elements(modifieddata_v::json)t union all 
                     SELECT t.value FROM  json_array_elements(_jsonarray_diff::json) t
                    ) t ;
                    END IF;
             ELSE 
                           modifieddata_v = modifieddata_v || row_to_json(_rec)::jsonb;
            --  end if;
            END IF;
          END LOOP;
                         
    END IF;
    
   -- Added by Agathya. For scenarios where each record has a primary value (ex., Vaccine Name) that does not chagne for each modification, the name needs to be sent to UI as part of the modified data json. skipcomparison key is checked and the data is added to the modified data, if this key is set to true. 
  FOR _rec IN
      SELECT  n.key
              , n.value AS new_value
              , null as old_value
              , lukup.displayname AS display_name
              , coalesce (lukup."datatype", 'text') as data_type
              FROM json_each(to_json($1)) n
              INNER JOIN (SELECT * FROM json_to_recordset(lukupdata_v) as x("key" text, "displayname" text, "datatype" text, "alias" text, "skipcomparison" text)) lukup 
              ON lower(lukup.alias)::text = lower(n.key) and lower(lukup.skipcomparison)::text = 'true'
             LOOP
            raise debug 'skipcomparison new_value %',_rec. display_name;            
            modifieddata_v = modifieddata_v || row_to_json(_rec)::jsonb;
    END LOOP;
	-- End of addition.  
	     
  RETURN modifieddata_v;

END;

$function$
;

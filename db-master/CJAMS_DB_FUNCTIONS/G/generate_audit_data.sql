drop FUNCTION if exists cjams.generate_audit_data(parenttablename varchar, parentprimarykey uuid, OUT vs_success_sw character varying, OUT vs_message character varying);
CREATE OR REPLACE FUNCTION cjams.generate_audit_data(parenttablename varchar, parentprimarykey uuid, OUT vs_success_sw character varying, OUT vs_message character varying)
RETURNS record
 LANGUAGE plpgsql
AS $function$  

DECLARE
VL_EXCEP_FLAG INTEGER DEFAULT 0;
hist_table_v varchar;
primary_key_col varchar;
prev_data json;
current_data json;
modifieddata_v json;
qry1 varchar;
qry2 varchar;
insertqry varchar;
column_names varchar;
vaccine_type json;
field json;
rowkey text[];
rowqry varchar;
rowqryresult varchar;
col_str varchar;
alias_name varchar;
alias_qry varchar;
col_row record;
temp_row varchar;

BEGIN

modifieddata_v := '[]';
col_str := '';

--find history table details from audittraillukup
--------------------------------------------------
SELECT historytablename, primarykeyname INTO hist_table_v, primary_key_col
FROM cjams.audittraillukup
WHERE typekey = $1;

-- find required audit columns
-------------------------------
for col_row IN select (json_array_elements_text(a2.fieldjson)::json)->>'key','as',
	(json_array_elements_text(a2.fieldjson)::json)->>'alias'
		from audittraillukup a2 where a2.typekey=$1
 loop
	
	temp_row := col_row;
	temp_row := replace(temp_row,',',' ');
	temp_row := replace(temp_row,'(','');
	temp_row := replace(temp_row,')','');
	if (col_str='') then
		col_str := temp_row ;
	ELSE
		col_str := col_str || ', ' || temp_row;
	end if;
	
end loop;

--pick latest record from main table as currentdata
---------------------------------------------------
qry1 := format('SELECT COALESCE(json_agg(e), ''[]'') FROM ( 
	SELECT %s
    FROM %I WHERE %I = $1
	)e', col_str, parenttablename, primary_key_col);


EXECUTE qry1 INTO current_data using parentprimarykey;

--check for any query keys in the fieldjson and replace the query result in current_data
-----------------------------------------------------------------------------------------
for field IN select (json_array_elements_text(a2.fieldjson)::json)
		from audittraillukup a2 where a2.typekey=$1
loop
	IF field->>'query' is not null THEN

		rowqry := (field->>'query') || '''' || $2 || '''' ;
		IF field->>'query2' is not null THEN  
			rowqry := rowqry || (field->>'query2');
		end IF;
		rowkey := concat('{0,',field->>'alias','}');		
		EXECUTE rowqry into rowqryresult;
		current_data := jsonb_set (to_jsonb(current_data), rowkey,concat('"',rowqryresult,'"')::jsonb, false);	
		
	end IF;

end loop;
raise debug 'current_data-----%',current_data;

--pick latest record in history table as previous data
-------------------------------------------------------
qry2 := format('SELECT currentdata FROM %I WHERE %I = $1 order by updatedon desc limit 1',hist_table_v,primary_key_col);

EXECUTE qry2 INTO prev_data using parentprimarykey;

raise debug 'prev_data--%',prev_data;

current_data := json_array_elements_text(current_data)::json;

--find audit field difference as modified data 
-----------------------------------------------
SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(current_data, prev_data, $1); --3rd param is not being used in the function

raise debug 'modifieddata%', modifieddata_v;

--insert record into history table
-----------------------------------
if (prev_data is null) then 
prev_data:= 'null';
end if;

insertqry := format('INSERT INTO %I SELECT gen_random_uuid(), $1::json, $2::json, $3::json, ''HISTORY''::character varying, t.* 
             FROM %I t WHERE %I = $4',hist_table_v,parenttablename,primary_key_col);

-- Use EXECUTE ... USING so JSON content (with commas, quotes, etc.) is safely passed
EXECUTE insertqry
  USING current_data, prev_data, modifieddata_v, parentprimarykey;

RAISE debug 'VL_EXCEP_FLAG % ',VL_EXCEP_FLAG; --error handling testing required
	IF  VL_EXCEP_FLAG != 1 THEN
		VS_SUCCESS_SW := 'yes';
		vs_message := 'Run successful';
	ELSE
		VS_SUCCESS_SW := 'no'; 
		vs_message := 'Run unsuccessful';
	END IF;

END;

$function$
;
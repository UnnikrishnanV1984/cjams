CREATE OR REPLACE FUNCTION cjams.get_audittrail_array_diff_level2(v_first_data json, v_second_data json)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare

l_first_data json;
l_second_data json;
l_loop_data json;
l_temp json;
l_modifieddata json := '[]';
l_counter_1 integer := 0;
l_counter_2 integer := 0;
l_nest_arr record;
l_len integer :=0;
l_prcsloop integer :=0;
l_temprec json ;

---------------------------------------------------------
-- CDM-34513 Veera Nadimpalli - FDTM Assessment save issue fix
---------------------------------------------------------

begin
l_counter_2 := 1;	
l_counter_1 :=1;
FOR l_first_data IN  SELECT  *  FROM	json_array_elements(v_first_data::json)  LOOP
	
	l_loop_data := '[]';
	  raise notice 'l_counter_1  val  %',l_counter_1;

	  
SELECT t.valtext::JSON FROM (SELECT  ROW_NUMBER () OVER() row_id, t.valtext  FROM 
								(SELECT json_array_elements(v_second_data::json) as "valtext" ) t
								)  t WHERE t.row_id = l_counter_1 
								INTO l_temprec;
								raise notice 'l_temprec  %',l_temprec;
	IF (COALESCE(l_temprec,'{}')::TEXT = '{}' )	THEN 
		SELECT json_agg(JSON_BUILD_OBJECT('key', n.KEY,'data_type','text','display_name',n.key ,'old_value',NULL,'new_value', n.value)) INTO l_loop_data
			from jsonb_each(l_first_data::jsonb) n
			WHERE  n.value::TEXT NOT ILIKE '%[%';
			SELECT  json_Agg(t.value)::jsonb into l_modifieddata FROM (
								SELECT  t.value FROM  json_array_elements(l_modifieddata::json)t union all 
									SELECT t.value FROM  json_array_elements(l_loop_data::json) t
								) t ;
			FOR l_nest_arr IN SELECT  n.value new_value, n.key newkey FROM 
				jsonb_each(l_first_data::jsonb) n
				where  n.value::TEXT  ILIKE '%[%'
			LOOP 
				l_loop_data := '[]';
				SELECT 	json_agg(JSON_BUILD_OBJECT('key', l_nest_arr.newkey,'data_type','text','display_name',l_nest_arr.newkey
						,'old_value', NULL,'new_value', l_nest_arr.new_value)) INTO l_loop_data;
				SELECT  json_Agg(t.value)::jsonb into l_modifieddata FROM (
								SELECT  t.value FROM  json_array_elements(l_modifieddata::json)t union all 
									SELECT t.value FROM  json_array_elements(l_loop_data::json) t
								) t ;
			END LOOP;

	END IF;

	FOR l_second_data IN  SELECT t.valtext FROM (SELECT  ROW_NUMBER () OVER() row_id, t.valtext  FROM 
								(SELECT json_array_elements(v_second_data::json) as "valtext" ) t
								)  t WHERE t.row_id = l_counter_1   LOOP
			l_counter_2 := 1;
 										  				  raise notice 'l_second_data l_counter_2 diff  val  %',l_second_data;

			l_first_data:= COALESCE(l_first_data,'{}')::json;
			l_second_data:= COALESCE(l_second_data,'[]')::json;
			raise notice 'l_first_data %', l_first_data;
			raise notice 'l_second_data %', l_second_data;
			IF(l_counter_2 = 1) THEN 	
				 l_loop_data:='[]';
				 l_prcsloop:=1;
				 IF (l_first_data::TEXT !='{}'::text AND l_second_data::TEXT ='{}'::text) THEN 
					SELECT 	json_agg(JSON_BUILD_OBJECT('key', n.KEY,'data_type','text','display_name',n.key ,'old_value', NULL,'new_value', n.value)) INTO l_loop_data
				    FROM 	jsonb_each(l_first_data::jsonb) n;
					l_prcsloop:=0;
				 ELSIF (l_first_data::TEXT ='{}' AND l_second_data::TEXT !='{}') THEN 
					SELECT 	json_agg(JSON_BUILD_OBJECT('key', n.KEY,'data_type','text','display_name',n.key ,'new_value', NULL,'old_value', n.value)) INTO l_loop_data
				    FROM 	jsonb_each(l_second_data::jsonb) n;
					l_prcsloop:=0;
				 ELSIF (l_first_data::TEXT ='{}' AND l_second_data::TEXT ='{}') THEN 
					l_loop_data:='[]';
					l_prcsloop:=0;
				 END IF;
				 IF (l_prcsloop =0) THEN 
					IF(COALESCE(l_loop_data::text,'[]' )!= '[]') then
						-- l_modifieddata :=  (l_modifieddata::jsonb || CONCAT('{"data" : ', l_loop_data, '}') ::jsonb)::json;
						SELECT  json_Agg(t.value)::jsonb into l_modifieddata FROM (
								SELECT  t.value FROM  json_array_elements(l_modifieddata::json)t union all 
									SELECT t.value FROM  json_array_elements(l_loop_data::json) t
								) t ;
					END IF;
				 ELSE
					SELECT json_agg(JSON_BUILD_OBJECT('key', n.KEY,'data_type','text','display_name',n.key ,'old_value', o.value,'new_value', n.value)) INTO l_loop_data
						from jsonb_each(l_first_data::jsonb) n
						join jsonb_each(l_second_data::jsonb) o on o.key = n.key
					where o.value <> n.value   AND n.value::TEXT NOT ILIKE '%[%';
					IF(COALESCE(l_loop_data::text,'[]' )!= '[]') then
						-- l_modifieddata :=  (l_modifieddata::jsonb || CONCAT('{"data" : ', l_loop_data, '}') ::jsonb)::json;
						SELECT  json_Agg(t.value)::jsonb into l_modifieddata FROM (
								SELECT  t.value FROM  json_array_elements(l_modifieddata::json)t union all 
									SELECT t.value FROM  json_array_elements(l_loop_data::json) t
								) t ;
					END IF;
					FOR l_nest_arr IN SELECT o.value old_value, n.value new_value FROM 
							jsonb_each(l_first_data::jsonb) n
								join jsonb_each(l_second_data::jsonb) o on o.key = n.key
							where o.value <> n.value  AND n.value::TEXT  ILIKE '%[%'
						LOOP 
							
							IF (l_nest_arr.old_value!='null' AND  COALESCE(l_nest_arr.old_value::text,'[]')!='[]') THEN 
														

								SELECT * INTO l_loop_data FROM get_audittrail_array_difference(
								l_nest_arr.new_value::JSON, l_nest_arr.old_value::json); 
							ELSE 
								--raise notice 'inside  %',LEN(l_nest_arr.new_value::text ILIKE '[{');
								SELECT CASE WHEN l_nest_arr.new_value::text ILIKE '%[{%' THEN 1 ELSE 0 END INTO l_len;
								IF (COALESCE(l_len,0) >0)  THEN 
									SELECT 	json_agg(JSON_BUILD_OBJECT('key', n.KEY,'data_type','text','display_name',n.key ,'old_value', NULL,'new_value', n.value)) INTO l_loop_data
									FROM  	jsonb_each( (SELECT json_array_elements(l_nest_arr.new_value::json))::jsonb) n ;
								ELSE 
									SELECT 	json_agg(JSON_BUILD_OBJECT('key', t.KEY,'data_type','text','display_name',t.key ,'old_value', NULL,'new_value', t.value)) INTO l_loop_data
									FROM (
										SELECT * FROM jsonb_each (l_first_data::jsonb)) t
									WHERE t.value = l_nest_arr.new_value;

								END IF;
							END IF;
					
								SELECT  json_Agg(t.value)::jsonb into l_modifieddata FROM (
									SELECT  t.value FROM  json_array_elements(l_modifieddata::json)t union all 
										SELECT t.value FROM  json_array_elements(l_loop_data::json) t
									) t ;
						END LOOP ;
					-- RAISE NOTICE 'tempn data ->>%',l_loop_data;

				END IF;
			END IF;	
			
						l_counter_2 := l_counter_2 + 1;

	END LOOP;

	-- RAISE NOTICE 'tempn data 111 ->>%',l_loop_data;
	
	l_counter_1 := l_counter_1 + 1; 

END LOOP;					

return l_modifieddata;
end

$function$
;

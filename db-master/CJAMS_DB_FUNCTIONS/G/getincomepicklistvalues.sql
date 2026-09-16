
DROP  FUNCTION if exists getincomepicklistvalues ();
create or replace function getincomepicklistvalues () 
returns json
language  plpgsql 
as $function$

declare 
j_picklistvalues json;

begin 
	
	select json_agg (value) into j_picklistvalues from (
	select picklist_value_cd,picklist_type_id, value_tx from tb_picklist_values 
	where picklist_type_id in (38,248,632,97,207) and 
    trim(picklist_value_cd) in ('583','2837','2838','2839','1322','1323','1326','2015','1330','1331','1319','1320','1321','1324','1325','2275','1328')
	order by value_tx asc) value;
	
	
return j_picklistvalues;
end $function$;
DROP FUNCTION IF EXISTS cjams.getpersonnameandid(uuid);


CREATE OR REPLACE FUNCTION getpersonnameandid(v_personid uuid)
 RETURNS TABLE(personDescription text)
 LANGUAGE plpgsql
AS $function$

   
begin	

	return query
	
select concat (coalesce(firstname,null),' ', coalesce(middlename,null), ' ', coalesce(lastname,null), ' ',
coalesce(suffix,null), '(', cjamspid,')') as personDescription  from person  where personid = v_personid ;



end;
$function$
;

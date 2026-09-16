-- FUNCTION: cjams.f_prim_assignment_new(ai_entity_id uuid, as_entity_type_cd character varying)

-- DROP FUNCTION cjams.f_prim_assignment_new(ai_entity_id uuid, as_entity_type_cd character varying);

CREATE OR REPLACE FUNCTION cjams.f_prim_assignment_new(ai_entity_id uuid, as_entity_type_cd character varying)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
begin

RETURN
(SELECT TAB.STAFF_ID FROM (SELECT 
						ROW_NUMBER() OVER() AS NUM
						, up.securityusersid AS STAFF_ID
					FROM caseassignment ca, userprofile up
					WHERE ca.objectid = ai_entity_id AND 
						ca.activeflag = 1 AND 
						ca.objecttypekey = as_entity_type_cd AND 
						ca.responsibilitytypekey = 'family' AND  
						ca.enddate IS NULL AND 
						ca.toworkeridno = up.securityusersid AND 
						up.activeflag = 1) TAB 
WHERE NUM = 1 );
			
end;

$function$

DROP FUNCTION IF EXISTS getrelationshiptype(character varying);
DROP FUNCTION IF EXISTS getrelationshiptype(character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.getrelationshiptype(v_teamtypekey character varying, v_actortypekey character varying DEFAULT '')
 RETURNS TABLE(sequencenumber integer, relationshiptypekey character varying, description text, activeflag integer, effectivedate timestamp without time zone, personrelationship boolean, relationshipId int4)
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------------------------------------------
-- Revision(s) 

--09/25/2024 Kapila Mandhadi-CIDM-9176-B-195071-B-195071 Relationship ID in GAP initial Determination IV-E screen userstory changes
------------------------------------------------------------------------------------------------------------	

BEGIN

RETURN Query
		
	SELECT  
    rt.sequencenumber,rt.relationshiptypekey,rt.description,rt.activeflag,rt.effectivedate,rt.personrelationship, rel.fourerelid as relationshipId
	FROM relationshiptype rt
	INNER JOIN relationshiptypeagency rta ON rt.relationshiptypekey = rta.relationshiptypekey AND rta.activeflag =1
	INNER JOIN relationshiptype rel ON rel.relationshiptypekey = rta.relationshiptypekey AND rel.activeflag =1
	WHERE rta.teamtypekey = v_teamtypekey AND rt.activeflag =1
	and case when (v_actortypekey !='' and  v_actortypekey is not null) then (rt.actortypekey=v_actortypekey or rt.actortypekey='both') else 1=1 end
	AND CASE WHEN v_teamtypekey = 'DJS' then rt.relationshiptypekey NOT IN ('norelation') ELSE 1=1 END
	ORDER BY rt.description;
	
END;

$function$;
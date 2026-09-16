drop function if exists getimmunizationconfig(character varying);

CREATE OR REPLACE FUNCTION cjams.getimmunizationconfig(v_agetype character varying)
 RETURNS TABLE(totalcount bigint, personimmunizationconfigid uuid, value_text character varying, description character varying, uiconfig jsonb, agetype character varying, vaccineschedule text)
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------
--Revision
--09/05/2024 Sushma Bade - CIDM-9378 CRISP - person immunization screen
--09/13/2024 Yogeshvar - CIDM-9413 Add vaccine schedule for CRISP
-------------------------------------------------
DECLARE  

	
BEGIN 


IF (v_agetype = 'All') THEN

return query

 select count(1) over(),pc.personimmunizationconfigid,pc.value_text,pc.description,pc.uiconfig,pc.agetype, pc.vaccineschedule from personimmunizationconfig pc where pc.activeflag = 1
 and pc.immunizationkey is not null order by pc.value_text;


 else 

 return query

select count(1) over(),pc.personimmunizationconfigid,pc.value_text,pc.description,pc.uiconfig,pc.agetype, pc.vaccineschedule from personimmunizationconfig pc where (pc.agetype=v_agetype or pc.agetype = 'AGE_INDEPENDENT') and pc.activeflag = 1
order by pc.displayorder asc;
end if;
 
END;

$function$;

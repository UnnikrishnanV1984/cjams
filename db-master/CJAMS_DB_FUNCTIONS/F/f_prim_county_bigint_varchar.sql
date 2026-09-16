-- FUNCTION: cjams.f_prim_county(bigint, character varying)

-- DROP FUNCTION cjams.f_prim_county(bigint, character varying);

CREATE OR REPLACE FUNCTION cjams.f_prim_county(
	ai_entity_id bigint,
	as_entity_type character varying)
RETURNS character varying
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
AS $BODY$

DECLARE
    --declare v_servicecaseid uuid;
    --declare v_adoptioncaseid uuid;
    declare v_intakeserviceid uuid;
    declare v_case_id uuid;
    
    v_case_count bigint;
    
BEGIN

	if UPPER(ltrim(rtrim(as_entity_type))) = 'NULL' then
		--check for sevicecase
		select sc.servicecaseid into v_case_id from servicecase sc where sc.servicecasenumber = ai_entity_id :: character varying;
		--if servicecase in not available, check for adoptioncase
		if (coalesce(v_case_id :: character varying,'') = '' ) then
			select ad.adoptioncaseid into v_case_id from adoptioncase ad where ad.adoptioncasenumber = ai_entity_id :: character varying;
		end if;
	end if;

	--ai_entity_id has to be bigint for the below logic to work
	if (coalesce(v_case_id :: character varying,'') = '' ) then
		select count(1) into v_case_count from intakeservicerequest ins
			where ins.servicerequestnumber = ai_entity_id :: character varying;

		if(v_case_count > 0) then
			select ins.servicecaseid,ins.intakeserviceid into v_case_id, v_intakeserviceid from intakeservicerequest ins
	  		where ins.servicerequestnumber = ai_entity_id :: character varying;
		end if;
		if(coalesce(v_case_id :: character varying, '') = '' ) then 
			v_case_id := v_intakeserviceid ;
		end if;
	end if;

	return (
	
		select c.statecountycode
		from caseassignment ca  
		join county c on c.countyid:: character varying = ca.toldssid:: character varying
		where ca.objectid = v_case_id
		and lower(ca.responsibilitytypekey) = 'family'
		and ca.activeflag = 1
		order by ca.insertedon desc
		limit 1
	
		--select c.statecountycode from caseassignment ca 
		--join team t on t.teamid = ca.fromteamid and t.activeflag=1
		--join county c on c.countyid :: character varying = t.countyid and c.activeflag =1
		--where ca.objectid = v_case_id and ca.activeflag = 1 order by ca.updatedon desc limit 1
		);
END;

$BODY$;



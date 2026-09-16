CREATE OR REPLACE FUNCTION cjams.f_prim_county(ai_entity_id bigint, as_entity_type character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Description: To get primary responsible county of the case

-- Revisions:
-- Vineet Tirodkar 09/18/2020 Changes for Adult Services Cases
------------------------------------------------------------------------------------------------
DECLARE
    -- declare v_servicecaseid uuid;
    -- declare v_adoptioncaseid uuid;
    declare v_intakeserviceid uuid;
    declare v_case_id uuid;
    
    v_case_count bigint;
	v_teamtypekey character varying;
    
BEGIN

	if UPPER(ltrim(rtrim(as_entity_type))) = 'NULL' then
		--check for sevicecase
		select sc.servicecaseid 
			into v_case_id 
		from servicecase sc 
		where sc.servicecasenumber = ai_entity_id::character varying;
		
		--if servicecase in not available, check for adoptioncase
		if (coalesce(v_case_id :: character varying,'') = '' ) then
			select ad.adoptioncaseid 
				into v_case_id 
			from adoptioncase ad 
			where ad.adoptioncasenumber = ai_entity_id::character varying;
		end if;
	end if;

	--ai_entity_id has to be bigint for the below logic to work
	if (coalesce(v_case_id :: character varying,'') = '' ) then
		select count(1) 
			into v_case_count 
		from intakeservicerequest ins
		where ins.servicerequestnumber = ai_entity_id::character varying;

		if(v_case_count > 0) then
			select ins.servicecaseid,	
					ins.intakeserviceid, 
					ins.teamtypekey
				into v_case_id, 
					v_intakeserviceid,
					v_teamtypekey					
			from intakeservicerequest ins
	  		where ins.servicerequestnumber = ai_entity_id::character varying;
		end if;
		
		if(coalesce(v_case_id :: character varying, '') = '' ) then 
			v_case_id := v_intakeserviceid ;
		end if;
		
	end if;
	
	if coalesce(v_teamtypekey, '')  = '' then
		v_teamtypekey = '';
	end if;

	if btrim(v_teamtypekey) = 'AS' then
		return (
					select trim(ct.statecountycode)::character varying 
						from caseassignment ca 
							join teammemberassignment tma on tma.securityusersid = ca.toworkeridno 
								and tma.activeflag = 1
							join teammember tmb on tmb.teammemberid = tma.teammemberid  
								and tmb.activeflag = 1
							join team tm on tm.teamid = tmb.teamid
								and tm.activeflag = 1
							join county ct on ct.countyid::character varying = tm.countyid	
								and ct.activeflag = 1
					where ca.objectid = v_case_id
						and ca.activeflag = 1
					order by ca.insertedon desc
					limit 1 
				);
	else	
		return (
					select c.statecountycode
						from caseassignment ca  
							join county c on c.countyid:: character varying = ca.toldssid::character varying
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
	end if;		
END;

$function$
;

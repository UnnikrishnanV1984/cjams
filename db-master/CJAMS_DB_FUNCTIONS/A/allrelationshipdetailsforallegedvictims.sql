DROP FUNCTION IF EXISTS cjams.allrelationshipdetails(v_caseid character varying, v_victimList character varying, v_maltreatorlist Character varying);

CREATE OR REPLACE FUNCTION cjams.allrelationshipdetails(v_caseid character varying, v_victimlist text[], v_maltreatorlist text[])
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 06/06/2023 - Palani/Chandra - CIDM-7251 - performance tuning
-- 09/12/2023 - Vineet Tirodkar - To check if victim and maltreater relationship is established in the same CPS case (CIDM-7713)
------------------------------------------------------------------------
DECLARE
v_response json;

BEGIN

    select json_agg(x) 
		into v_response  
	from (	select * 
			from (
					select distinct on (ar.person1id,ar.person2id,rt.description,
						up.firstname,up2.firstname) ar.person1id as secondaryuserid,
						ar.person2id as primaryuserid,
						rt.description,
						up.firstname,
						up2.firstname, 
						ar.updatedon, 
						ar.relationshiptypekey
					from actor a 
						inner join intakeservicerequestactor isa on isa.actorid = a.actorid
						inner join person up on up.personid = a.personid
						inner join actorrelationship ar on ar.person2id = up.personid 
							and ar.activeflag = 1
						inner join intakeservicerequestactor isa2 
							on isa2.intakeservicerequestactorid = ar.intakeservicerequestactorid 
								and isa2.intakeserviceid = isa.intakeserviceid
						inner join person up2 on up2.personid = ar.person2id
						left join relationshiptype rt on rt.relationshiptypekey= ar.relationshiptypekey  
							and rt.activeflag = 1
					where a.activeflag = 1 
						and isa.activeflag=1
						and isa.intakeserviceid = v_caseid::uuid 
						and (	ar.person2id::text = any(v_victimList) 
								or
								ar.person1id::text = any(v_victimList) 		
							)	
						and (	ar.person1id::text = any(v_maltreatorlist)
								or
								ar.person2id::text = any(v_maltreatorlist)
							)	
						and isa.intakeservicerequestpersontypekey in ('AM','AV')
				) y 
				order by updatedon desc
		) x;
       
RETURN v_response;
END  
$function$
;

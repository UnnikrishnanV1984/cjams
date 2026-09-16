CREATE OR REPLACE FUNCTION f_prim_county_interface(ai_entity_id character varying, OUT county character varying)
RETURNS character varying
LANGUAGE plpgsql
AS $function$

declare
ai_entity_cd varchar;--
ai_entity1_id varchar; --
ai_entity2_id varchar; --
ai_case_id uuid; --
sec_id uuid;

BEGIN

SELECT servicecasenumber INTO  ai_entity1_id from servicecase where servicecasenumber = ai_entity_id; --
SELECT adoptioncasenumber INTO ai_entity2_id from adoptioncase where adoptioncasenumber = ai_entity_id ;--

IF(ai_entity_id = ai_entity1_id)THEN
    ai_case_id:= (SELECT servicecaseid from servicecase where servicecasenumber = ai_entity_id); --
ELSIF (ai_entity_id = ai_entity2_id) THEN
     ai_case_id:= (SELECT servicecaseid from servicecase where servicecasenumber = ai_entity_id); --
END IF ; --
SELECT routing.tosecurityusersid into sec_id
FROM  routing
WHERE (routing.objectid = ai_case_id::varchar) and
 routing.activeflag=1 and routing.eventcode= 'SRVC';

select c.statecountycode INTO county
from county c,userprofileaddress upa
where  c.countyname=upa.county and c.activeflag=1 and upa.activeflag=1 and
upa.securityusersid = sec_id::character varying  LIMIT 1;

END ;
$function$
;


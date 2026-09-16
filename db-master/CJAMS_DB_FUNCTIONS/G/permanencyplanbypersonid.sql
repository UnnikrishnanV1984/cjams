DROP FUNCTION IF EXISTS cjams.permanencyplanbypersonid(uuid, uuid);
CREATE OR REPLACE FUNCTION cjams.permanencyplanbypersonid(
v_servicecaseid uuid,
v_personid uuid)
RETURNS JSON
LANGUAGE 'plpgsql'

COST 100
VOLATILE
AS $BODY$

declare 
v_result json;

begin

select JSON_agg(x) into v_result from (select 
count(1) over(),
(select pl.startdatetime from placement pl 
	where pl.personid = isra.personid and pl.isvoided = 0 
 	and pl.service_id in (11405,11406,11407,11408,11409,9,10,11,12,13,71,78,11339) 
 	and pl.enddatetime is null order by startdatetime desc limit 1) as fostercarestartdate, *
from permanencyplan p
inner join intakeservicerequestactor isra on isra.intakeservicerequestactorid = p.intakeservicerequestactorid
where p.servicecaseid = v_servicecaseid and isra.personid = v_personid order by p.establisheddate desc) x;

RETURN v_result;


END;

$BODY$;
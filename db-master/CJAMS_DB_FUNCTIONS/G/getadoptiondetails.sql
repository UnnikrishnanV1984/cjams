CREATE OR REPLACE FUNCTION cjams.getadoptiondetails(v_clientid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 07/31/2023 Palani/Chandra - Query Optimization (CIDM-7587)


------------------------------------------------------------------------------------------------------------
DECLARE
jsondata json;

begin
select json_agg(d) INTO jsondata from
(select
(select cjamspid from person where personid = adoptionclientid) as adoption_client,
(select adoptioncasenumber from adoptioncase where adoptioncaseid = a.adoptioncaseid) as adoption_case,
(select cjamspid from person where personid = a.preadoptionclientid) as bio_client,
 a.preadoptionclientid as bio_personid,
( select ap.servicecaseid from adoptionbreakthelink adb,
adoptionplanning ap where adb.adoptionplanningid = ap.adoptionplanningid and adb.adoptionplanningid = a.preadoptioncaseid)as bio_case
from adoptionlink a where activeflag = 1 and adoptionclientid in (select personid
from person
where cjamspid = v_clientid::bigint)
) d ;
   
RETURN jsondata;
END;

 $function$
;

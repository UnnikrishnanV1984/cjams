------------------------------------------------------------------------
-- Revision(s)
-- 10/01/2024 Anil Dharni - Creation of get_client_eligibility_data function(CDM-9282)
------------------------------------------------------------------------

CREATE
OR REPLACE FUNCTION cjams.get_client_eligibility_data(p_client_id integer) RETURNS TABLE(
    clientpid bigint,
    adoption_case uuid,
    bioclientid bigint,
    old_personid uuid,
    new_personid uuid,
    bio_servicecase character varying,
    servicecaseid uuid
) LANGUAGE plpgsql
AS $function$ BEGIN RETURN QUERY
select
    p.cjamspid as clientpid,
    a.adoptioncaseid as adoption_case,
    p2.cjamspid as bioclientid,
    p2.personid as old_personid,
    p.personid as new_personid,
    sc.servicecasenumber as bio_servicecase,
    sc.servicecaseid as servicecaseid
from
    adoptionlink a
    join person p on a.adoptionclientid = p.personid
    join person p2 on a.preadoptionclientid = p2.personid
    join servicecase sc on sc.servicecaseid = (
        select
            ap.servicecaseid
        from
            adoptionbreakthelink adb,
            adoptionplanning ap
        where
            adb.adoptionplanningid = ap.adoptionplanningid
            and adb.adoptionplanningid = a.preadoptioncaseid
    )
where
    a.activeflag = 1
    and p.cjamspid = p_client_id;

END;
$function$
;
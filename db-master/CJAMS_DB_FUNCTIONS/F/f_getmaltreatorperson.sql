DROP FUNCTION IF EXISTS cjams.f_getmaltreatorperson(v_investigationallegationid uuid); 
DROP FUNCTION IF EXISTS cjams.f_getmaltreatorperson(uuid, integer, character varying);
DROP FUNCTION IF EXISTS cjams.f_getmaltreatorperson(uuid, integer);

CREATE OR REPLACE FUNCTION cjams.f_getmaltreatorperson(v_investigationallegationid uuid, v_isExpungementSuperUser integer DEFAULT 0)
RETURNS uuid
  
 LANGUAGE plpgsql
AS $function$

--Revision(s)
-- 12/17/2025 - Umasankar Raavi - CIDM-10890 - Expungement changes for partial, fully expunged, and normal cases.
-- 4/29/2026 - Vinesh- CDM-44818 - Fixed issue caused due to expungement story changes CIDM-11118
-- 4/30/2026 - Vinesh- CDM-44818 - Fixed add person issue reverting to previous version and adding limit 1

DECLARE
   
    v_case_count bigint;
    
BEGIN

IF v_isExpungementSuperUser = 1 THEN

    return
    (
        select personid from
        (
            (
                select distinct i.personid as personid
                from intakeservicerequestactor i
                where exists (select 1 from investigationallegationmaltreators m
                    where m.intakeservicerequestactorid = i.intakeservicerequestactorid
                    and m.activeflag = 1
                    and m.investigationallegationid = v_investigationallegationid)
                    limit 1
            )

            UNION ALL

            (
                select distinct i_expunge.personid
                from expunge.intakeservicerequestactor_expunge i_expunge
                where COALESCE(v_isExpungementSuperUser,0) = 1 and 
                exists (select 1 from expunge.investigationallegationmaltreators_expunge m_expunge
                    where m_expunge.intakeservicerequestactorid = i_expunge.intakeservicerequestactorid
                    and m_expunge.activeflag = 1 
                    and m_expunge.investigationallegationid = v_investigationallegationid)
                    limit 1
            )
        ) t
        limit 1
    );
ELSE 

    return   
        (
            select distinct i.personid as personid
            from intakeservicerequestactor i
            where exists (select 1 from investigationallegationmaltreators m
                where m.intakeservicerequestactorid = i.intakeservicerequestactorid
                and m.activeflag = 1
                and m.investigationallegationid = v_investigationallegationid)
                limit 1
        );

END IF;

END;

$function$
;
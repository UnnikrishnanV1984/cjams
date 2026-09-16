DROP FUNCTION IF EXISTS cjams.getpersonimmunizationlist_filter(json, bigint, bigint); --clean up _ ones in all envs
DROP FUNCTION IF EXISTS cjams.getpersonimmunizationlistfilter(json, bigint, bigint);
CREATE OR REPLACE FUNCTION cjams.getpersonimmunizationlistfilter (
   IN filters       json,
   IN v_lipagenumber   BIGINT,
   IN v_lipagesize     BIGINT,
   IN searchobj        json default null)
   RETURNS TABLE
           (
              totalcount                    BIGINT,
              personimmunizationid          uuid,
              personid                      uuid,
              dob                           TIMESTAMP WITHOUT TIME ZONE,
              immunizationtypekey           CHARACTER VARYING,
              personimmunizationconfigid    uuid,
              immunizationdate              DATE,
              comments                      CHARACTER VARYING,
              sourcesystem                  CHARACTER VARYING,
              updatedon                     TIMESTAMP WITHOUT TIME ZONE,
              updatedby                     CHARACTER VARYING,
              dose                          CHARACTER VARYING,
              insertedon                    TIMESTAMP WITHOUT TIME ZONE,
              insertedby                    CHARACTER VARYING,
              recordstatus                  int4,
              agetype                       CHARACTER VARYING,
              vaccinename                   CHARACTER VARYING,
              description                   CHARACTER VARYING
           )
   LANGUAGE 'plpgsql'
   VOLATILE
   NOT LEAKPROOF
   SECURITY INVOKER
   PARALLEL UNSAFE
   ROWS 1000
AS
$function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 09/05/2024 - Charan sai Bodapati - New coloumn recordstatus added to check the status of the Immunization record (CIDM-9378) 
-- 09/05/2024 Sushma Bade - CIDM-9378 CRISP - person immunization screen
-- 09/13/2024 Yogeshvar - CIDM-9413 Add filters for personimmunization list
-- 03/24/2025 Simar Singh -- CIDM-10103 add filter values for searching along with person id
------------------------------------------------------------------------------------------------------------

DECLARE
   v_client_id             BIGINT;
   v_pagenumber            INT;
   v_pageoffset            INT;
   v_securityuserid        CHARACTER VARYING;
   v_vacc_startDate        date;
   v_vacc_endDate          date;
	v_updatedon_startDate   date;
	v_updatedon_endDate     date;
    v_personid uuid;
    v_startDate timestamp;
    v_endDate   timestamp;  
BEGIN
   v_pagenumber := v_liPageNumber - 1;
   v_pageoffset := v_pagenumber * v_liPageSize;

	v_vacc_startDate := searchObj ->> 'immunizationstartdt';
	v_vacc_endDate := searchObj ->> 'immunizationenddt';
	v_updatedon_startDate := searchObj ->> 'updatedonstartdt';
	v_updatedon_endDate := searchObj ->> 'updatedonenddt';
    v_startDate := (filters ->> 'startDate')::timestamp;
    v_endDate := (filters ->> 'endDate')::timestamp;
    v_personid := (filters ->> 'personid')::uuid;

   RETURN QUERY
        SELECT count (1) OVER () AS totalcount,
               pip.personimmunizationid,
               pip.personid,
               (select p.dob from person p where p.activeflag = 1 and p.personid = v_personid) as dob, 
               pip.immunizationtypekey,
               pip.personimmunizationconfigid,
               pip.immunizationdate::date,
               pip."comments",
               pip.sourcesystem,
               pip.updatedon,
               pip.updatedby,
               pip.dose,
               pip.insertedon,
               pip.insertedby,
               pip.recordstatus, 
               pic.agetype,
               pic.value_text as vaccinename,
               pic.description
         FROM personimmunization pip 
         INNER JOIN personimmunizationconfig pic ON pip.personimmunizationconfigid = pic.personimmunizationconfigid and pic.immunizationkey is not null
         WHERE pip.personid = v_personid AND pip.activeflag = 1 and pic.activeflag = 1
         and (v_vacc_startDate is null or pip.immunizationdate::date >= v_vacc_startDate)
         and (v_vacc_endDate is null or pip.immunizationdate::date <= v_vacc_endDate)
         and (v_updatedon_startDate is null or pip.updatedon::date >= v_updatedon_startDate)
         and (v_updatedon_endDate is null or pip.updatedon::date <= v_updatedon_endDate)
         and case when v_startDate is not null and pip.immunizationdate is not null then pip.immunizationdate >= Date(v_startDate) else true end
         and case when v_endDate is not null and pip.immunizationdate is not null then pip.immunizationdate <= Date(v_endDate) else true end
         ORDER BY insertedon DESC;
END;                                                                                                                                                                                                                                                                                                                                                     

$function$
;
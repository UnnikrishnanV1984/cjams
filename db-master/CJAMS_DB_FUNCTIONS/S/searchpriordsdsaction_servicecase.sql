DROP FUNCTION IF EXISTS cjams.searchpriordsdsaction_servicecase(uuid, varchar);

CREATE OR REPLACE FUNCTION cjams.searchpriordsdsaction_servicecase(v_personid uuid, v_userid character varying)
 RETURNS TABLE(objectid character varying, danumber character varying, daplanningid character varying, dasubtype text, roles jsonb, datereceived timestamp without time zone, datecreated timestamp without time zone, datecompleted timestamp without time zone, status character varying, datype text, county character varying, restrictstatus text, outcomes json, personname text, relationshiparray json, workername character varying, headofhousehlod json, allegedmaltreator json)
 LANGUAGE plpgsql
AS $function$    
BEGIN 

RETURN QUERY

SELECT * FROM (
        -- Service cases
        SELECT s_c.servicecaseid::character varying,
            s_c.servicecasenumber::character varying as DANumber,
            ''::character varying,
            (
                select scr.programkey || '/' || scr.subprogramkey
                from servicecaserequest scr
                where scr.servicecaseid = s_c.servicecaseid
                    and scr.activeflag = 1
                order by scr.insertedon desc
                limit 1
            ) as dasubtype,
            jsonb_agg(ref_role.value_text) as roles,
            s_c.startdate as DateReceived,
            s_c.startdate as DateCreated,
            case
                when lower(s_c.dispositioncode) = 'closed' then scd.effectivedate
                else null
            end AS DateCompleted,
            s_c.dispositioncode::character varying as Status,
            'Service Case' as datype,
            (
                select c.countyname
                from caseassignment a,
                    county c
                where a.toldssid = c.countyid
                    and a.objectid = s_c.servicecaseid
                    and a.responsibilitytypekey in ('family', 'child')
                    and a.activeflag = 1
                order by a.enddate desc
                limit 1
            )::character varying as county,
            (
                SELECT *
                FROM getRestrictedCaseStatus(s_c.servicecaseid::text, v_userid)
            ) AS restrictStatus,
            null::json,
            null::text,
            null::json,
            (
                SELECT cast(
                        UP.firstname || ' ' || UP.lastname as character varying
                    ) as workername
                FROM routing R
                    INNER JOIN userprofile UP on UP.securityusersid = R.tosecurityusersid
                WHERE R.objectid = s_c.servicecaseid::character varying
                    AND R.activeflag = 1
                limit 1
            ), (
                SELECT json_agg(x) as headofhousehlod
                FROM (
                        SELECT distinct concat_ws(
                                ' ',
                                coalesce(p.firstname, null),
                                coalesce(p.middlename, null),
                                coalesce(p.lastname, null),
                                coalesce(p.suffix, null)
                            )::character varying as personname
                        FROM intakeservicerequestactor ISRA
                            INNER JOIN person p on p.personid = ISRA.personid
                            AND p.activeflag = 1
                            INNER JOIN actor A ON A.actorid = ISRA.actorid
                            AND A.activeflag = 1
                        WHERE ISRA.activeflag = 1
                            AND ISRA.isheadofhousehold = true
                            AND ISRA.servicecaseid = s_c.servicecaseid
                        ORDER BY 1
                    ) as x
            )::json,
            (
                SELECT json_agg(x) as allegedmaltreator
                FROM (
                        SELECT DISTINCT P.firstname,
                            P.lastname,
                            P.middlename,
                            P.suffix
                        from person P
                            INNER JOIN actor A on A.personid = P.personid
                            AND A.activeflag = 1
                            INNER JOIN intakeservicerequestactor ISRA on ISRA.actorid = A.actorid
                            AND ISRA.activeflag = 1
                        WHERE ISRA.servicecaseid = s_c.servicecaseid
                            and ISRA.intakeservicerequestpersontypekey = 'AM'
                    ) as x
            )::json
        FROM person pr
            inner join IntakeServiceRequestActor Actor on Actor.personid = pr.personid
            and Actor.activeflag = 1
            and Actor.intakeservicerequestpersontypekey not in ('AM')
            inner join referencevalues ref_role on ref_role.ref_key = actor.intakeservicerequestpersontypekey
            and ref_role.referencetypeid in (175, 176)
            and ref_role.ref_key not in (
                select insa.intakeservicerequestpersontypekey
                from intakeservicerequestactor insa
                where insa.intakeservicerequestactorid = Actor.intakeservicerequestactorid
                    and insa.spexpungementflag = 1
            )
            join servicecase s_c on s_c.servicecaseid = Actor.servicecaseid
            and s_c.activeflag = 1
            LEFT JOIN servicecasedisposition scd on scd.servicecaseid = s_c.servicecaseid
        where scd.activeflag = 1
            and scd.servicecasedispositionid IN (
                select servicecasedispositionid
                from servicecasedisposition scd_i
                where scd_i.servicecaseid = s_c.servicecaseid
                    and scd_i.activeflag = 1
                order by effectivedate DESC
                limit 1
            )
            and pr.personid = v_personid
            and (
                select count(1)
                from intakeservicerequestactor insa
                where insa.intakeservicerequestactorid = Actor.intakeservicerequestactorid
                    and insa.spexpungementflag = 1
            ) = 0
            AND Actor.activeflag = 1
        group by s_c.servicecaseid,
            s_c.servicecasenumber,
            s_c.startdate,
            scd.dispositioncode,
            scd.effectivedate,
            scd.intakeserreqstatustypekey 
    ) AS datav
WHERE datav.restrictStatus in ('INCL', 'INCLRES', 'EXCLUDE')
order by datav.datype,
    datav.DateReceived desc;
END;
$function$
;

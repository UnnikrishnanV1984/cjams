DROP FUNCTION IF EXISTS cjams.searchpriordsdsaction_intake(uuid, varchar);

CREATE OR REPLACE FUNCTION cjams.searchpriordsdsaction_intake(v_personid uuid, v_userid character varying)
 RETURNS TABLE(objectid character varying, danumber character varying, daplanningid character varying, dasubtype character varying, roles jsonb, datereceived timestamp without time zone, datecreated timestamp without time zone, datecompleted timestamp without time zone, status text, datype character varying, county character varying, restrictstatus text, outcomes json, personname text, relationshiparray json, workername character varying, headofhousehlod json, allegedmaltreator json)
 LANGUAGE plpgsql
AS $function$ 
BEGIN

RETURN QUERY

SELECT * FROM (
        -- Intae / Referrals                              
        SELECT staging.intakenumber,
            staging.intakenumber AS DANumber,
            ''::character varying,
            ''::character varying AS dasubtype,
            jsonb_agg(ref_role.value_text) AS roles,
            staging.daterecieved AS DateReceived,
            (staging.jsondata->'General'->>'CreatedDate')::timestamp without time zone as DateCreated,
            null::timestamp without time zone AS DateCompleted,
            ISRST.description AS Status,
            'Intake'::character varying AS datype,
            county.countyname AS county,
            (
                SELECT *
                FROM getRestrictedCaseStatus(staging.intakenumber::text, v_userid)
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
                WHERE R.objectid = staging.intakenumber::character varying
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
                            AND ISRA.intakenumber = staging.intakenumber
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
                        WHERE ISRA.intakenumber = staging.intakenumber
                            and ISRA.intakeservicerequestpersontypekey = 'AM'
                    ) as x
            )::json
        FROM person pr
            inner join IntakeServiceRequestActor Actor on Actor.personid = pr.personid
            and Actor.activeflag = 1
            INNER JOIN referencevalues ref_role ON ref_role.ref_key = actor.intakeservicerequestpersontypekey
            and ref_role.referencetypeid in (175, 176)
            and ref_role.ref_key not in (
                select insa.intakeservicerequestpersontypekey
                from intakeservicerequestactor insa
                where insa.intakeservicerequestactorid = Actor.intakeservicerequestactorid
                    and insa.spexpungementflag = 1
            )
            LEFT JOIN IntakeServiceRequest ISR ON ISR.intakeserviceid = Actor.intakeserviceid
            and ISR.teamtypekey = 'CW'
            LEFT JOIN IntakeSerReqStatusType ISRST ON ISR.IntakeSerReqStatusTypeId = ISRST.IntakeSerReqStatusTypeId
            JOIN (
                SELECT y.intakenumber,
                    y.daterecieved,
                    y.jsondata,
                    y.status
                FROM intakedastaging y
                    JOIN (
                        SELECT max(a.id) as id,
                            a.intakenumber,
                            max(a.versionnumber) as versionnumber
                        from intakedastaging a
                        where a.activeflag = 1
                            and a.teamtypekey = 'CW'
                            and lower(a.status) in ('complete', 'closed', 'pending')
                        group by a.intakenumber
                    ) x ON x.id = y.id
            ) staging ON staging.intakenumber = Actor.intakenumber
            LEFT JOIN county ON county.countyid::text = (jsondata->'General'->>'countyid')
        WHERE
            pr.personid = v_personid
            and (
                select count(1)
                from intakeservicerequestactor insa
                where insa.intakeservicerequestactorid = Actor.intakeservicerequestactorid
                    and insa.spexpungementflag = 1
            ) = 0
            AND Actor.activeflag = 1
        GROUP BY staging.jsondata,
            staging.intakenumber,
            staging.daterecieved,
            ISRST.description,
            county.countyname
        UNION ALL
        -- Migrated Intake / Referrals
        SELECT isr.intakenumber,
            isr.intakenumber AS DANumber,
            ''::character varying,
            ''::character varying AS dasubtype,
            jsonb_agg(ref_role.value_text) AS roles,
            isr.reporteddate AS DateReceived,
            isr.effectivedate as DateCreated,
            null::timestamp without time zone AS DateCompleted,
            (
                SELECT CASE
                        WHEN ids.status = 2 THEN 'Accepted'
                        WHEN ids.status = 8 THEN 'Closed'
                        ELSE 'Pending'
                    END
                FROM intakedastatus ids
                WHERE ids.intakenumber = isr.intakenumber
                    AND ids.activeflag = 1
                LIMIT 1
            ) AS status,
            'Intake'::text AS datype,
            county.countyname AS county,
            (
                SELECT *
                FROM getRestrictedCaseStatus(isr.intakenumber::text, v_userid)
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
                WHERE R.objectid = isr.intakenumber::character varying
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
                            AND ISRA.intakenumber = isr.intakenumber
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
                        WHERE ISRA.intakenumber = isr.intakenumber
                            and ISRA.intakeservicerequestpersontypekey = 'AM'
                    ) as x
            )::json
        FROM person pr
            inner join IntakeServiceRequestActor Actor on Actor.personid = pr.personid
            and Actor.activeflag = 1
            INNER JOIN referencevalues ref_role ON ref_role.ref_key = actor.intakeservicerequestpersontypekey
            and ref_role.referencetypeid in (175, 176)
            and ref_role.ref_key not in (
                select insa.intakeservicerequestpersontypekey
                from intakeservicerequestactor insa
                where insa.intakeservicerequestactorid = Actor.intakeservicerequestactorid
                    and insa.spexpungementflag = 1
            )
            JOIN IntakeServiceRequest ISR ON ISR.intakenumber = Actor.intakenumber
            AND ISR.activeflag = 1
            AND ISR.intakenumber ILIKE 'cw%'
            AND ISR.teamtypekey = 'CW'
            JOIN IntakeSerReqStatusType ISRST ON ISR.IntakeSerReqStatusTypeId = ISRST.IntakeSerReqStatusTypeId
            left join county ON isr.countyid = county.countyid
        WHERE
            pr.personid = v_personid
            and (
                select count(1)
                from intakeservicerequestactor insa
                where insa.intakeservicerequestactorid = Actor.intakeservicerequestactorid
                    and insa.spexpungementflag = 1
            ) = 0
            AND Actor.activeflag = 1
        GROUP BY isr.intakenumber,
            isr.reporteddate,
            isr.effectivedate,
            ISRST.description,
            county.countyname       
    ) AS datav
WHERE datav.restrictStatus in ('INCL', 'INCLRES', 'EXCLUDE')
order by datav.datype,
    datav.DateReceived desc;
END;
$function$
;
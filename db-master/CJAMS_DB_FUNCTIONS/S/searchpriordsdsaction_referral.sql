DROP FUNCTION IF EXISTS cjams.searchpriordsdsaction_referral(uuid, varchar);
CREATE
OR REPLACE FUNCTION cjams.searchpriordsdsaction_referral(v_personid uuid, v_userid character varying) RETURNS TABLE(
    objectid character varying,
    danumber character varying,
    daplanningid character varying,
    dasubtype character varying,
    roles jsonb,
    datereceived timestamp without time zone,
    datecreated timestamp without time zone,
    datecompleted timestamp without time zone,
    status character varying,
    datype character varying,
    county character varying,
    restrictstatus text,
    outcomes json,
    personname text,
    relationshiparray json,
    workername character varying,
    headofhousehlod json,
    allegedmaltreator json
) LANGUAGE plpgsql AS $function$ 
BEGIN RETURN QUERY
SELECT
    *
FROM
    (
        -- CPS cases
        SELECT
            ISR.IntakeServiceId :: character varying,
            case
                when ISRT.intakeservreqtypekey = 'Information and Referral' then ISR.intakenumber
                else ISR.ServiceRequestNumber
            end as DANumber,
            '' :: character varying,
            SRST.description as dasubtype,
            jsonb_agg(ref_role.value_text) as roles,
            ISR.Reporteddate as DateReceived,
            ISR.Insertedon as DateCreated,
            case
                when ISRST.intakeserreqstatustypekey in ('Completed', 'Closed') then COALESCE(
                    ISR.exitdate,
                    (
                        select
                            statusdate
                        from
                            intakeservicerequestdispositioncode st
                        where
                            st.IntakeSerReqStatusTypeid = ISRST.IntakeSerReqStatusTypeid
                            and st.intakeserviceid = ISR.intakeserviceid
                        order by
                            statusdate desc
                        limit
                            1
                    )
                )
                else null
            end AS DateCompleted,
            ISRST.intakeserreqstatustypekey AS Status,
            case
                when ISRT.intakeservreqtypekey = 'Request for services' then 'Service Case'
                else ISRT.description
            end as datype,
            (
                select
                    c.countyname
                from
                    caseassignment a,
                    county c
                where
                    a.toldssid = c.countyid
                    and a.objectid = ISR.IntakeServiceId
                    and a.responsibilitytypekey in ('family', 'child')
                    and a.activeflag = 1
                order by
                    a.enddate desc
                limit
                    1
            ) as county,
            (
                SELECT
                    *
                FROM
                    getRestrictedCaseStatus(ISR.intakeserviceid :: text, v_userid)
            ) AS restrictStatus,
            (
                select
                    json_agg(invst)
                from
                    (
                        select
                            COALESCE(p.firstname, '') || ' ' || COALESCE(p.middlename, '') || ' ' || COALESCE(p.lastname, '') || ' ' || COALESCE(p.suffix, '') as personname,
                            (
                                select
                                    COALESCE(p.prefx, '') || ' ' || COALESCE(p.firstname, '') || ' ' || COALESCE(p.middlename, '') || ' ' || COALESCE(p.lastname, '') || ' ' || COALESCE(p.suffix, '')
                                from
                                    person p
                                where
                                    p.personid in (
                                        select
                                            *
                                        from
                                            f_getmaltreatorperson(ia.investigationallegationid)
                                    )
                            ) as maltreatorname,
                            (
                                SELECT
                                    json_agg(finding)
                                FROM
                                    (
                                        SELECT
                                            IFN.investigationfindingtypekey,
                                            IFN.investigationfindingid,
                                            IFN.findingcomments,
                                            IFN.isharm,
                                            IFN.isharmsubstantial,
                                            IFN.harmdesc,
                                            IFN.intentionalinjurydesc,
                                            IFNT.description AS findingdescription,
                                            IFN.omissiondesc,
                                            IFN.finalfinding,
                                            CASE
                                                WHEN iaml.overridefindingtypekey IS NOT NULL THEN (
                                                    SELECT
                                                        IFNT.description
                                                    FROM
                                                        investigationfindingtype IFNT
                                                    WHERE
                                                        IFNT.investigationfindingtypekey = iaml.overridefindingtypekey
                                                        AND IFNT.activeflag = 1
                                                )
                                                WHEN IFN.finalfinding IS NOT NULL THEN (
                                                    SELECT
                                                        IFNT.description
                                                    FROM
                                                        investigationfindingtype IFNT
                                                    WHERE
                                                        IFNT.investigationfindingtypekey = IFN.finalfinding
                                                        AND IFNT.activeflag = 1
                                                )
                                            END AS finalfindingdescription,
                                            CASE
                                                WHEN (iaml.oahearingdecision) IS NOT NULL THEN (
                                                    SELECT
                                                        IFNT.description
                                                    FROM
                                                        investigationfindingtype IFNT
                                                    WHERE
                                                        IFNT.investigationfindingtypekey = iaml.oahearingdecision
                                                        AND IFNT.activeflag = 1
                                                )
                                                WHEN(iaml.cchearingdecisiontypekey) IS NOT NULL THEN (
                                                    SELECT
                                                        IFNT.description
                                                    FROM
                                                        investigationfindingtype IFNT
                                                    WHERE
                                                        IFNT.investigationfindingtypekey = iaml.cchearingdecisiontypekey
                                                        AND IFNT.activeflag = 1
                                                )
                                                WHEN (iaml.csahearingdecisiontypekey) IS NOT NULL THEN (
                                                    SELECT
                                                        IFNT.description
                                                    FROM
                                                        investigationfindingtype IFNT
                                                    WHERE
                                                        IFNT.investigationfindingtypekey = iaml.csahearingdecisiontypekey
                                                        AND IFNT.activeflag = 1
                                                )
                                                WHEN (iaml.coahearingdecisiontypekey) IS NOT NULL THEN (
                                                    SELECT
                                                        IFNT.description
                                                    FROM
                                                        investigationfindingtype IFNT
                                                    WHERE
                                                        IFNT.investigationfindingtypekey = iaml.coahearingdecisiontypekey
                                                        AND IFNT.activeflag = 1
                                                )
                                                WHEN (iaml.overridefindingtypekey) IS NOT NULL THEN (
                                                    SELECT
                                                        IFNT.description
                                                    FROM
                                                        investigationfindingtype IFNT
                                                    WHERE
                                                        IFNT.investigationfindingtypekey = iaml.overridefindingtypekey
                                                        AND IFNT.activeflag = 1
                                                )
                                            END AS appealfindingdescription,
                                            --for appeals
                                            iaml.overridefindingtypekey,
                                            iaml.finalizeddate,
                                            CASE
                                                WHEN iaml.expungementflag = 1 THEN true
                                                ELSE false
                                            END as expungement,
                                            (
                                                SELECT
                                                    json_agg(ass)
                                                FROM
(
                                                        SELECT
                                                            ifna.firstname,
                                                            ifna.lastname,
                                                            ifna.comments,
                                                            PT.typedescription,
                                                            ifna.professiontypekey,
                                                            ifna.isassessor
                                                        FROM
                                                            investigationfindingassessors ifna
                                                            LEFT JOIN professiontype PT ON ifna.professiontypekey = PT.professiontypekey
                                                        WHERE
                                                            ifna.investigationfindingid = IFN.investigationfindingid
                                                    ) ass
                                            ) :: json as assessors
                                        FROM
                                            investigationfinding IFN
                                            join investigationfindingtype IFNT on IFNT.investigationfindingtypekey = IFN.investigationfindingtypekey
                                            INNER JOIN Investigationallegationmaltreators iaml ON iaml.investigationallegationid = IFN.investigationallegationid
                                            AND iaml.activeflag = 1
                                        WHERE
                                            IFN.investigationallegationid = IA.investigationallegationid
                                            and IFN.activeflag = 1
                                        ORDER BY
                                            iaml.updatedon desc
                                        LIMIT
                                            1
                                    ) as finding
                            ) as findings,
                            (
                                case
                                    when (
                                        select
                                            count(investigationallegationhistoryid)
                                        from
                                            investigationallegation_history iah
                                        where
                                            iah.investigationallegationid = ia.investigationallegationid
                                    ) > 0 then true
                                    else false
                                end
                            ) maltreatmenttypemanualchange,
                            isra.intakeservicerequestpersontypekey,
                            alle."name",
                            (
                                select
                                    rt.description
                                from
                                    relationshiptype rt
                                    inner join actorrelationship ar on rt.relationshiptypekey = ar.relationshiptypekey
                                    and ar.activeflag = 1
                                    and rt.activeflag = 1
                                    join person up on up.personid = ar.person1id
                                    join person up2 on up2.personid = ar.person2id
                                where
                                    ar.person1id = isra.personid
                                    and ar.person2id in (
                                        select
                                            *
                                        from
                                            f_getmaltreatorperson(ia.investigationallegationid)
                                    )
                                ORDER BY
                                    ar.insertedon DESC
                                LIMIT
                                    1
                            )
                        from
                            investigation inv
                            join Investigationmaltreatment im on im.investigationid = inv.investigationid
                            and im.activeflag = 1
                            JOIN Investigationmaltreatmentactor ima on ima.maltreatmentid = im.maltreatmentid
                            AND ima.activeflag = 1
                            JOIN intakeservicerequestactor isra on isra.intakeservicerequestactorid = ima.intakeservicerequestactorid
                            JOIN person p on p.personid = isra.personid
                            JOIN Investigationallegation ia ON ia.investigationmaltreatmentactorid = ima.investigationmaltreatmentactorid
                            JOIN allegation alle on alle.allegationid = ia.allegationid
                            AND alle.activeflag = 1
                        where
                            inv.intakeserviceid = ISR.intakeserviceid
                    ) as invst
            ),
            null :: text,
            (
                select
                    json_agg(x)
                from
                    (
                        select
                            ar.person1id as secondaryuserid,
                            ar.person2id as primaryuserid,
                            rt.description,
                            up.firstname,
                            up2.firstname
                        from
                            relationshiptype rt
                            inner join actorrelationship ar on rt.relationshiptypekey = ar.relationshiptypekey
                            and ar.activeflag = 1
                            and rt.activeflag = 1
                            join person up on up.personid = ar.person1id
                            join person up2 on up2.personid = ar.person2id
                        where
                            ar.intakeservicerequestactorid in (
                                select
                                    ina.intakeservicerequestactorid
                                from
                                    intakeservicerequestactor ina
                                where
                                    ina.intakeserviceid = ISR.intakeserviceid
                            )
                    ) x
            ) :: json as relationshiparray,
            (
                SELECT
                    cast(
                        UP.firstname || ' ' || UP.lastname as character varying
                    ) as workername
                FROM
                    routing R
                    INNER JOIN userprofile UP on UP.securityusersid = R.tosecurityusersid
                WHERE
                    R.objectid = ISR.intakeserviceid :: character varying
                    AND R.activeflag = 1
                    AND R.eventcode = 'INVT'
                    AND R.toroleid = 'CWCW'
                limit
                    1
            ), (
                SELECT
                    json_agg(x) as headofhousehlod
                FROM
                    (
                        SELECT
                            distinct concat_ws(
                                ' ',
                                coalesce(p.firstname, null),
                                coalesce(p.middlename, null),
                                coalesce(p.lastname, null),
                                coalesce(p.suffix, null)
                            ) :: character varying as personname
                        FROM
                            intakeservicerequestactor ISRA
                            INNER JOIN person p on p.personid = ISRA.personid
                            AND p.activeflag = 1
                            INNER JOIN actor A ON A.actorid = ISRA.actorid
                            AND A.activeflag = 1
                        WHERE
                            ISRA.activeflag = 1
                            AND ISRA.isheadofhousehold = true
                            AND ISRA.intakeserviceid = ISR.intakeserviceid
                        ORDER BY
                            1
                    ) as x
            ) :: json,
            (
                SELECT
                    json_agg(x) as allegedmaltreator
                FROM
                    (
                        SELECT
                            DISTINCT P.firstname,
                            P.lastname,
                            P.middlename,
                            P.suffix
                        from
                            person P
                            INNER JOIN actor A on A.personid = P.personid
                            AND A.activeflag = 1
                            INNER JOIN intakeservicerequestactor ISRA on ISRA.actorid = A.actorid
                            AND ISRA.activeflag = 1
                        WHERE
                            ISRA.intakeserviceid = ISR.intakeserviceid
                            and ISRA.intakeservicerequestpersontypekey = 'AM'
                    ) as x
            ) :: json
        FROM
            person pr
            inner join IntakeServiceRequestActor Actor on Actor.personid = pr.personid
            and Actor.activeflag = 1
            inner join referencevalues ref_role on ref_role.ref_key = actor.intakeservicerequestpersontypekey
            and ref_role.referencetypeid in (175, 176)
            and coalesce(ref_role.teamtypekey, '') <> 'AS'
            and ref_role.ref_key not in (
                select
                    insa.intakeservicerequestpersontypekey
                from
                    intakeservicerequestactor insa
                where
                    insa.intakeservicerequestactorid = Actor.intakeservicerequestactorid
                    and insa.spexpungementflag = 1
            )
            join IntakeServiceRequest ISR on ISR.intakeserviceid = Actor.intakeserviceid
            and ISR.activeflag = 1
            and ISR.teamtypekey = 'CW'
            left join IntakeSerReqStatusType ISRST ON ISR.IntakeSerReqStatusTypeId = ISRST.IntakeSerReqStatusTypeId
            JOIN IntakeServiceRequestType ISRT ON ISRT.IntakeServReqTypeId = ISR.IntakeServReqTypeId
            and ISRT.intakeservreqtypekey != 'Request for services'
            JOIN ServiceRequestSubType SRST ON SRST.ServiceRequestSubTypeId = ISR.IntakeServiceRequestClassId
            and (
                case
                    when ISRT.intakeservreqtypekey = 'CHILD' then SRST.description != 'Default'
                    else true
                end
            )
        where
            pr.personid = v_personid
            and (
                select
                    count(1)
                from
                    intakeservicerequestactor insa
                where
                    insa.intakeservicerequestactorid = Actor.intakeservicerequestactorid
                    and insa.spexpungementflag = 1
            ) = 0
            and pr.activeflag = 1
        group by
            ISR.IntakeServiceId,
            ISR.ServiceRequestNumber,
            SRST.description,
            ISR.Reporteddate,
            ISR.Insertedon,
            ISRST.intakeserreqstatustypekey,
            ISRT.description,
            ISRT.intakeservreqtypekey,
            ISRST.IntakeSerReqStatusTypeid
    ) AS datav
WHERE
    datav.restrictStatus in ('INCL', 'INCLRES', 'EXCLUDE')
    and datav.datype = 'Information and Referral'
order by
    datav.datype,
    datav.DateReceived desc;
END;
$function$
;
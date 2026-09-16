DROP FUNCTION IF EXISTS cjams.searchpriorcaselists(uuid, varchar, varchar, varchar);

CREATE OR REPLACE FUNCTION cjams.searchpriorcaselists(v_personid uuid, v_mdmid character varying, v_cisclienid character varying, v_userid character varying)
 RETURNS TABLE(dasubtype character varying, datype character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN

IF v_personid IS NULL THEN
       select personid INTO v_personid from personidentifier
        where (v_mdmid is not null and personidentifiervalue = v_mdmid and personidentifiertypekey = 'MDM_ID')
        or (v_cisclienid is not null and personidentifiervalue = v_cisclienid and personidentifiertypekey = 'IRN');
      IF v_personid is null and v_cisclienid is not null then
        SELECT personid INTO v_personid FROM person where cisclientid = v_cisclienid;
      END IF;
END IF;

RETURN QUERY
    with datav as (
         SELECT 
            SRST.description as dasubtype,
            ISRT.description as datype,
            (SELECT * FROM getRestrictedCaseStatus(ISR.intakeserviceid::text, v_userid::character varying)) AS restrictStatus
            FROM person pr
            join IntakeServiceRequestActor Actor on Actor.personid = pr.personid and Actor.activeflag = 1 and (Actor.spexpungementflag is null or Actor.spexpungementflag <> 1)
            join referencevalues ref_role on ref_role.ref_key = actor.intakeservicerequestpersontypekey
            join IntakeServiceRequest ISR on ISR.intakeserviceid = Actor.intakeserviceid
            JOIN IntakeServiceRequestType ISRT ON ISRT.IntakeServReqTypeId = ISR.IntakeServReqTypeId 
            JOIN  ServiceRequestSubType SRST ON SRST.ServiceRequestSubTypeId = ISR.IntakeServiceRequestClassId
            where pr.personid = v_personid
            and ref_role.referencetypeid in (175, 176) and coalesce(ref_role.teamtypekey,'') <> 'AS'
            and ISR.activeflag = 1 and ISR.teamtypekey = 'CW'
            and ISRT.intakeservreqtypekey != 'Request for services'
            and pr.activeflag = 1
            UNION
            -- Intake / Referrals
            select distinct
            null AS dasubtype,
            'Intake' AS datype,
            (SELECT * FROM getRestrictedCaseStatus(a.intakenumber::text, v_userid::character varying)) AS restrictStatus
            FROM person pr
            join IntakeServiceRequestActor Actor on Actor.personid = pr.personid AND Actor.activeflag = 1
            and (Actor.spexpungementflag is null or Actor.spexpungementflag <> 1)
            JOIN referencevalues ref_role ON ref_role.ref_key = actor.intakeservicerequestpersontypekey 
            join intakedastaging a on a.intakenumber = Actor.intakenumber
            where a.activeflag = 1
            and a.teamtypekey = 'CW' and lower(a.status) in ('complete','closed','pending')
            and pr.personid=v_personid
            and ref_role.referencetypeid in (175, 176)
            UNION 
            -- Migrated Intake / Referrals
            SELECT
            null AS dasubtype,
            'Intake' AS datype,
            (SELECT * FROM getRestrictedCaseStatus(isr.intakenumber::text,  v_userid::character varying)) AS restrictStatus
            FROM person pr
            join IntakeServiceRequestActor Actor on Actor.personid = pr.personid AND Actor.activeflag = 1  
            and (Actor.spexpungementflag is null or Actor.spexpungementflag <> 1)
            JOIN referencevalues ref_role ON ref_role.ref_key = actor.intakeservicerequestpersontypekey 
            JOIN IntakeServiceRequest ISR ON ISR.intakenumber = Actor.intakenumber AND ISR.activeflag = 1
            WHERE pr.personid=v_personid
            and ref_role.referencetypeid in (175, 176)
            AND ISR.intakenumber ILIKE 'cw%' AND ISR.teamtypekey = 'CW'
            UNION
            -- Service cases
            SELECT
            (select scr.programkey || '/' || scr.subprogramkey from servicecaserequest scr
                where scr.servicecaseid = sce.servicecaseid and scr.activeflag = 1
                order by scr.insertedon desc
                limit 1) as dasubtype,
            'Service Case' as datype,
            (SELECT * FROM getRestrictedCaseStatus(sce.servicecaseid::text, v_userid::character varying)) AS restrictStatus
            FROM person pr
            join IntakeServiceRequestActor Actor on Actor.personid = pr.personid AND Actor.activeflag = 1
            and (Actor.spexpungementflag is null or Actor.spexpungementflag <> 1)
            join referencevalues ref_role on ref_role.ref_key = actor.intakeservicerequestpersontypekey 
            join servicecase sce on sce.servicecaseid = Actor.servicecaseid and sce.activeflag = 1
            join servicecasedisposition scd  on scd.servicecaseid = sce.servicecaseid and scd.activeflag = 1
            where pr.personid=v_personid
            and Actor.intakeservicerequestpersontypekey not in ('AM')
            and ref_role.referencetypeid in (175, 176)
            UNION
            --- Adoption case
            select
            '' as dasubtype,
            'Adoption Case' as datype,
            (SELECT * FROM getRestrictedCaseStatus(ac.adoptioncaseid::text, v_userid::character varying)) AS restrictStatus
            FROM adoptioncase ac
            join adoptioncaseactor acar on ac.adoptioncaseid = acar.adoptioncaseid
            join person pr on pr.personid = acar.personid 
            join referencevalues ref_role on ref_role.ref_key = acar.actortypekey
            left join adoptioncasedisposition acd on acar.adoptioncaseid = acd.adoptioncaseid 
            and acar.personid = v_personid
            where pr.personid=v_personid and ref_role.referencetypeid in (175, 176)
            UNION
            ---ROA-CPS Cases
            SELECT
            (select scr.programkey || '/' || scr.subprogramkey
                from servicecaserequest scr 
            where scr.servicecaseid = sce.servicecaseid 
                and scr.activeflag = 1
            order by scr.insertedon desc
            limit 1
            ) as dasubtype,   
            'ROA-CPS' as datype,
            (SELECT * FROM getRestrictedCaseStatus(sce.servicecaseid::text, v_userid::character varying)) AS restrictStatus
            FROM person pr
            join IntakeServiceRequestActor Actor on Actor.personid = pr.personid and Actor.activeflag = 1 
            and (Actor.spexpungementflag is null or Actor.spexpungementflag <> 1)
            join intakesnapshot ins on ins.intakeserviceid = Actor.intakeserviceid
            join referencevalues ref_role on ref_role.ref_key = actor.intakeservicerequestpersontypekey 
            join servicecase sce on sce.servicecaseid = Actor.servicecaseid
            JOIN servicecasedisposition scd  on scd.servicecaseid = sce.servicecaseid 
            where scd.activeflag = 1
            and ins.jsondata->'General'->>'PurposeName' = 'ROA-CPS'
            and pr.personid=v_personid
            and Actor.intakeservicerequestpersontypekey not in ('AM')
            and ref_role.referencetypeid in (175, 176)
            and sce.activeflag = 1
    )
    select dv.dasubtype, dv.datype from datav as dv where dv.restrictStatus in ('INCL','INCLRES','EXCLUDE');

END;

$function$
;

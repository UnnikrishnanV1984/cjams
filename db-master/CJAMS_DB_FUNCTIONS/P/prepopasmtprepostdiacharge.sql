DROP function if exists cjams.prepopasmtprepostdiacharge(uuid,character varying);
CREATE OR REPLACE FUNCTION cjams.prepopasmtprepostdiacharge(v_intakeserviceid uuid, loginsecurityuserid character varying)
 RETURNS TABLE(youthname text, youthdob timestamp without time zone, assistpid character varying, cjamspid bigint,
 youthjurisdiction character varying, caseworkercounty character varying, activefacility character varying,
 projecteddischargedate date, closedfacility character varying, closeddischargedate date)
 LANGUAGE plpgsql
AS $function$

BEGIN
RETURN QUERY 
select INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
       CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ', ' || TRIM(P.middlename)
       ELSE '' END),
       P.dob,P.old_id as assistpid,P.cjamspid, 
       (select PA.county from PersonAddress as PA where PA.PersonId = P.PersonId and PA.ActiveFlag = 1 AND PA.PersonAddressTypeKey = 'C'),   
       (select C.countyname from UserProfileAddress as UPA 
        LEFT JOIN county as C ON C.countyid::character varying= UPA.county and C.ActiveFlag = 1
        where UPA.securityusersid = loginsecurityuserid and UPA.ActiveFlag = 1),
       (select PV.providername from placement as PM 
        JOIN provider as PV
                  ON PV.providerid = PM.providerid and PV.ActiveFlag=1
        JOIN placementadmissionclassificationtype as PACT
                  ON PACT.placementadmissionclassificationkey = PM.placementadmissionclassificationkey and PACT.placementadmissionclassificationkey = 'RES' and PACT.ActiveFlag=1
        where PM.intakeserviceid = v_intakeserviceid --and PM.intakeservicerequestactorid = ISRA.intakeservicerequestactorid
        and PM.ActiveFlag=1 order by PM.Insertedon desc limit 1),
        (select PM.releasedate :: date from placement as PM 
        JOIN placementadmissionclassificationtype as PACT
                  ON PACT.placementadmissionclassificationkey = PM.placementadmissionclassificationkey and PACT.placementadmissionclassificationkey = 'RES' and PACT.ActiveFlag=1
        where PM.intakeserviceid = v_intakeserviceid --and PM.intakeservicerequestactorid = ISRA.intakeservicerequestactorid
        and PM.ActiveFlag=1 order by PM.Insertedon desc limit 1),
        (select PV.providername from placement as PM 
        JOIN placementrelease as PR
             ON PR.placementid = PM.placementid and PR.ActiveFlag=1
        JOIN provider as PV
                  ON PV.providerid = PM.providerid and PV.ActiveFlag=1
        JOIN placementadmissionclassificationtype as PACT
                  ON PACT.placementadmissionclassificationkey = PM.placementadmissionclassificationkey and PACT.placementadmissionclassificationkey = 'RES' and PACT.ActiveFlag=1
        where PM.intakeserviceid = v_intakeserviceid --and PM.intakeservicerequestactorid = ISRA.intakeservicerequestactorid
        and PM.ActiveFlag=1 order by PM.Insertedon desc limit 1),
        (select PR.releasedate :: date from placement as PM 
        JOIN placementrelease as PR
             ON PR.placementid = PM.placementid and PR.ActiveFlag=1
         JOIN placementadmissionclassificationtype as PACT
                  ON PACT.placementadmissionclassificationkey = PM.placementadmissionclassificationkey and PACT.placementadmissionclassificationkey = 'RES' and PACT.ActiveFlag=1
        where PM.intakeserviceid = v_intakeserviceid --and PM.intakeservicerequestactorid = ISRA.intakeservicerequestactorid
        and PM.ActiveFlag=1 order by PM.Insertedon desc limit 1)
                
FROM person as P 
JOIN actor as A
     ON A.PersonId = P.PersonId and A.ActiveFlag=1
JOIN IntakeServiceRequestActor as ISRA
     ON ISRA.Actorid = A.Actorid and ISRA.ActiveFlag=1     
JOIN Intakeservicerequest as ISR
     ON ISR.intakeserviceid = ISRA.intakeserviceid and ISR.ActiveFlag=1
     
where P.activeflag=1 and ISRA.intakeserviceid = v_intakeserviceid and ISRA.intakeservicerequestpersontypekey in ('RA','RC', 'Youth');

   
END;
 

$function$
;

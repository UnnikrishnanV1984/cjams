DROP FUNCTION IF exists cjams.getpersonsbyinvestigation(v_intakeserviceid uuid, _page integer, _limit integer);
DROP FUNCTION IF exists cjams.getpersonsbyinvestigation(uuid, integer, integer,character varying,integer);
DROP FUNCTION IF exists cjams.getpersonsbyinvestigation(uuid, integer, integer,character varying,integer, integer);
DROP FUNCTION IF exists cjams.getpersonsbyinvestigation(uuid, integer, integer,integer, integer);
CREATE OR REPLACE FUNCTION cjams.getpersonsbyinvestigation(v_intakeserviceid uuid, _page integer, _limit integer, isExpungementSuperUser integer DEFAULT 0, isexpunged integer DEFAULT 0::integer)
 RETURNS TABLE(totalcount bigint, rolename character varying, dcn character varying, personid uuid, firstname character varying, fullname character varying, lastname character varying, gender character varying, dob timestamp without time zone, dateofdeath timestamp without time zone, isapproxdod integer, address character varying, address2 character varying, state character varying, city character varying, zipcode character varying, county character varying, height character varying, weight character varying, phonenumber character varying, dangerous text, actorid uuid, intakeservicerequestactorid uuid, isalleged integer, priorscount bigint, reported boolean, refusessn boolean, refusedob boolean, userphoto text, primarylanguageid character varying, primarylanguage character varying, secondarylanguageid character varying, secondarylanguage character varying, otherprimarylanguagetypekey character varying, otherreligion character varying, email character varying, roles json, relationship character varying, relationshipdescription character varying, ishousehold integer, iscollateralcontact integer, schoolname json, ssn character varying, assistpid character varying, cjamspid bigint, strengths character varying, needs character varying, medicalinformation json, medicationinformation json, addendum json, medicalcondition json, emergency json, guardianinfo json, guardianpropertyinfo json, guardianattornyinfo json, guardianworkerinfo json, guardiafuneralinfo json, guardiacodeinfo json, personpayeeinfo json, ethinicity character varying, religion character varying, maritalstatus character varying, racetypekey character varying, fetalalcoholspctrmdisordflag integer, drugexposednewbornflag integer, probationsearchconductedflag integer, sexoffenderregisteredflag integer, citizenalenageflag integer, isqualifiedalien integer, alienregistrationtext character varying, verificationremarks character varying, alienstatustypekey character varying, issafe integer, programarea json, isheadofhousehold boolean, race json, gendertypedesc character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 08/15/2022 - Vineet Tirodkar - To fix the Person Substance Exposed Newborn Flag logic (CIDM-5306)
-- 06/06/2023 - CIDM-7251 - performance tuning
------------------------------------------------------------------------
DECLARE                    
_offset integer;
v_isexpunged integer;
BEGIN
    _offset := (_page - 1) * _limit;    
    
    v_isexpunged := 0;
    IF isExpungementSuperUser= 1 THEN
        v_isexpunged = isexpunged;
    END IF;

    IF v_isexpunged = 1 THEN
        RAISE NOTICE 'BLOCK: FULLY EXPUNGED';
        RETURN QUERY
        SELECT
            "Person".totalcount,
            "Person"."intakeservicerequestpersontypekey",
            "Person".dcn,
            "Person".personid,
            "Person".firstname,
            "Person".fullname,
            "Person".lastname,
            "Person".gendertypekey,
            "Person".dob,
            "Person".dateofdeath,
            "Person".isapproxdod,
            "Person".address,
            "Person".address2,
            "Person".state,
            "Person".city,
            "Person".zipcode,
            "Person".county,
            "Person".height,
            "Person".weight,
            (SELECT ph.phonenumber FROM personphonenumber ph WHERE ph.personid = "Person".personid AND ph.personphonetypekey = 'P' AND activeflag = 1 ORDER BY insertedon DESC LIMIT 1),
            "Person".dangerous,
            "Person".actorid,
            "Person".intakeservicerequestactorid,      
            CASE "Person".isvictim WHEN 1 THEN 0 ELSE "Person".isvictim END,
            (SELECT COUNT(*) FROM expunge.intakeservicerequest_expunge AS A  
                INNER JOIN expunge.intakeservicerequestactor_expunge AS B ON A.intakeserviceid = B.intakeserviceid  
                INNER JOIN expunge.actor_expunge AS C ON C.ActorId = B.ActorId    
                INNER JOIN person AS D ON C.personid=D.personid  
                WHERE A.activeflag=1 AND C.activeflag=1 AND D.personid="Person".personid AND D.activeflag=1 AND A.intakeserviceid <> v_intakeserviceid) AS "priorscount",
            "Person".reported,
            "Person".RefuseSSN,
            "Person".RefuseDOB,
            "Person".userphoto  ::text,
            "Person".primarylanguageid,
            (SELECT description AS primarylanguage FROM referencevalues WHERE ref_key = "Person".primarylanguageid and referencetypeid=27 AND activeflag = 1 ORDER BY insertedon DESC LIMIT 1),
            "Person".secondarylanguageid,
            (SELECT description AS secondarylanguage FROM referencevalues WHERE ref_key = "Person".secondarylanguageid and referencetypeid=27 AND activeflag = 1  ORDER BY insertedon DESC LIMIT 1),
            "Person".otherprimarylanguagetypekey,
            "Person".otherreligion,
            "Person".email :: character varying,
            "Person".roles :: json,
            "Person".relationship :: character varying,
            "Person".relationshipdescription :: character varying,
            "Person".ishousehold,
            "Person".iscollateralcontact,
            "Person".schoolname  ::  json,
            (SELECT pi.personidentifiervalue FROM personidentifier pi WHERE pi.personid = "Person".personid AND pi.activeflag = 1 AND pi.personidentifiertypekey ='SSN' ORDER BY insertedon DESC LIMIT 1),
            "Person".assistpid,
            "Person".cjamspid,
            "Person".strengths,
            "Person".needs,
            "Person".medicalinformation ::json,
            "Person".medicationinformation ::json,
            "Person".addendum ::json,
            "Person".medicalcondition ::json,
            "Person".emergency ::json,
            "Person".guardianinfo::json,
            "Person".guardianpropertyinfo::json,
            "Person".guardianattornyinfo::json,
            "Person".guardianworkerinfo::json,
            "Person".guardiafuneralinfo::json,
            "Person".guardiacodeinfo::json,
            "Person".personpayeeinfo::json,
            "Person".ethinicity,
            "Person".religion,
            "Person".maritalstatus,
            "Person".racetypekey,
            "Person".fetalalcoholspctrmdisordflag,
            "Person".drugexposednewbornflag,
            "Person".probationsearchconductedflag,
            "Person".sexoffenderregisteredflag,
            "Person".citizenalenageflag,
            "Person".isqualifiedalien,
            "Person".alienregistrationtext,
            "Person".verificationremarks,
            "Person".alienstatustypekey,
            (
            select
            coalesce(aa.issafe, 0)
            from
                assessmentactor aa
                inner join routing r on
                r.objectid = aa.assessmentid :: character varying
                and r.activeflag = 1
                and r.routingstatustypeid = 16
                where
                aa.intakeservicerequestactorid = "Person".intakeservicerequestactorid
                and aa.activeflag = 1
                ORDER BY routingstatustypeid, r.updatedon DESC
                limit 1 ),
            "Person".programarea::json,
            "Person".isheadofhousehold,
            "Person".race,
            "Person".gendertypedesc
        FROM  
        (
            SELECT
                Count(1) OVER() AS totalcount,      
                iar.intakeservicerequestpersontypekey,      
                (
                    SELECT
                        personidentifiervalue
                    FROM personidentifier pid
                    WHERE pid.personid = p.personid AND personidentifiertypekey = 'DCN' AND activeflag = 1 LIMIT 1) AS dcn,      
                p.personid,      
                p.firstname,  
                concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as fullname,
                p.lastname,      
                p.gendertypekey,      
                p.dob,      
                p.dateofdeath,      
                p.isapproxdod,      
                p.userphoto,      
                p.primarylanguageid,      
                p.secondarylanguageid,      
                p.otherprimarylanguagetypekey,      
                p.otherreligion,        
                (select pa.address  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) address,
                (select pa.address2  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) address2,
                (select pa.state  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) state,
                (select pa.city  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) city,
                (select pa.zipcode  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) zipcode,
                (select pa.county from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by pa.updatedon desc	limit 1) county,
                ppa.attributevalue  AS height,      
                ppat.attributevalue AS weight,
                (
                    CASE
                        WHEN p.dangerlevel=0 THEN 'NO'
                        WHEN p.dangerlevel= 1 THEN 'YES'
                        ELSE 'UNKNOWN'
                    END
                ) AS dangerous,
                ac.actorid,
                MAX(iar.intakeservicerequestactorid:: character VARYING) :: uuid AS intakeservicerequestactorid,
                MAX(COALESCE(
                    (SELECT IAR.isheadofhousehold FROM expunge.intakeservicerequestactor_expunge IAR
                    WHERE IAR.personid = P.personid
                    AND IAR.intakeserviceid = v_intakeserviceid
                    AND IAR.isheadofhousehold = TRUE AND IAR.activeflag = 1  LIMIT 1),false):: character VARYING)::bool isheadofhousehold,
                iar.isvictim,
                MAX(COALESCE(iar.reported,false):: character VARYING)::bool reported ,
                MAX(COALESCE(iar.refusessn,false):: character VARYING)::bool refusessn,
                MAX(COALESCE(iar.refusedob,false):: character VARYING)::bool refusedob,
                (SELECT MAX(personemail.email) FROM personemail WHERE personemail.personid = P.personid AND personemail.activeflag =1  ) email,
                (
                    SELECT
                        Json_agg(e) AS roles
                    FROM
                    (
                        SELECT    
                            isrpn.intakeservicerequestpersontypekey,                              
                            at.typedescription                  
                        FROM expunge.intakeservicerequestactor_expunge ISRPN                  
                        INNER JOIN actortype AT ON at.actortype = isrpn.intakeservicerequestpersontypekey
                        WHERE isrpn.actorid = ac.actorid AND isrpn.intakeserviceid = v_intakeserviceid AND isrpn.activeflag =1
                        GROUP BY isrpn.intakeservicerequestpersontypekey,at.typedescription
                    ) AS e
                ) ::json,
                '' AS relationship,
                (
                    SELECT
                        rt.description
                    FROM relationshiptype rt
                    INNER JOIN actorrelationship ar ON rt.relationshiptypekey= ar.relationshiptypekey AND ar.activeflag=1 AND rt.activeflag =1
                    WHERE ar.intakeservicerequestactorid = MAX(iar.INTAKESERVICEREQUESTACTORID:: CHARACTER VARYING) :: uuid
                    GROUP BY rt.description limit 1
                ) AS relationshipdescription,
                AC.ishouseholdmember AS ishousehold,  
                AC.iscollateralcontact AS iscollateralcontact,
                (
                    SELECT
                        Json_agg(f) AS schoolname
                    FROM
                        (
                            SELECT
                                pe.educationname
                            FROM personeducation pe  
                            WHERE pe.personid =p.personid AND activeflag=1
                        ) AS f
                ) ::json,
                p.old_id AS assistpid,
                p.cjamspid,
                p.strengths,
                p.needs,
                (
                    SELECT
                        Json_agg(e) AS medicalinformation
                    FROM
                    (
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            phi.ismedicaidmedicare,                              
                            phi.insurancetype,                              
                            phi.policyname,                              
                            ppi.name ,                              
                            ppi.phone,                              
                            ppi.address1,                              
                            ppi.address2,                              
                            ppi.city,                              
                            ppi.state,                              
                            ppi.zip,                              
                            pbh.currentdiagnoses,                              
                            pbh.clinicianname,                              
                            pbh.phone    AS behavioralphone,                              
                            pbh.address1 AS behavioraladdress1,                              
                            pbh.address2 AS behavioraladdress2,                              
                            pbh.city     AS behavioralcity,                              
                            pbh.state    AS behavioralstate,                              
                            pbh.zip      AS behavioralzip,                              
                            phi.personid,                              
                            ppi.isprimaryphycisian,                              
                            pbh.isbehavioralhealth,                            
                            pbh.reportname,                              
                            phi.medicarenumber                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personhealthinsurance AS phi ON phi.personid=per.personid AND phi.activeflag=1                  
                        LEFT JOIN personphycisianinfo AS ppi ON ppi.personid=per.personid AND ppi.activeflag=1                  
                        LEFT JOIN personbehavioralhealth AS pbh ON pbh.personid=per.personid AND pbh.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS medicationinformation
                    FROM
                    (
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pmpt.dosage,                              
                            pmpt.medicationname,                              
                            pmpt.frequency,                              
                            pmpt.compliant,                              
                            pmpt.personid,                              
                            pmpt.medicationcomments,                              
                            pmpt.prescribingdoctor,                              
                            pmpt.lastdosetakendate,                              
                            pmpt.monitoring,                              
                            prt.description AS prescriptionreason ,                              
                            ist.description AS informationsource,                              
                            pmpt.medicationeffectivedate,                              
                            pmpt.medicationexpirationdate,                              
                            pmpt.medicationname                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personmedicpshychotropic AS pmpt ON pmpt.personid=per.personid AND pmpt.activeflag=1
                        LEFT JOIN prescriptionreasontype prt ON prt.prescriptionreasontypekey=pmpt.prescriptionreasontypekey AND prt.activeflag=1
                        LEFT JOIN informationsourcetype ist ON ist.informationsourcetypekey=pmpt.informationsourcetypekey AND ist.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS addendum
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pas.isusealcohol,                              
                            pas.isusedrug,                              
                            pas.isusetobacco,                              
                            pas.alcoholfrequencydetails,                              
                            pas.drugfrequencydetails ,                              
                            pas.personid                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personabusesubstance AS pas ON pas.personid=per.personid                  
                        WHERE pas.activeflag=1 AND isra.intakeserviceid=v_intakeserviceid AND isra.activeflag=1 AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS medicalcondition
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pmci.medicalconditiontypekey,                              
                            mct.description,                              
                            pmc.begindate,                              
                            pmc.enddate,                              
                            pmc.recordedby                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personmedicalcondition AS pmc ON pmc.personid=per.personid AND pmc.activeflag=1                  
                        LEFT JOIN personmedicalconditioninfo AS pmci ON pmc.personmedicalconditionid= pmci.personmedicalconditionid AND pmci.activeflag=1
                        LEFT JOIN medicalconditiontype AS mct ON mct.medicalconditiontypekey=pmci.medicalconditiontypekey AND mct.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS emergency
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,                              
                            ph.phonenumber                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN emergencycontactperson ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.contactpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,  
                            ecp.startdate,
                            ecp.enddate,
                            p1.lastname,                              
                            ph.phonenumber,
                            pa.address
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='GOP' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianpropertyinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='GOPT' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianattornyinfo
                    FROM  
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='ATTY' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianworkerinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='WRK' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardiafuneralinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            ecp.contact,                              
                            ecp.contactnumber,                              
                            ecp.arrangementsdescription
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        INNER JOIN personguardianfuneral ecp ON ecp.personid= per.personid AND ecp.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardiacodeinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            ecp.codestatustypekey,
                            rv.description,
                            ecp.othercodestatus,                              
                            pgd.hhsclientid,
                            pgd.notes
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        INNER JOIN personguardiancode ecp ON ecp.personid= per.personid AND ecp.activeflag=1
                        LEFT JOIN referencevalues rv ON rv.ref_key=ecp.codestatustypekey
                        INNER JOIN personguardiandetails pgd ON pgd.personid= per.personid AND pgd.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                    (
                    SELECT
                        Json_agg(e) AS personpayeeinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber ,
                            up.lastname ||','|| up.firstname as username
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personrepresentativepayee ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.personrepresentativepersonid AND p1.activeflag =1  
                        LEFT JOIN userprofile up on up.securityusersid=ecp.personrepresentativeworkerid AND ecp.activeflag=1
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                egt.typedescription AS ethinicity,
                rt.typedescription AS religion,
                MT.typedescription as maritalstatus,
                RAT.typedescription AS racetypekey,
                IAR.fetalalcoholspctrmdisordflag ,
                COALESCE(p.substanceexposednewbornflag,0) as  drugexposednewbornflag,
                IAR.probationsearchconductedflag,
                IAR.sexoffenderregisteredflag,
                p.citizenalenageflag,
                p.isqualifiedalien,
                p.alienregistrationtext,
                p.verificationremarks,
                p.alienstatustypekey,
                (
                SELECT json_agg(e) AS programarea
                from
                    (
                    SELECT
                    ppa.programkey,
                    ppa.subprogramkey,
                    (SELECT rv.description  FROM referencevalues rv
                    WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
                    (SELECT ap.programname FROM agencyprogramarea ap
                    WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1) programname
                    FROM personprogramarea ppa
                    WHERE ppa.personid = p.personid AND ppa.objectid=v_intakeserviceid ::character varying AND ppa.activeflag=1
                    AND ppa.enddate IS NULL AND ppa.sourcetype = 'CW'
                    ) AS e
                ) ::json,
                (select json_agg(x) from
                        (select prt.racetypekey,rv.value_text
                        from personracetypemap prt
                        join referencevalues rv on rv.ref_key=prt.racetypekey and rv.referencetypeid=171 and prt.activeflag=1
                        where prt.personid=p.personid
                        ) x) as race,
                grt.typedescription as gendertypedesc
            FROM expunge.intakeservicerequestactor_expunge AS iar  
                INNER JOIN expunge.actor_expunge AS ac ON iar.actorid=ac.actorid AND ac.activeflag =1 AND iar.activeflag =1  
                INNER JOIN person AS p ON p.personid=ac.personid AND p.activeflag =1  
                LEFT JOIN personphysicalattribute AS ppa ON ppa.personid=P.personid AND ppa.physicalattributetypekey = 'Ht' AND ppa.activeflag=1  
                LEFT JOIN personphysicalattribute AS ppat ON ppat.personid=P.personid AND ppat.physicalattributetypekey = 'Wt' AND ppat.activeflag=1  
                LEFT JOIN ethnicgrouptype egt ON egt.ethnicgrouptypekey=p.ethnicgrouptypekey AND egt.activeflag=1  
                LEFT JOIN gendertype grt on grt.gendertypekey = p.gendertypekey and grt.activeflag=1
                LEFT JOIN religiontype RT ON rt.religiontypekey=p.religiontypekey AND rt.activeflag=1  
                LEFT JOIN racetype RAT ON RAT.racetypekey=P.racetypekey AND RAT.activeflag=1
                LEFT JOIN maritalstatustype MT on MT.maritalstatustypekey=p.maritalstatustypekey and MT.activeflag=1
            WHERE iar.intakeserviceid=v_intakeserviceid AND coalesce(iar.isprimary,FALSE)=true --and pa.row_number=1
            GROUP BY iar.intakeservicerequestpersontypekey, p.personid,ac.actorid,address,address2,state,city,zipcode,county,ppa.attributevalue,ppat.attributevalue,
                        egt.typedescription, rt.typedescription,rat.typedescription,iar.fetalalcoholspctrmdisordflag ,iar.drugexposednewbornflag,iar.probationsearchconductedflag,
                        iar.sexoffenderregisteredflag,iar.isvictim,MT.typedescription,grt.gendertypekey,ac.ishouseholdmember,ac.iscollateralcontact
        )AS  "Person"
        LIMIT  _limit  OFFSET  _offset;
    ELSIF isExpungementSuperUser= 1 AND v_isexpunged = 2 THEN
        RAISE NOTICE 'BLOCK: PARTIALLY EXPUNGED';
        RETURN QUERY
        SELECT
            "Person".totalcount,
            "Person"."intakeservicerequestpersontypekey",
            "Person".dcn,
            "Person".personid,
            "Person".firstname,
            "Person".fullname,
            "Person".lastname,
            "Person".gendertypekey,
            "Person".dob,
            "Person".dateofdeath,
            "Person".isapproxdod,
            "Person".address,
            "Person".address2,
            "Person".state,
            "Person".city,
            "Person".zipcode,
            "Person".county,
            "Person".height,
            "Person".weight,
            (SELECT ph.phonenumber FROM personphonenumber ph WHERE ph.personid = "Person".personid AND ph.personphonetypekey = 'P' AND activeflag = 1 ORDER BY insertedon DESC LIMIT 1),
            "Person".dangerous,
            "Person".actorid,
            "Person".intakeservicerequestactorid,      
            CASE "Person".isvictim WHEN 1 THEN 0 ELSE "Person".isvictim END,
            (SELECT COUNT(*) FROM intakeservicerequest AS A  
                INNER JOIN intakeservicerequestactor AS B ON A.intakeserviceid = B.intakeserviceid  
                INNER JOIN actor AS C ON C.ActorId = B.ActorId    
                INNER JOIN person AS D ON C.personid=D.personid  
                WHERE A.activeflag=1 AND C.activeflag=1 AND D.personid="Person".personid AND D.activeflag=1 AND A.intakeserviceid <> v_intakeserviceid) AS "priorscount",
            "Person".reported,
            "Person".RefuseSSN,
            "Person".RefuseDOB,
            "Person".userphoto  ::text,
            "Person".primarylanguageid,
            (SELECT description AS primarylanguage FROM referencevalues WHERE ref_key = "Person".primarylanguageid and referencetypeid=27 AND activeflag = 1 ORDER BY insertedon DESC LIMIT 1),
            "Person".secondarylanguageid,
            (SELECT description AS secondarylanguage FROM referencevalues WHERE ref_key = "Person".secondarylanguageid and referencetypeid=27 AND activeflag = 1  ORDER BY insertedon DESC LIMIT 1),
            "Person".otherprimarylanguagetypekey,
            "Person".otherreligion,
            "Person".email :: character varying,
            "Person".roles :: json,
            "Person".relationship :: character varying,
            "Person".relationshipdescription :: character varying,
            "Person".ishousehold,
            "Person".iscollateralcontact,
            "Person".schoolname  ::  json,
            (SELECT pi.personidentifiervalue FROM personidentifier pi WHERE pi.personid = "Person".personid AND pi.activeflag = 1 AND pi.personidentifiertypekey ='SSN' ORDER BY insertedon DESC LIMIT 1),
            "Person".assistpid,
            "Person".cjamspid,
            "Person".strengths,
            "Person".needs,
            "Person".medicalinformation ::json,
            "Person".medicationinformation ::json,
            "Person".addendum ::json,
            "Person".medicalcondition ::json,
            "Person".emergency ::json,
            "Person".guardianinfo::json,
            "Person".guardianpropertyinfo::json,
            "Person".guardianattornyinfo::json,
            "Person".guardianworkerinfo::json,
            "Person".guardiafuneralinfo::json,
            "Person".guardiacodeinfo::json,
            "Person".personpayeeinfo::json,
            "Person".ethinicity,
            "Person".religion,
            "Person".maritalstatus,
            "Person".racetypekey,
            "Person".fetalalcoholspctrmdisordflag,
            "Person".drugexposednewbornflag,
            "Person".probationsearchconductedflag,
            "Person".sexoffenderregisteredflag,
            "Person".citizenalenageflag,
            "Person".isqualifiedalien,
            "Person".alienregistrationtext,
            "Person".verificationremarks,
            "Person".alienstatustypekey,
            (
            select
            coalesce(aa.issafe, 0)
            from
                assessmentactor aa
                inner join routing r on
                r.objectid = aa.assessmentid :: character varying
                and r.activeflag = 1
                and r.routingstatustypeid = 16
                where
                aa.intakeservicerequestactorid = "Person".intakeservicerequestactorid
                and aa.activeflag = 1
                ORDER BY routingstatustypeid, r.updatedon DESC
                limit 1 ),
            "Person".programarea::json,
            "Person".isheadofhousehold,
            "Person".race,
            "Person".gendertypedesc
        FROM  
        (   
             SELECT
                Count(1) OVER() AS totalcount,      
                iar.intakeservicerequestpersontypekey,      
                (
                    SELECT
                        personidentifiervalue
                    FROM personidentifier pid
                    WHERE pid.personid = p.personid AND personidentifiertypekey = 'DCN' AND activeflag = 1 LIMIT 1) AS dcn,      
                p.personid,      
                p.firstname,  
                concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as fullname,
                p.lastname,      
                p.gendertypekey,      
                p.dob,      
                p.dateofdeath,      
                p.isapproxdod,      
                p.userphoto,      
                p.primarylanguageid,      
                p.secondarylanguageid,      
                p.otherprimarylanguagetypekey,      
                p.otherreligion,        
                (select pa.address  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) address,
                (select pa.address2  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) address2,
                (select pa.state  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) state,
                (select pa.city  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) city,
                (select pa.zipcode  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) zipcode,
                (select pa.county from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by pa.updatedon desc	limit 1) county,
                ppa.attributevalue  AS height,      
                ppat.attributevalue AS weight,
                (
                    CASE
                        WHEN p.dangerlevel=0 THEN 'NO'
                        WHEN p.dangerlevel= 1 THEN 'YES'
                        ELSE 'UNKNOWN'
                    END
                ) AS dangerous,
                ac.actorid,
                MAX(iar.intakeservicerequestactorid:: character VARYING) :: uuid AS intakeservicerequestactorid,
                MAX(COALESCE(
                    (SELECT IAR.isheadofhousehold FROM expunge.intakeservicerequestactor_expunge IAR
                    WHERE IAR.personid = P.personid
                    AND IAR.intakeserviceid = v_intakeserviceid
                    AND IAR.isheadofhousehold = TRUE AND IAR.activeflag = 1  LIMIT 1),false):: character VARYING)::bool isheadofhousehold,
                iar.isvictim,
                MAX(COALESCE(iar.reported,false):: character VARYING)::bool reported ,
                MAX(COALESCE(iar.refusessn,false):: character VARYING)::bool refusessn,
                MAX(COALESCE(iar.refusedob,false):: character VARYING)::bool refusedob,
                (SELECT MAX(personemail.email) FROM personemail WHERE personemail.personid = P.personid AND personemail.activeflag =1  ) email,
                (
                    SELECT
                        Json_agg(e) AS roles
                    FROM
                    (
                        SELECT    
                            isrpn.intakeservicerequestpersontypekey,                              
                            at.typedescription                  
                        FROM expunge.intakeservicerequestactor_expunge ISRPN                  
                        INNER JOIN actortype AT ON at.actortype = isrpn.intakeservicerequestpersontypekey
                        WHERE isrpn.actorid = ac.actorid AND isrpn.intakeserviceid = v_intakeserviceid AND isrpn.activeflag =1
                        GROUP BY isrpn.intakeservicerequestpersontypekey,at.typedescription
                    ) AS e
                ) ::json,
                '' AS relationship,
                (
                    SELECT
                        rt.description
                    FROM relationshiptype rt
                    INNER JOIN actorrelationship ar ON rt.relationshiptypekey= ar.relationshiptypekey AND ar.activeflag=1 AND rt.activeflag =1
                    WHERE ar.intakeservicerequestactorid = MAX(iar.INTAKESERVICEREQUESTACTORID:: CHARACTER VARYING) :: uuid
                    GROUP BY rt.description limit 1
                ) AS relationshipdescription,
                AC.ishouseholdmember AS ishousehold,  
                AC.iscollateralcontact AS iscollateralcontact,
                (
                    SELECT
                        Json_agg(f) AS schoolname
                    FROM
                        (
                            SELECT
                                pe.educationname
                            FROM personeducation pe  
                            WHERE pe.personid =p.personid AND activeflag=1
                        ) AS f
                ) ::json,
                p.old_id AS assistpid,
                p.cjamspid,
                p.strengths,
                p.needs,
                (
                    SELECT
                        Json_agg(e) AS medicalinformation
                    FROM
                    (
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            phi.ismedicaidmedicare,                              
                            phi.insurancetype,                              
                            phi.policyname,                              
                            ppi.name ,                              
                            ppi.phone,                              
                            ppi.address1,                              
                            ppi.address2,                              
                            ppi.city,                              
                            ppi.state,                              
                            ppi.zip,                              
                            pbh.currentdiagnoses,                              
                            pbh.clinicianname,                              
                            pbh.phone    AS behavioralphone,                              
                            pbh.address1 AS behavioraladdress1,                              
                            pbh.address2 AS behavioraladdress2,                              
                            pbh.city     AS behavioralcity,                              
                            pbh.state    AS behavioralstate,                              
                            pbh.zip      AS behavioralzip,                              
                            phi.personid,                              
                            ppi.isprimaryphycisian,                              
                            pbh.isbehavioralhealth,                            
                            pbh.reportname,                              
                            phi.medicarenumber                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personhealthinsurance AS phi ON phi.personid=per.personid AND phi.activeflag=1                  
                        LEFT JOIN personphycisianinfo AS ppi ON ppi.personid=per.personid AND ppi.activeflag=1                  
                        LEFT JOIN personbehavioralhealth AS pbh ON pbh.personid=per.personid AND pbh.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS medicationinformation
                    FROM
                    (
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pmpt.dosage,                              
                            pmpt.medicationname,                              
                            pmpt.frequency,                              
                            pmpt.compliant,                              
                            pmpt.personid,                              
                            pmpt.medicationcomments,                              
                            pmpt.prescribingdoctor,                              
                            pmpt.lastdosetakendate,                              
                            pmpt.monitoring,                              
                            prt.description AS prescriptionreason ,                              
                            ist.description AS informationsource,                              
                            pmpt.medicationeffectivedate,                              
                            pmpt.medicationexpirationdate,                              
                            pmpt.medicationname                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personmedicpshychotropic AS pmpt ON pmpt.personid=per.personid AND pmpt.activeflag=1
                        LEFT JOIN prescriptionreasontype prt ON prt.prescriptionreasontypekey=pmpt.prescriptionreasontypekey AND prt.activeflag=1
                        LEFT JOIN informationsourcetype ist ON ist.informationsourcetypekey=pmpt.informationsourcetypekey AND ist.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS addendum
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pas.isusealcohol,                              
                            pas.isusedrug,                              
                            pas.isusetobacco,                              
                            pas.alcoholfrequencydetails,                              
                            pas.drugfrequencydetails ,                              
                            pas.personid                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personabusesubstance AS pas ON pas.personid=per.personid                  
                        WHERE pas.activeflag=1 AND isra.intakeserviceid=v_intakeserviceid AND isra.activeflag=1 AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS medicalcondition
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pmci.medicalconditiontypekey,                              
                            mct.description,                              
                            pmc.begindate,                              
                            pmc.enddate,                              
                            pmc.recordedby                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personmedicalcondition AS pmc ON pmc.personid=per.personid AND pmc.activeflag=1                  
                        LEFT JOIN personmedicalconditioninfo AS pmci ON pmc.personmedicalconditionid= pmci.personmedicalconditionid AND pmci.activeflag=1
                        LEFT JOIN medicalconditiontype AS mct ON mct.medicalconditiontypekey=pmci.medicalconditiontypekey AND mct.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS emergency
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,                              
                            ph.phonenumber                  
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN emergencycontactperson ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.contactpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,  
                            ecp.startdate,
                            ecp.enddate,
                            p1.lastname,                              
                            ph.phonenumber,
                            pa.address
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='GOP' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianpropertyinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='GOPT' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianattornyinfo
                    FROM  
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='ATTY' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianworkerinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='WRK' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardiafuneralinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            ecp.contact,                              
                            ecp.contactnumber,                              
                            ecp.arrangementsdescription
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        INNER JOIN personguardianfuneral ecp ON ecp.personid= per.personid AND ecp.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardiacodeinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            ecp.codestatustypekey,
                            rv.description,
                            ecp.othercodestatus,                              
                            pgd.hhsclientid,
                            pgd.notes
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        INNER JOIN personguardiancode ecp ON ecp.personid= per.personid AND ecp.activeflag=1
                        LEFT JOIN referencevalues rv ON rv.ref_key=ecp.codestatustypekey
                        INNER JOIN personguardiandetails pgd ON pgd.personid= per.personid AND pgd.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                    (
                    SELECT
                        Json_agg(e) AS personpayeeinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber ,
                            up.lastname ||','|| up.firstname as username
                        FROM expunge.intakeservicerequestactor_expunge isra                  
                        INNER JOIN expunge.actor_expunge act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personrepresentativepayee ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.personrepresentativepersonid AND p1.activeflag =1  
                        LEFT JOIN userprofile up on up.securityusersid=ecp.personrepresentativeworkerid AND ecp.activeflag=1
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                egt.typedescription AS ethinicity,
                rt.typedescription AS religion,
                MT.typedescription as maritalstatus,
                RAT.typedescription AS racetypekey,
                IAR.fetalalcoholspctrmdisordflag ,
                COALESCE(p.substanceexposednewbornflag,0) as  drugexposednewbornflag,
                IAR.probationsearchconductedflag,
                IAR.sexoffenderregisteredflag,
                p.citizenalenageflag,
                p.isqualifiedalien,
                p.alienregistrationtext,
                p.verificationremarks,
                p.alienstatustypekey,
                (
                SELECT json_agg(e) AS programarea
                from
                    (
                    SELECT
                    ppa.programkey,
                    ppa.subprogramkey,
                    (SELECT rv.description  FROM referencevalues rv
                    WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
                    (SELECT ap.programname FROM agencyprogramarea ap
                    WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1) programname
                    FROM personprogramarea ppa
                    WHERE ppa.personid = p.personid AND ppa.objectid=v_intakeserviceid ::character varying AND ppa.activeflag=1
                    AND ppa.enddate IS NULL AND ppa.sourcetype = 'CW'
                    ) AS e
                ) ::json,
                (select json_agg(x) from
                        (select prt.racetypekey,rv.value_text
                        from personracetypemap prt
                        join referencevalues rv on rv.ref_key=prt.racetypekey and rv.referencetypeid=171 and prt.activeflag=1
                        where prt.personid=p.personid
                        ) x) as race,
                grt.typedescription as gendertypedesc
            FROM expunge.intakeservicerequestactor_expunge AS iar  
                INNER JOIN expunge.actor_expunge AS ac ON iar.actorid=ac.actorid AND ac.activeflag =1 AND iar.activeflag =1  
                INNER JOIN person AS p ON p.personid=ac.personid AND p.activeflag =1  
                LEFT JOIN personphysicalattribute AS ppa ON ppa.personid=P.personid AND ppa.physicalattributetypekey = 'Ht' AND ppa.activeflag=1  
                LEFT JOIN personphysicalattribute AS ppat ON ppat.personid=P.personid AND ppat.physicalattributetypekey = 'Wt' AND ppat.activeflag=1  
                LEFT JOIN ethnicgrouptype egt ON egt.ethnicgrouptypekey=p.ethnicgrouptypekey AND egt.activeflag=1  
                LEFT JOIN gendertype grt on grt.gendertypekey = p.gendertypekey and grt.activeflag=1
                LEFT JOIN religiontype RT ON rt.religiontypekey=p.religiontypekey AND rt.activeflag=1  
                LEFT JOIN racetype RAT ON RAT.racetypekey=P.racetypekey AND RAT.activeflag=1
                LEFT JOIN maritalstatustype MT on MT.maritalstatustypekey=p.maritalstatustypekey and MT.activeflag=1
            WHERE iar.intakeserviceid=v_intakeserviceid AND coalesce(iar.isprimary,FALSE)=true --and pa.row_number=1
            GROUP BY iar.intakeservicerequestpersontypekey ,p.personid,ac.actorid,address,address2,state,city,zipcode,county,ppa.attributevalue,ppat.attributevalue,
                        egt.typedescription, rt.typedescription,rat.typedescription,iar.fetalalcoholspctrmdisordflag ,iar.drugexposednewbornflag,iar.probationsearchconductedflag,
                        iar.sexoffenderregisteredflag,iar.isvictim,MT.typedescription,grt.gendertypekey,ac.ishouseholdmember,ac.iscollateralcontact

            Union all 

            SELECT
                Count(1) OVER() AS totalcount,      
                iar.intakeservicerequestpersontypekey AS "intakeservicerequestpersontypekey",      
                (
                    SELECT
                        personidentifiervalue
                    FROM personidentifier pid
                    WHERE pid.personid = p.personid AND personidentifiertypekey = 'DCN' AND activeflag = 1 LIMIT 1) AS dcn,      
                p.personid,      
                p.firstname,  
                concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as fullname,
                p.lastname,      
                p.gendertypekey,      
                p.dob,      
                p.dateofdeath,      
                p.isapproxdod,      
                p.userphoto,      
                p.primarylanguageid,      
                p.secondarylanguageid,      
                p.otherprimarylanguagetypekey,      
                p.otherreligion,        
                (select pa.address  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) address,
                (select pa.address2  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) address2,
                (select pa.state  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) state,
                (select pa.city  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) city,
                (select pa.zipcode  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) zipcode,
                (select pa.county from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by pa.updatedon desc	limit 1) county,
                ppa.attributevalue  AS height,      
                ppat.attributevalue AS weight,
                (
                    CASE
                        WHEN p.dangerlevel=0 THEN 'NO'
                        WHEN p.dangerlevel= 1 THEN 'YES'
                        ELSE 'UNKNOWN'
                    END
                ) AS dangerous,
                ac.actorid,
                MAX(iar.intakeservicerequestactorid:: character VARYING) :: uuid AS intakeservicerequestactorid,
                MAX(COALESCE(
                    (SELECT IAR.isheadofhousehold FROM intakeservicerequestactor IAR
                    WHERE  IAR.personid = P.personid
                    AND IAR.intakeserviceid = v_intakeserviceid
                    AND IAR.isheadofhousehold = TRUE AND IAR.activeflag = 1  LIMIT 1),false):: character VARYING)::bool isheadofhousehold,
                iar.isvictim,
                MAX(COALESCE(iar.reported,false):: character VARYING)::bool reported ,
                MAX(COALESCE(iar.refusessn,false):: character VARYING)::bool refusessn,
                MAX(COALESCE(iar.refusedob,false):: character VARYING)::bool refusedob,
                (SELECT MAX(personemail.email) FROM personemail WHERE personemail.personid = P.personid AND personemail.activeflag =1  ) email,
                (
                    SELECT
                        Json_agg(e) AS roles
                    FROM
                    (
                        SELECT    
                            isrpn.intakeservicerequestpersontypekey,                              
                            at.typedescription                  
                        FROM intakeservicerequestactor ISRPN                  
                        INNER JOIN actortype AT ON at.actortype = isrpn.intakeservicerequestpersontypekey
                        WHERE isrpn.actorid = ac.actorid AND isrpn.intakeserviceid = v_intakeserviceid AND isrpn.activeflag =1
                        GROUP BY isrpn.intakeservicerequestpersontypekey,at.typedescription
                    ) AS e
                ) ::json,
                '' AS relationship,
                (
                    SELECT
                        rt.description
                    FROM relationshiptype rt
                    INNER JOIN actorrelationship ar ON rt.relationshiptypekey= ar.relationshiptypekey AND ar.activeflag=1 AND rt.activeflag =1
                    WHERE ar.intakeservicerequestactorid = MAX( iar.INTAKESERVICEREQUESTACTORID:: CHARACTER VARYING) :: uuid
                    GROUP BY rt.description limit 1
                ) AS relationshipdescription,
                AC.ishouseholdmember AS ishousehold,  
                AC.iscollateralcontact AS iscollateralcontact,
                (
                    SELECT
                        Json_agg(f) AS schoolname
                    FROM
                        (
                            SELECT
                                pe.educationname
                            FROM personeducation pe  
                            WHERE pe.personid =p.personid AND activeflag=1
                        ) AS f
                ) ::json,
                p.old_id AS assistpid,
                p.cjamspid,
                p.strengths,
                p.needs,
                (
                    SELECT
                        Json_agg(e) AS medicalinformation
                    FROM
                    (
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            phi.ismedicaidmedicare,                              
                            phi.insurancetype,                              
                            phi.policyname,                              
                            ppi.name ,                              
                            ppi.phone,                              
                            ppi.address1,                              
                            ppi.address2,                              
                            ppi.city,                              
                            ppi.state,                              
                            ppi.zip,                              
                            pbh.currentdiagnoses,                              
                            pbh.clinicianname,                              
                            pbh.phone    AS behavioralphone,                              
                            pbh.address1 AS behavioraladdress1,                              
                            pbh.address2 AS behavioraladdress2,                              
                            pbh.city     AS behavioralcity,                              
                            pbh.state    AS behavioralstate,                              
                            pbh.zip      AS behavioralzip,                              
                            phi.personid,                              
                            ppi.isprimaryphycisian,                              
                            pbh.isbehavioralhealth,                            
                            pbh.reportname,                              
                            phi.medicarenumber                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personhealthinsurance AS phi ON phi.personid=per.personid AND phi.activeflag=1                  
                        LEFT JOIN personphycisianinfo AS ppi ON ppi.personid=per.personid AND ppi.activeflag=1                  
                        LEFT JOIN personbehavioralhealth AS pbh ON pbh.personid=per.personid AND pbh.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS medicationinformation
                    FROM
                    (
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pmpt.dosage,                              
                            pmpt.medicationname,                              
                            pmpt.frequency,                              
                            pmpt.compliant,                              
                            pmpt.personid,                              
                            pmpt.medicationcomments,                              
                            pmpt.prescribingdoctor,                              
                            pmpt.lastdosetakendate,                              
                            pmpt.monitoring,                              
                            prt.description AS prescriptionreason ,                              
                            ist.description AS informationsource,                              
                            pmpt.medicationeffectivedate,                              
                            pmpt.medicationexpirationdate,                              
                            pmpt.medicationname                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personmedicpshychotropic AS pmpt ON pmpt.personid=per.personid AND pmpt.activeflag=1
                        LEFT JOIN prescriptionreasontype prt ON prt.prescriptionreasontypekey=pmpt.prescriptionreasontypekey AND prt.activeflag=1
                        LEFT JOIN informationsourcetype ist ON ist.informationsourcetypekey=pmpt.informationsourcetypekey AND ist.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS addendum
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pas.isusealcohol,                              
                            pas.isusedrug,                              
                            pas.isusetobacco,                              
                            pas.alcoholfrequencydetails,                              
                            pas.drugfrequencydetails ,                              
                            pas.personid                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personabusesubstance AS pas ON pas.personid=per.personid                  
                        WHERE pas.activeflag=1 AND isra.intakeserviceid=v_intakeserviceid AND isra.activeflag=1 AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS medicalcondition
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pmci.medicalconditiontypekey,                              
                            mct.description,                              
                            pmc.begindate,                              
                            pmc.enddate,                              
                            pmc.recordedby                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personmedicalcondition AS pmc ON pmc.personid=per.personid AND pmc.activeflag=1                  
                        LEFT JOIN personmedicalconditioninfo AS pmci ON pmc.personmedicalconditionid= pmci.personmedicalconditionid AND pmci.activeflag=1
                        LEFT JOIN medicalconditiontype AS mct ON mct.medicalconditiontypekey=pmci.medicalconditiontypekey AND mct.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS emergency
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,                              
                            ph.phonenumber                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN emergencycontactperson ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.contactpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,  
                            ecp.startdate,
                            ecp.enddate,
                            p1.lastname,                              
                            ph.phonenumber,
                            pa.address
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='GOP' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianpropertyinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='GOPT' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianattornyinfo
                    FROM  
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='ATTY' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianworkerinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='WRK' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardiafuneralinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            ecp.contact,                              
                            ecp.contactnumber,                              
                            ecp.arrangementsdescription
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        INNER JOIN personguardianfuneral ecp ON ecp.personid= per.personid AND ecp.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardiacodeinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            ecp.codestatustypekey,
                            rv.description,
                            ecp.othercodestatus,                              
                            pgd.hhsclientid,
                            pgd.notes
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        INNER JOIN personguardiancode ecp ON ecp.personid= per.personid AND ecp.activeflag=1
                        LEFT JOIN referencevalues rv ON rv.ref_key=ecp.codestatustypekey
                        INNER JOIN personguardiandetails pgd ON pgd.personid= per.personid AND pgd.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                    (
                    SELECT
                        Json_agg(e) AS personpayeeinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber ,
                            up.lastname ||','|| up.firstname as username
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personrepresentativepayee ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.personrepresentativepersonid AND p1.activeflag =1  
                        LEFT JOIN userprofile up on up.securityusersid=ecp.personrepresentativeworkerid AND ecp.activeflag=1
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                egt.typedescription AS ethinicity,
                rt.typedescription AS religion,
                MT.typedescription as maritalstatus,
                RAT.typedescription AS racetypekey,
                IAR.fetalalcoholspctrmdisordflag ,
                COALESCE(p.substanceexposednewbornflag,0) as  drugexposednewbornflag,
                IAR.probationsearchconductedflag,
                IAR.sexoffenderregisteredflag,
                p.citizenalenageflag,
                p.isqualifiedalien,
                p.alienregistrationtext,
                p.verificationremarks,
                p.alienstatustypekey,
                (
                SELECT json_agg(e) AS programarea
                from
                    (
                    SELECT
                    ppa.programkey,
                    ppa.subprogramkey,
                    (SELECT rv.description  FROM referencevalues rv
                    WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
                    (SELECT ap.programname FROM agencyprogramarea ap
                    WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1) programname
                    FROM personprogramarea ppa
                    WHERE ppa.personid = p.personid AND ppa.objectid=v_intakeserviceid ::character varying AND ppa.activeflag=1
                    AND ppa.enddate IS NULL AND ppa.sourcetype = 'CW'
                    ) AS e
                ) ::json,
                (select json_agg(x) from
                        (select prt.racetypekey,rv.value_text
                        from personracetypemap prt
                        join referencevalues rv on rv.ref_key=prt.racetypekey and rv.referencetypeid=171 and prt.activeflag=1
                        where prt.personid=p.personid
                        ) x) as race,
                grt.typedescription as gendertypedesc
            FROM intakeservicerequestactor AS iar  
                INNER JOIN actor AS ac ON iar.actorid=ac.actorid AND ac.activeflag =1 AND iar.activeflag =1  
                INNER JOIN person AS p ON p.personid=ac.personid AND p.activeflag =1  
                LEFT JOIN personphysicalattribute AS ppa ON ppa.personid=P.personid AND ppa.physicalattributetypekey = 'Ht' AND ppa.activeflag=1  
                LEFT JOIN personphysicalattribute AS ppat ON ppat.personid=P.personid AND ppat.physicalattributetypekey = 'Wt' AND ppat.activeflag=1  
                LEFT JOIN ethnicgrouptype egt ON egt.ethnicgrouptypekey=p.ethnicgrouptypekey AND egt.activeflag=1  
                LEFT JOIN gendertype grt on grt.gendertypekey = p.gendertypekey and grt.activeflag=1
                LEFT JOIN religiontype RT ON rt.religiontypekey=p.religiontypekey AND rt.activeflag=1  
                LEFT JOIN racetype RAT ON RAT.racetypekey=P.racetypekey AND RAT.activeflag=1
                LEFT JOIN maritalstatustype MT on MT.maritalstatustypekey=p.maritalstatustypekey and MT.activeflag=1
            WHERE iar.intakeserviceid=v_intakeserviceid AND coalesce(iar.isprimary,FALSE)=true --and pa.row_number=1
            GROUP BY iar.intakeservicerequestpersontypekey,p.personid,ac.actorid,address,address2,state,city,zipcode,county,ppa.attributevalue,ppat.attributevalue,
                        egt.typedescription , rt.typedescription,rat.typedescription,iar.fetalalcoholspctrmdisordflag ,iar.drugexposednewbornflag,iar.probationsearchconductedflag,
                        iar.sexoffenderregisteredflag,iar.isvictim,MT.typedescription,grt.gendertypekey,ac.ishouseholdmember,ac.iscollateralcontact
        )AS  "Person"
        LIMIT  _limit  OFFSET  _offset;
    ELSE
        RAISE NOTICE 'BLOCK: NORMAL';
        RETURN QUERY
        SELECT
            "Person".totalcount,
            "Person"."intakeservicerequestpersontypekey",
            "Person".dcn,
            "Person".personid,
            "Person".firstname,
            "Person".fullname,
            "Person".lastname,
            "Person".gendertypekey,
            "Person".dob,
            "Person".dateofdeath,
            "Person".isapproxdod,
            "Person".address,
            "Person".address2,
            "Person".state,
            "Person".city,
            "Person".zipcode,
            "Person".county,
            "Person".height,
            "Person".weight,
            (SELECT ph.phonenumber FROM personphonenumber ph WHERE ph.personid = "Person".personid AND ph.personphonetypekey = 'P' AND activeflag = 1 ORDER BY insertedon DESC LIMIT 1),
            "Person".dangerous,
            "Person".actorid,
            "Person".intakeservicerequestactorid,      
            CASE "Person".isvictim WHEN 1 THEN 0 ELSE "Person".isvictim END,
            (SELECT COUNT(*) FROM intakeservicerequest AS A  
                INNER JOIN intakeservicerequestactor AS B ON A.intakeserviceid = B.intakeserviceid  
                INNER JOIN actor AS C ON C.ActorId = B.ActorId    
                INNER JOIN person AS D ON C.personid=D.personid  
                WHERE A.activeflag=1 AND C.activeflag=1 AND D.personid="Person".personid AND D.activeflag=1 AND A.intakeserviceid <> v_intakeserviceid) AS "priorscount",
            "Person".reported,
            "Person".RefuseSSN,
            "Person".RefuseDOB,
            "Person".userphoto  ::text,
            "Person".primarylanguageid,
            (SELECT description AS primarylanguage FROM referencevalues WHERE ref_key = "Person".primarylanguageid and referencetypeid=27 AND activeflag = 1 ORDER BY insertedon DESC LIMIT 1),
            "Person".secondarylanguageid,
            (SELECT description AS secondarylanguage FROM referencevalues WHERE ref_key = "Person".secondarylanguageid and referencetypeid=27 AND activeflag = 1  ORDER BY insertedon DESC LIMIT 1),
            "Person".otherprimarylanguagetypekey,
            "Person".otherreligion,
            "Person".email :: character varying,
            "Person".roles :: json,
            "Person".relationship :: character varying,
            "Person".relationshipdescription :: character varying,
            "Person".ishousehold,
            "Person".iscollateralcontact,
            "Person".schoolname  ::  json,
            (SELECT pi.personidentifiervalue FROM personidentifier pi WHERE pi.personid = "Person".personid AND pi.activeflag = 1 AND pi.personidentifiertypekey ='SSN' ORDER BY insertedon DESC LIMIT 1),
            "Person".assistpid,
            "Person".cjamspid,
            "Person".strengths,
            "Person".needs,
            "Person".medicalinformation ::json,
            "Person".medicationinformation ::json,
            "Person".addendum ::json,
            "Person".medicalcondition ::json,
            "Person".emergency ::json,
            "Person".guardianinfo::json,
            "Person".guardianpropertyinfo::json,
            "Person".guardianattornyinfo::json,
            "Person".guardianworkerinfo::json,
            "Person".guardiafuneralinfo::json,
            "Person".guardiacodeinfo::json,
            "Person".personpayeeinfo::json,
            "Person".ethinicity,
            "Person".religion,
            "Person".maritalstatus,
            "Person".racetypekey,
            "Person".fetalalcoholspctrmdisordflag,
            "Person".drugexposednewbornflag,
            "Person".probationsearchconductedflag,
            "Person".sexoffenderregisteredflag,
            "Person".citizenalenageflag,
            "Person".isqualifiedalien,
            "Person".alienregistrationtext,
            "Person".verificationremarks,
            "Person".alienstatustypekey,
            (
            select
            coalesce(aa.issafe, 0)
            from
                assessmentactor aa
                inner join routing r on
                r.objectid = aa.assessmentid :: character varying
                and r.activeflag = 1
                and r.routingstatustypeid = 16
                where
                aa.intakeservicerequestactorid = "Person".intakeservicerequestactorid
                and aa.activeflag = 1
                ORDER BY routingstatustypeid, r.updatedon DESC
                limit 1 ),
            "Person".programarea::json,
            "Person".isheadofhousehold,
            "Person".race,
            "Person".gendertypedesc
        FROM  
        (
            SELECT
                Count(1) OVER() AS totalcount,      
                iar.intakeservicerequestpersontypekey AS "intakeservicerequestpersontypekey",      
                (
                    SELECT
                        personidentifiervalue
                    FROM personidentifier pid
                    WHERE pid.personid = p.personid AND personidentifiertypekey = 'DCN' AND activeflag = 1 LIMIT 1) AS dcn,      
                p.personid,      
                p.firstname,  
                concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as fullname,
                p.lastname,      
                p.gendertypekey,      
                p.dob,      
                p.dateofdeath,      
                p.isapproxdod,      
                p.userphoto,      
                p.primarylanguageid,      
                p.secondarylanguageid,      
                p.otherprimarylanguagetypekey,      
                p.otherreligion,        
                (select pa.address  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) address,
                (select pa.address2  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) address2,
                (select pa.state  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) state,
                (select pa.city  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) city,
                (select pa.zipcode  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by updatedon desc	limit 1) zipcode,
                (select pa.county from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
                order by pa.updatedon desc	limit 1) county,
                ppa.attributevalue  AS height,      
                ppat.attributevalue AS weight,
                (
                    CASE
                        WHEN p.dangerlevel=0 THEN 'NO'
                        WHEN p.dangerlevel= 1 THEN 'YES'
                        ELSE 'UNKNOWN'
                    END
                ) AS dangerous,
                ac.actorid,
                MAX(iar.intakeservicerequestactorid:: character VARYING) :: uuid AS intakeservicerequestactorid,
                MAX(COALESCE(
                    (SELECT IAR.isheadofhousehold FROM intakeservicerequestactor IAR
                    WHERE  IAR.personid = P.personid
                    AND IAR.intakeserviceid = v_intakeserviceid
                    AND IAR.isheadofhousehold = TRUE AND IAR.activeflag = 1  LIMIT 1),false):: character VARYING)::bool isheadofhousehold,
                iar.isvictim,
                MAX(COALESCE(iar.reported,false):: character VARYING)::bool reported ,
                MAX(COALESCE(iar.refusessn,false):: character VARYING)::bool refusessn,
                MAX(COALESCE(iar.refusedob,false):: character VARYING)::bool refusedob,
                (SELECT MAX(personemail.email) FROM personemail WHERE personemail.personid = P.personid AND personemail.activeflag =1  ) email,
                (
                    SELECT
                        Json_agg(e) AS roles
                    FROM
                    (
                        SELECT    
                            isrpn.intakeservicerequestpersontypekey,                              
                            at.typedescription                  
                        FROM intakeservicerequestactor ISRPN                  
                        INNER JOIN actortype AT ON at.actortype = isrpn.intakeservicerequestpersontypekey
                        WHERE isrpn.actorid = ac.actorid AND isrpn.intakeserviceid = v_intakeserviceid AND isrpn.activeflag =1
                        GROUP BY isrpn.intakeservicerequestpersontypekey,at.typedescription
                    ) AS e
                ) ::json,
                '' AS relationship,
                (
                    SELECT
                        rt.description
                    FROM relationshiptype rt
                    INNER JOIN actorrelationship ar ON rt.relationshiptypekey= ar.relationshiptypekey AND ar.activeflag=1 AND rt.activeflag =1
                    WHERE ar.intakeservicerequestactorid = MAX( iar.INTAKESERVICEREQUESTACTORID:: CHARACTER VARYING) :: uuid
                    GROUP BY rt.description limit 1
                ) AS relationshipdescription,
                AC.ishouseholdmember AS ishousehold,  
                AC.iscollateralcontact AS iscollateralcontact,
                (
                    SELECT
                        Json_agg(f) AS schoolname
                    FROM
                        (
                            SELECT
                                pe.educationname
                            FROM personeducation pe  
                            WHERE pe.personid =p.personid AND activeflag=1
                        ) AS f
                ) ::json,
                p.old_id AS assistpid,
                p.cjamspid,
                p.strengths,
                p.needs,
                (
                    SELECT
                        Json_agg(e) AS medicalinformation
                    FROM
                    (
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            phi.ismedicaidmedicare,                              
                            phi.insurancetype,                              
                            phi.policyname,                              
                            ppi.name ,                              
                            ppi.phone,                              
                            ppi.address1,                              
                            ppi.address2,                              
                            ppi.city,                              
                            ppi.state,                              
                            ppi.zip,                              
                            pbh.currentdiagnoses,                              
                            pbh.clinicianname,                              
                            pbh.phone    AS behavioralphone,                              
                            pbh.address1 AS behavioraladdress1,                              
                            pbh.address2 AS behavioraladdress2,                              
                            pbh.city     AS behavioralcity,                              
                            pbh.state    AS behavioralstate,                              
                            pbh.zip      AS behavioralzip,                              
                            phi.personid,                              
                            ppi.isprimaryphycisian,                              
                            pbh.isbehavioralhealth,                            
                            pbh.reportname,                              
                            phi.medicarenumber                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personhealthinsurance AS phi ON phi.personid=per.personid AND phi.activeflag=1                  
                        LEFT JOIN personphycisianinfo AS ppi ON ppi.personid=per.personid AND ppi.activeflag=1                  
                        LEFT JOIN personbehavioralhealth AS pbh ON pbh.personid=per.personid AND pbh.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS medicationinformation
                    FROM
                    (
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pmpt.dosage,                              
                            pmpt.medicationname,                              
                            pmpt.frequency,                              
                            pmpt.compliant,                              
                            pmpt.personid,                              
                            pmpt.medicationcomments,                              
                            pmpt.prescribingdoctor,                              
                            pmpt.lastdosetakendate,                              
                            pmpt.monitoring,                              
                            prt.description AS prescriptionreason ,                              
                            ist.description AS informationsource,                              
                            pmpt.medicationeffectivedate,                              
                            pmpt.medicationexpirationdate,                              
                            pmpt.medicationname                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personmedicpshychotropic AS pmpt ON pmpt.personid=per.personid AND pmpt.activeflag=1
                        LEFT JOIN prescriptionreasontype prt ON prt.prescriptionreasontypekey=pmpt.prescriptionreasontypekey AND prt.activeflag=1
                        LEFT JOIN informationsourcetype ist ON ist.informationsourcetypekey=pmpt.informationsourcetypekey AND ist.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS addendum
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pas.isusealcohol,                              
                            pas.isusedrug,                              
                            pas.isusetobacco,                              
                            pas.alcoholfrequencydetails,                              
                            pas.drugfrequencydetails ,                              
                            pas.personid                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personabusesubstance AS pas ON pas.personid=per.personid                  
                        WHERE pas.activeflag=1 AND isra.intakeserviceid=v_intakeserviceid AND isra.activeflag=1 AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,  
                (
                    SELECT
                        Json_agg(e) AS medicalcondition
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            pmci.medicalconditiontypekey,                              
                            mct.description,                              
                            pmc.begindate,                              
                            pmc.enddate,                              
                            pmc.recordedby                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personmedicalcondition AS pmc ON pmc.personid=per.personid AND pmc.activeflag=1                  
                        LEFT JOIN personmedicalconditioninfo AS pmci ON pmc.personmedicalconditionid= pmci.personmedicalconditionid AND pmci.activeflag=1
                        LEFT JOIN medicalconditiontype AS mct ON mct.medicalconditiontypekey=pmci.medicalconditiontypekey AND mct.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS emergency
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,                              
                            ph.phonenumber                  
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN emergencycontactperson ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.contactpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,  
                            ecp.startdate,
                            ecp.enddate,
                            p1.lastname,                              
                            ph.phonenumber,
                            pa.address
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='GOP' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianpropertyinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='GOPT' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianattornyinfo
                    FROM  
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='ATTY' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardianworkerinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber,
                            pa.address
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personguardian ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.guadianpersonid AND p1.activeflag =1                  
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1  
                        LEFT JOIN personaddress pa ON pa.personid=p1.personid AND pa.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ecp.guardianpersontypekey='WRK' AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardiafuneralinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            ecp.contact,                              
                            ecp.contactnumber,                              
                            ecp.arrangementsdescription
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        INNER JOIN personguardianfuneral ecp ON ecp.personid= per.personid AND ecp.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                (
                    SELECT
                        Json_agg(e) AS guardiacodeinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            ecp.codestatustypekey,
                            rv.description,
                            ecp.othercodestatus,                              
                            pgd.hhsclientid,
                            pgd.notes
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        INNER JOIN personguardiancode ecp ON ecp.personid= per.personid AND ecp.activeflag=1
                        LEFT JOIN referencevalues rv ON rv.ref_key=ecp.codestatustypekey
                        INNER JOIN personguardiandetails pgd ON pgd.personid= per.personid AND pgd.activeflag=1
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                    (
                    SELECT
                        Json_agg(e) AS personpayeeinfo
                    FROM
                    (                  
                        SELECT
                            isra.intakeserviceid,                              
                            act.actorid,                              
                            p1.firstname,                              
                            p1.lastname,  
                            ecp.startdate,
                            ecp.enddate,
                            ph.phonenumber ,
                            up.lastname ||','|| up.firstname as username
                        FROM intakeservicerequestactor isra                  
                        INNER JOIN actor act ON act.actorid=isra.actorid AND act.activeflag=1                  
                        INNER JOIN person per ON per.personid=act.personid AND per.activeflag=1                  
                        LEFT JOIN personrepresentativepayee ecp ON ecp.personid= per.personid AND ecp.activeflag=1                  
                        LEFT JOIN person AS p1 ON p1.personid=ecp.personrepresentativepersonid AND p1.activeflag =1  
                        LEFT JOIN userprofile up on up.securityusersid=ecp.personrepresentativeworkerid AND ecp.activeflag=1
                        LEFT JOIN personphonenumber ph ON ph.personid=p1.personid AND ph.activeflag=1                  
                        WHERE isra.intakeserviceid=v_intakeserviceid AND ac.actorid=act.actorid
                    ) AS e
                ) ::json,
                egt.typedescription AS ethinicity,
                rt.typedescription AS religion,
                MT.typedescription as maritalstatus,
                RAT.typedescription AS racetypekey,
                IAR.fetalalcoholspctrmdisordflag ,
                COALESCE(p.substanceexposednewbornflag,0) as  drugexposednewbornflag,
                IAR.probationsearchconductedflag,
                IAR.sexoffenderregisteredflag,
                p.citizenalenageflag,
                p.isqualifiedalien,
                p.alienregistrationtext,
                p.verificationremarks,
                p.alienstatustypekey,
                (
                SELECT json_agg(e) AS programarea
                from
                    (
                    SELECT
                    ppa.programkey,
                    ppa.subprogramkey,
                    (SELECT rv.description  FROM referencevalues rv
                    WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
                    (SELECT ap.programname FROM agencyprogramarea ap
                    WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1) programname
                    FROM personprogramarea ppa
                    WHERE ppa.personid = p.personid AND ppa.objectid=v_intakeserviceid ::character varying AND ppa.activeflag=1
                    AND ppa.enddate IS NULL AND ppa.sourcetype = 'CW'
                    ) AS e
                ) ::json,
                (select json_agg(x) from
                        (select prt.racetypekey,rv.value_text
                        from personracetypemap prt
                        join referencevalues rv on rv.ref_key=prt.racetypekey and rv.referencetypeid=171 and prt.activeflag=1
                        where prt.personid=p.personid
                        ) x) as race,
                grt.typedescription as gendertypedesc
            FROM intakeservicerequestactor AS iar  
                INNER JOIN actor AS ac ON iar.actorid=ac.actorid AND ac.activeflag =1 AND iar.activeflag =1  
                INNER JOIN person AS p ON p.personid=ac.personid AND p.activeflag =1  
                LEFT JOIN personphysicalattribute AS ppa ON ppa.personid=P.personid AND ppa.physicalattributetypekey = 'Ht' AND ppa.activeflag=1  
                LEFT JOIN personphysicalattribute AS ppat ON ppat.personid=P.personid AND ppat.physicalattributetypekey = 'Wt' AND ppat.activeflag=1  
                LEFT JOIN ethnicgrouptype egt ON egt.ethnicgrouptypekey=p.ethnicgrouptypekey AND egt.activeflag=1  
                LEFT JOIN gendertype grt on grt.gendertypekey = p.gendertypekey and grt.activeflag=1
                LEFT JOIN religiontype RT ON rt.religiontypekey=p.religiontypekey AND rt.activeflag=1  
                LEFT JOIN racetype RAT ON RAT.racetypekey=P.racetypekey AND RAT.activeflag=1
                LEFT JOIN maritalstatustype MT on MT.maritalstatustypekey=p.maritalstatustypekey and MT.activeflag=1
            WHERE iar.intakeserviceid=v_intakeserviceid AND coalesce(iar.isprimary,FALSE)=true --and pa.row_number=1
            GROUP BY iar.intakeservicerequestpersontypekey,p.personid,ac.actorid,address,address2,state,city,zipcode,county,ppa.attributevalue,ppat.attributevalue,
                        egt.typedescription , rt.typedescription,rat.typedescription,iar.fetalalcoholspctrmdisordflag ,iar.drugexposednewbornflag,iar.probationsearchconductedflag,
                        iar.sexoffenderregisteredflag,iar.isvictim,MT.typedescription,grt.gendertypekey
        )AS  "Person"
        LIMIT  _limit  OFFSET  _offset;
    END IF;

END;

$function$
;

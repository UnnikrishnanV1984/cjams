DROP FUNCTION IF EXISTS cjams.getpetitiondetails(uuid, character varying, integer, character varying);
DROP FUNCTION IF EXISTS cjams.getpetitiondetails(uuid, character varying, integer, character varying, integer);
DROP FUNCTION IF EXISTS cjams.getpetitiondetails(uuid, character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getpetitiondetails(v_objectid uuid, v_objecttypekey character varying, v_isExpungementSuperUser integer DEFAULT 0, isexpunged integer DEFAULT 0::integer)
 RETURNS TABLE(intakeservicerequestid uuid, intakeservicerequestpetitionid uuid,aggravatedtypekey character varying, intakenumber character varying, petitionid character varying, associatedattorneys character varying, 
                complaintid character varying, transferpetitionid character varying, petitionfiled boolean, hearingdatetime timestamp, hearingtypekey character varying, hearingnotes text, teamtypekey character varying, 
                petitionfocusname character varying, petitiontypekey character varying, petitionstatustypekey character varying, courtcasenumber character varying, petitiondate timestamp, servicecaseid uuid, 
                witness1 character varying, clientactorsid uuid,intakeservicerequestpetitionactor json,petitiontype json,intakeservicerequestcourthearing json)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 01/28/2026 Manasa Kasula - CIDM-10890: Expungement changes
-- 06/05/2026 Surya Arigela - CIDM-11401: B-240648 Refinement to TPR - Termination of Parental Rights
------------------------------------------------------------------------------------------------------------
DECLARE	
v_isexpunged integer;
BEGIN

	v_isexpunged = 0;
    IF v_objecttypekey = 'servicecase' THEN  
        v_isexpunged = 0;
    ELSE  
        -- CPS EXPUNGEMENT
		IF (v_isExpungementSuperUser = 1) THEN
			v_isexpunged = isexpunged;
		END IF;
    END IF;

    IF v_isexpunged = 1 THEN 

        Return Query 
        select 
            isrp.intakeservicerequestid,
            isrp.intakeservicerequestpetitionid, 
            isrp.aggravatedtypekey, 
            isrp.intakenumber, 
            isrp.petitionid, 
            isrp.associatedattorneys, 
            isrp.complaintid, 
            isrp.transferpetitionid, 
            isrp.petitionfiled,
            isrp.hearingdatetime, 
            isrp.hearingtypekey, 
            isrp.hearingnotes, 
            isrp.teamtypekey, 
            isrp.petitionfocusname, 
            isrp.petitiontypekey, 
            isrp.petitionstatustypekey, 
            isrp.courtcasenumber, 
            isrp.petitiondate, 
            isrp.servicecaseid, 
            isrp.witness1, 
            isrp.clientactorsid,
            (SELECT json_agg(json_build_object(
                    'intakeservicerequestpetitionid', isrpa.intakeservicerequestpetitionid,
                    'intakeservicerequestactorid',	isrpa.intakeservicerequestactorid,
                    'petitionactortype',isrpa.petitionactortype,
                    'intakeservicerequestactor',(SELECT json_build_object(
                        'intakeservicerequestactorid', isra.intakeservicerequestactorid,
                        'personid',	isra.personid,
                        'person', (SELECT json_build_object(
                        'personid', p.personid,
                        'firstname',p.firstname,
                        'lastname', p.lastname,
                        'cjamspid', p.cjamspid,
                        'middlename',p.middlename,
                        'prefix',p.prefx,
                        'suffix',p.suffix) person 
                        from person p 
                        where p.personid = isra.personid and p.activeflag = 1)) intakeservicerequestactor 
                        from expunge.intakeservicerequestactor_expunge isra 
                        where isra.intakeservicerequestactorid = isrpa.intakeservicerequestactorid and isra.activeflag = 1)
                    )) intakeservicerequestpetitionactor 
                    from intakeservicerequestpetitionactor isrpa 
                    where isrpa.Intakeservicerequestpetitionid = isrp.Intakeservicerequestpetitionid and isrpa.activeflag = 1),
            (SELECT json_build_object(
                    'description', pt.description,
                    'petitiontypekey',	pt.petitiontypekey,
                    'petitiontypeid',pt.petitiontypeid) petitiontype 
                    from petitiontype pt 
                    where pt.petitiontypekey = isrp.petitiontypekey and pt.activeflag = 1),
            (SELECT json_agg(json_build_object(
                    'intakeservicerequestcourthearingid',isrch.intakeservicerequestcourthearingid,
                    'intakeserviceid',isrch.intakeserviceid,
                    'servicecaseid', isrch.servicecaseid,
                    'intakeservicerequestpetitionid',isrch.intakeservicerequestpetitionid,
                    'courtcasenumber', isrch.courtcasenumber,
                    'hearingtypekey', isrch.hearingtypekey,
                    'hearingtype', isrch.hearingtype,
                    'hearingdatetime',isrch.hearingdatetime,
                    'statekey', isrch.statekey,
                    'countyid', isrch.countyid,
                    'focusname', isrch.focusname,
                    'judgename', isrch.judgename,
                    'hearingstatustypekey',isrch.hearingstatustypekey,
                    'changeofpermanency', isrch.changeofpermanency,
                    'datenoticehearing', isrch.datenoticehearing,
                    'hearingnotes', isrch.hearingnotes,
                    'activeflag', isrch.activeflag,
                    'effectivedate',isrch.effectivedate,
                    'expirationdate', isrch.expirationdate,
                    'intakenumber', isrch.intakenumber,
                    'associatedattorneys', isrch.associatedattorneys,
                    'transferpetitionid', isrch.transferpetitionid,
                    'transfernotes', isrch.transfernotes,
                    'otherhearingtypenotes', isrch.otherhearingtypenotes,
                    'nofurtherinvolvementflag', isrch.nofurtherinvolvementflag,
                    'exceptionappealfiledflag', isrch.exceptionappealfiledflag,
                    'exceptionappealflag', isrch.exceptionappealflag,
                    'nexthearingdate', isrch.nexthearingdate,
                    'nexthearingtime', isrch.nexthearingtime,
                    'nexthearingtype', isrch.nexthearingtype,
                    'benefitsdate', isrch.benefitsdate,
                    'Intakeservicerequestpetitionid',isrch.Intakeservicerequestpetitionid,
                    'hearingparents',
                    (
                        SELECT COALESCE(json_agg(parent_data), '[]'::json)
                        FROM (
                            SELECT json_build_object(
                                'intakeservicerequestactorid', isrch.parent1actorid,
                                'petitionactortype', 'PARENT1',
                                'personid', isrch.parent1personid,
                                'name', isrch.parent1name,
                                'unknown', isrch.parent1unknown
                            ) AS parent_data
                            WHERE isrch.parent1actorid IS NOT NULL
                               OR isrch.parent1personid IS NOT NULL
                               OR isrch.parent1name IS NOT NULL
                               OR isrch.parent1unknown = true

                            UNION ALL

                            SELECT json_build_object(
                                'intakeservicerequestactorid', isrch.parent2actorid,
                                'petitionactortype', 'PARENT2',
                                'personid', isrch.parent2personid,
                                'name', isrch.parent2name,
                                'unknown', isrch.parent2unknown
                            ) AS parent_data
                            WHERE isrch.parent2actorid IS NOT NULL
                               OR isrch.parent2personid IS NOT NULL
                               OR isrch.parent2name IS NOT NULL
                               OR isrch.parent2unknown = true
                        ) parents
                    )
                    )) intakeservicerequestcourthearing 
                    from intakeservicerequestcourthearing isrch 
                    where isrch.Intakeservicerequestpetitionid = isrp.Intakeservicerequestpetitionid and isrch.activeflag = 1)
        from cjams.intakeservicerequestpetition isrp       
        where CASE LOWER(v_objecttypekey) WHEN 'servicecase' THEN isrp.servicecaseid = v_objectid ELSE isrp.intakeservicerequestid = v_objectid END 
        and isrp.activeflag = 1;

    ELSIF v_isexpunged = 2 THEN 

        Return Query 
        select 
            isrp.intakeservicerequestid,
            isrp.intakeservicerequestpetitionid, 
            isrp.aggravatedtypekey, 
            isrp.intakenumber, 
            isrp.petitionid, 
            isrp.associatedattorneys, 
            isrp.complaintid, 
            isrp.transferpetitionid, 
            isrp.petitionfiled,
            isrp.hearingdatetime, 
            isrp.hearingtypekey, 
            isrp.hearingnotes, 
            isrp.teamtypekey, 
            isrp.petitionfocusname, 
            isrp.petitiontypekey, 
            isrp.petitionstatustypekey, 
            isrp.courtcasenumber, 
            isrp.petitiondate, 
            isrp.servicecaseid, 
            isrp.witness1, 
            isrp.clientactorsid,
            (SELECT json_agg(json_build_object(
                    'intakeservicerequestpetitionid', isrpa.intakeservicerequestpetitionid,
                    'intakeservicerequestactorid',	isrpa.intakeservicerequestactorid,
                    'petitionactortype',isrpa.petitionactortype,
                    'intakeservicerequestactor',(SELECT json_build_object(
                        'intakeservicerequestactorid', isra.intakeservicerequestactorid,
                        'personid',	isra.personid,
                        'person', (SELECT json_build_object(
                        'personid', p.personid,
                        'firstname',p.firstname,
                        'lastname', p.lastname,
                        'cjamspid', p.cjamspid,
                        'middlename',p.middlename,
                        'prefix',p.prefx,
                        'suffix',p.suffix) person 
                        from person p 
                        where p.personid = isra.personid and p.activeflag = 1)) intakeservicerequestactor 
                        from 
                        (
                        select isra2.intakeservicerequestactorid, isra2.personid from intakeservicerequestactor isra2 where isra2.intakeservicerequestactorid =isrpa.intakeservicerequestactorid and isra2.activeflag =1
                        union 
                        select isra1.intakeservicerequestactorid, isra1.personid from expunge.intakeservicerequestactor_expunge isra1 where isra1.intakeservicerequestactorid = isrpa.intakeservicerequestactorid and isra1.activeflag =1
                        ) isra)
                    )) intakeservicerequestpetitionactor 
                    from intakeservicerequestpetitionactor isrpa 
                    where isrpa.Intakeservicerequestpetitionid = isrp.Intakeservicerequestpetitionid and isrpa.activeflag = 1),
            (SELECT json_build_object(
                    'description', pt.description,
                    'petitiontypekey',	pt.petitiontypekey,
                    'petitiontypeid',pt.petitiontypeid) petitiontype 
                    from petitiontype pt 
                    where pt.petitiontypekey = isrp.petitiontypekey and pt.activeflag = 1),
            (SELECT json_agg(json_build_object(
                    'intakeservicerequestcourthearingid',isrch.intakeservicerequestcourthearingid,
                    'intakeserviceid',isrch.intakeserviceid,
                    'servicecaseid', isrch.servicecaseid,
                    'intakeservicerequestpetitionid',isrch.intakeservicerequestpetitionid,
                    'courtcasenumber', isrch.courtcasenumber,
                    'hearingtypekey', isrch.hearingtypekey,
                    'hearingtype', isrch.hearingtype,
                    'hearingdatetime',isrch.hearingdatetime,
                    'statekey', isrch.statekey,
                    'countyid', isrch.countyid,
                    'focusname', isrch.focusname,
                    'judgename', isrch.judgename,
                    'hearingstatustypekey',isrch.hearingstatustypekey,
                    'changeofpermanency', isrch.changeofpermanency,
                    'datenoticehearing', isrch.datenoticehearing,
                    'hearingnotes', isrch.hearingnotes,
                    'activeflag', isrch.activeflag,
                    'effectivedate',isrch.effectivedate,
                    'expirationdate', isrch.expirationdate,
                    'intakenumber', isrch.intakenumber,
                    'associatedattorneys', isrch.associatedattorneys,
                    'transferpetitionid', isrch.transferpetitionid,
                    'transfernotes', isrch.transfernotes,
                    'otherhearingtypenotes', isrch.otherhearingtypenotes,
                    'nofurtherinvolvementflag', isrch.nofurtherinvolvementflag,
                    'exceptionappealfiledflag', isrch.exceptionappealfiledflag,
                    'exceptionappealflag', isrch.exceptionappealflag,
                    'nexthearingdate', isrch.nexthearingdate,
                    'nexthearingtime', isrch.nexthearingtime,
                    'nexthearingtype', isrch.nexthearingtype,
                    'benefitsdate', isrch.benefitsdate,
                    'Intakeservicerequestpetitionid',isrch.Intakeservicerequestpetitionid,
                    'hearingparents',
                    (
                        SELECT COALESCE(json_agg(parent_data), '[]'::json)
                        FROM (
                            SELECT json_build_object(
                                'intakeservicerequestactorid', isrch.parent1actorid,
                                'petitionactortype', 'PARENT1',
                                'personid', isrch.parent1personid,
                                'name', isrch.parent1name,
                                'unknown', isrch.parent1unknown
                            ) AS parent_data
                            WHERE isrch.parent1actorid IS NOT NULL
                               OR isrch.parent1personid IS NOT NULL
                               OR isrch.parent1name IS NOT NULL
                               OR isrch.parent1unknown = true

                            UNION ALL

                            SELECT json_build_object(
                                'intakeservicerequestactorid', isrch.parent2actorid,
                                'petitionactortype', 'PARENT2',
                                'personid', isrch.parent2personid,
                                'name', isrch.parent2name,
                                'unknown', isrch.parent2unknown
                            ) AS parent_data
                            WHERE isrch.parent2actorid IS NOT NULL
                               OR isrch.parent2personid IS NOT NULL
                               OR isrch.parent2name IS NOT NULL
                               OR isrch.parent2unknown = true
                        ) parents
                    )
                    )) intakeservicerequestcourthearing 
                    from intakeservicerequestcourthearing isrch 
                    where isrch.Intakeservicerequestpetitionid = isrp.Intakeservicerequestpetitionid and isrch.activeflag = 1)
        from cjams.intakeservicerequestpetition isrp       
        where CASE LOWER(v_objecttypekey) WHEN 'servicecase' THEN isrp.servicecaseid = v_objectid ELSE isrp.intakeservicerequestid = v_objectid END 
        and isrp.activeflag = 1; 

    ELSE

        Return Query 
        select 
            isrp.intakeservicerequestid,
            isrp.intakeservicerequestpetitionid, 
            isrp.aggravatedtypekey, 
            isrp.intakenumber, 
            isrp.petitionid, 
            isrp.associatedattorneys, 
            isrp.complaintid, 
            isrp.transferpetitionid, 
            isrp.petitionfiled,
            isrp.hearingdatetime, 
            isrp.hearingtypekey, 
            isrp.hearingnotes, 
            isrp.teamtypekey, 
            isrp.petitionfocusname, 
            isrp.petitiontypekey, 
            isrp.petitionstatustypekey, 
            isrp.courtcasenumber, 
            isrp.petitiondate, 
            isrp.servicecaseid, 
            isrp.witness1, 
            isrp.clientactorsid,
            (SELECT json_agg(json_build_object(
                    'intakeservicerequestpetitionid', isrpa.intakeservicerequestpetitionid,
                    'intakeservicerequestactorid',	isrpa.intakeservicerequestactorid,
                    'petitionactortype',isrpa.petitionactortype,
                    'intakeservicerequestactor',(SELECT json_build_object(
                        'intakeservicerequestactorid', isra.intakeservicerequestactorid,
                        'personid',	isra.personid,
                        'person', (SELECT json_build_object(
                        'personid', p.personid,
                        'firstname',p.firstname,
                        'lastname', p.lastname,
                        'cjamspid', p.cjamspid,
                        'middlename',p.middlename,
                        'prefix',p.prefx,
                        'suffix',p.suffix) person 
                        from person p 
                        where p.personid = isra.personid and p.activeflag = 1)) intakeservicerequestactor 
                        from intakeservicerequestactor isra 
                        where isra.intakeservicerequestactorid = isrpa.intakeservicerequestactorid and isra.activeflag = 1)
                    )) intakeservicerequestpetitionactor 
                    from intakeservicerequestpetitionactor isrpa 
                    where isrpa.Intakeservicerequestpetitionid = isrp.Intakeservicerequestpetitionid and isrpa.activeflag = 1),
            (SELECT json_build_object(
                    'description', pt.description,
                    'petitiontypekey',	pt.petitiontypekey,
                    'petitiontypeid',pt.petitiontypeid) petitiontype 
                    from petitiontype pt 
                    where pt.petitiontypekey = isrp.petitiontypekey and pt.activeflag = 1),
            (SELECT json_agg(json_build_object(
                    'intakeservicerequestcourthearingid',isrch.intakeservicerequestcourthearingid,
                    'intakeserviceid',isrch.intakeserviceid,
                    'servicecaseid', isrch.servicecaseid,
                    'intakeservicerequestpetitionid',isrch.intakeservicerequestpetitionid,
                    'courtcasenumber', isrch.courtcasenumber,
                    'hearingtypekey', isrch.hearingtypekey,
                    'hearingtype', isrch.hearingtype,
                    'hearingdatetime',isrch.hearingdatetime,
                    'statekey', isrch.statekey,
                    'countyid', isrch.countyid,
                    'focusname', isrch.focusname,
                    'judgename', isrch.judgename,
                    'hearingstatustypekey',isrch.hearingstatustypekey,
                    'changeofpermanency', isrch.changeofpermanency,
                    'datenoticehearing', isrch.datenoticehearing,
                    'hearingnotes', isrch.hearingnotes,
                    'activeflag', isrch.activeflag,
                    'effectivedate',isrch.effectivedate,
                    'expirationdate', isrch.expirationdate,
                    'intakenumber', isrch.intakenumber,
                    'associatedattorneys', isrch.associatedattorneys,
                    'transferpetitionid', isrch.transferpetitionid,
                    'transfernotes', isrch.transfernotes,
                    'otherhearingtypenotes', isrch.otherhearingtypenotes,
                    'nofurtherinvolvementflag', isrch.nofurtherinvolvementflag,
                    'exceptionappealfiledflag', isrch.exceptionappealfiledflag,
                    'exceptionappealflag', isrch.exceptionappealflag,
                    'nexthearingdate', isrch.nexthearingdate,
                    'nexthearingtime', isrch.nexthearingtime,
                    'nexthearingtype', isrch.nexthearingtype,
                    'benefitsdate', isrch.benefitsdate,
                    'Intakeservicerequestpetitionid',isrch.Intakeservicerequestpetitionid,
                    'hearingparents',
                    (
                        SELECT COALESCE(json_agg(parent_data), '[]'::json)
                        FROM (
                            SELECT json_build_object(
                                'intakeservicerequestactorid', isrch.parent1actorid,
                                'petitionactortype', 'PARENT1',
                                'personid', isrch.parent1personid,
                                'name', isrch.parent1name,
                                'unknown', isrch.parent1unknown
                            ) AS parent_data
                            WHERE isrch.parent1actorid IS NOT NULL
                               OR isrch.parent1personid IS NOT NULL
                               OR isrch.parent1name IS NOT NULL
                               OR isrch.parent1unknown = true

                            UNION ALL

                            SELECT json_build_object(
                                'intakeservicerequestactorid', isrch.parent2actorid,
                                'petitionactortype', 'PARENT2',
                                'personid', isrch.parent2personid,
                                'name', isrch.parent2name,
                                'unknown', isrch.parent2unknown
                            ) AS parent_data
                            WHERE isrch.parent2actorid IS NOT NULL
                               OR isrch.parent2personid IS NOT NULL
                               OR isrch.parent2name IS NOT NULL
                               OR isrch.parent2unknown = true
                        ) parents
                    )
                    )) intakeservicerequestcourthearing 
                    from intakeservicerequestcourthearing isrch 
                    where isrch.Intakeservicerequestpetitionid = isrp.Intakeservicerequestpetitionid and isrch.activeflag = 1)
        from cjams.intakeservicerequestpetition isrp       
        where CASE LOWER(v_objecttypekey) WHEN 'servicecase' THEN isrp.servicecaseid = v_objectid ELSE isrp.intakeservicerequestid = v_objectid END 
        and isrp.activeflag = 1; 
    END IF;

END;

$function$
;
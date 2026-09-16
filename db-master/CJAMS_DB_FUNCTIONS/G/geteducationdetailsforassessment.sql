DROP function if exists geteducationdetailsforassessment(uuid);
CREATE OR REPLACE FUNCTION cjams.geteducationdetailsforassessment(v_intakeserviceid uuid)
 RETURNS TABLE("Pid" uuid, "personEducation" json, "personEducationTesting" json, "personAccomplishment" json)
 LANGUAGE plpgsql
AS $function$
 

DECLARE
    
    v_personid uuid;
        	
BEGIN
    
  --  v_personid := personid :: uuid;
 
RETURN QUERY

	SELECT p.personid AS "Pid", 
	(SELECT json_agg(pe) FROM 
		(
	(SELECT 'current' as schooltype,
			e.personeducationid, e.personid, e.educationname, e.educationtypekey, e.schoolsettingtypekey, e.transportmodetypekey, 
			e.transportmodetypedetail, e.adrcityname, e.adresscounty, e.statecode, e.startdate, e.enddate, 
			e.contactname, e.adrworkphone, e.adrworkxtn, e.schoolschedule, e.schooladjustment, e.isspecialeducation, 
			e.specialeducationtypekey, e.lastiepdate, e.ifsplastdate, e.numberofabsences, e.isreceived, e.isverified, 
			e.isexcuesed, e.extracurricular,
			e.firstqtrabsence, e.firstqtrabsenceexcused, e.firstqtrabsencenotexcused, e.firstqtrabsencetardy, 
			e.secondqtrabsence, e.secondqtrabsenceexcused, e.secondqtrabsencenotexcused, e.secondqtrabsencetardy, 
			e.thirdqtrabsence, e.thirdqtrabsenceexcused, e.thirdqtrabsencenotexcused, e.thirdqtrabsencetardy, 
			e.fourthqtrabsence, e.fourthqtrabsenceexcused, e.fourthqtrabsencenotexcused, e.fourthqtrabsencetardy, 
			e.summerschoolname, e.highestgradetypekey, e.currentgradetypekey, e.lastgradetypekey,
			e.classtypetypekey, e.currentgradelevel, e.functioninggradelevel, e.lastgradelevel, 
			e.firstqtrperformancetypekey, e.secondqtrperformancetypekey, e.thirdqtrperformancetypekey, e.fourthqtrperformancetypekey, 
			e.speacialeducationrestrictivekey, e.lastattendeddate, e.schoolexitcomments, e.disciplinaryactioncomments, 
			e.sasidno,
			(select rv.description as adresscountydesc  from referencevalues rv where rv.ref_key = e.adresscounty and rv.referencetypeid = 306 and rv.activeflag = 1 limit 1),
			(select rv.description as currentgradeleveldesc  from referencevalues rv where rv.ref_key = e.currentgradetypekey and rv.referencetypeid = 185 and rv.activeflag = 1 limit 1)
		FROM personeducation e 
		WHERE e.personid = p.personid AND e.activeflag = 1 and e.startdate is not null  
		and e.enddate is null order by e.startdate desc limit 1	)
		union all 
		(SELECT 'Previous' as schooltype,
			e.personeducationid, e.personid, e.educationname, e.educationtypekey, e.schoolsettingtypekey, e.transportmodetypekey, 
			e.transportmodetypedetail, e.adrcityname, e.adresscounty, e.statecode, e.startdate, e.enddate, 
			e.contactname, e.adrworkphone, e.adrworkxtn, e.schoolschedule, e.schooladjustment, e.isspecialeducation, 
			e.specialeducationtypekey, e.lastiepdate, e.ifsplastdate, e.numberofabsences, e.isreceived, e.isverified, 
			e.isexcuesed, e.extracurricular,
			e.firstqtrabsence, e.firstqtrabsenceexcused, e.firstqtrabsencenotexcused, e.firstqtrabsencetardy, 
			e.secondqtrabsence, e.secondqtrabsenceexcused, e.secondqtrabsencenotexcused, e.secondqtrabsencetardy, 
			e.thirdqtrabsence, e.thirdqtrabsenceexcused, e.thirdqtrabsencenotexcused, e.thirdqtrabsencetardy, 
			e.fourthqtrabsence, e.fourthqtrabsenceexcused, e.fourthqtrabsencenotexcused, e.fourthqtrabsencetardy, 
			e.summerschoolname, e.highestgradetypekey, e.currentgradetypekey, e.lastgradetypekey,
			e.classtypetypekey, e.currentgradelevel, e.functioninggradelevel, e.lastgradelevel, 
			e.firstqtrperformancetypekey, e.secondqtrperformancetypekey, e.thirdqtrperformancetypekey, e.fourthqtrperformancetypekey, 
			e.speacialeducationrestrictivekey, e.lastattendeddate, e.schoolexitcomments, e.disciplinaryactioncomments, 
			e.sasidno,
			(select rv.description as adresscountydesc  from referencevalues rv where rv.ref_key = e.adresscounty and rv.referencetypeid = 306 and rv.activeflag = 1 limit 1),
			(select rv.description as currentgradeleveldesc  from referencevalues rv where rv.ref_key = e.currentgradetypekey and rv.referencetypeid = 185 and rv.activeflag = 1 limit 1)
		FROM personeducation e 
		WHERE e.personid = p.personid AND e.activeflag = 1    
		and e.enddate is not null order by e.enddate desc limit 1	)
	) pe)::json AS "personEducation",
		(SELECT json_agg(pet) FROM 
		(
		SELECT 
			et.personeducationtestingid, et.testingtypekey, et.readinglevel, et.readingtestdate, et.testingprovider
		FROM personeducationtesting et 
		WHERE et.personid = p.personid AND et.activeflag = 1    
			
		) pet)::json AS "personEducationTesting",
		(SELECT json_agg(pa) FROM 
		(
		SELECT 
			ea.personaccomplishmentid, ea.highestgradetypekey, ea.accomplishmentdate, ea.isrecordreceived, ea.receiveddate
		FROM personaccomplishment ea 
		WHERE ea.personid = p.personid AND ea.activeflag = 1    
			
		) pa)::json AS "personAccomplishment"	
	FROM person p 
    join actor a on a.personid = p.personid and a.activeflag =1
    join intakeservicerequestactor ina on ina.actorid = a.actorid and ina.activeflag = 1
	WHERE (ina.intakeserviceid = v_intakeserviceid or ina.servicecaseid = v_intakeserviceid) AND p.activeflag = 1
    and ina.intakeservicerequestpersontypekey = 'CHILD';
	


END;

 
$function$
;
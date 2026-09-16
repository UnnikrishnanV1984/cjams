Drop FUNCTION cjams.geteducationdetails(personid uuid);

CREATE OR REPLACE FUNCTION cjams.geteducationdetails(personid uuid)
 RETURNS TABLE("Pid" uuid, "personEducation" json, "personEducationTesting" json, "personAccomplishment" json)
 LANGUAGE plpgsql
AS $function$
 ------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 09/18/2024 Charan sai Bodapati - Added bidadded coloumn is added to store the falg for the Bid record (CIDM-9416)
-- 07/09/2025 Umasankar Raavi --Added school address columns (CIDM-10611)
------------------------------------------------------------------------------------------------------------

DECLARE
    
    v_personid uuid;
        	
BEGIN
    
    v_personid := personid :: uuid;
 
RETURN QUERY

	SELECT p.personid AS "Pid", 
	(SELECT json_agg(pe) FROM 
		(
		SELECT 
			e.personeducationid, e.personid,e.bidadded, e.educationname, e.educationtypekey, e.schoolsettingtypekey, e.transportmodetypekey, 
			e.transportmodetypedetail, e.schooladdress1,e.schooladdress2, e.schoolzipcode,e.adrcityname, e.adresscounty, e.statecode, e.startdate, e.enddate, 
			e.contactname, e.adrworkphone, e.adrworkxtn, e.schoolschedule, e.schooladjustment, e.isspecialeducation, 
			e.specialeducationtypekey, e.lastiepdate, e.lastifspdate, e.ifsplastdate, e.numberofabsences, e.isreceived, e.isverified, 
			e.isexcuesed, e.extracurricular, e.bestdetermination,e.nonewenrollment,
			e.firstqtrabsence, e.firstqtrabsenceexcused, e.firstqtrabsencenotexcused, e.firstqtrabsencetardy, 
			e.secondqtrabsence, e.secondqtrabsenceexcused, e.secondqtrabsencenotexcused, e.secondqtrabsencetardy, 
			e.thirdqtrabsence, e.thirdqtrabsenceexcused, e.thirdqtrabsencenotexcused, e.thirdqtrabsencetardy, 
			e.fourthqtrabsence, e.fourthqtrabsenceexcused, e.fourthqtrabsencenotexcused, e.fourthqtrabsencetardy, 
			e.summerschoolname, e.highestgradetypekey,e.schoolenrolltypekey, e.currentgradetypekey, e.lastgradetypekey,
			e.classtypetypekey, e.currentgradelevel, e.functioninggradelevel, e.lastgradelevel, 
			e.firstqtrperformancetypekey, e.secondqtrperformancetypekey, e.thirdqtrperformancetypekey, e.fourthqtrperformancetypekey, 
			e.speacialeducationrestrictivekey, e.lastattendeddate, e.schoolexitcomments, e.schoolchangereason, e.disciplinaryactioncomments, e.sasidno,e.enrollmentdate,e.delayinenrollment, 
			e.delayinenrollmentdetail,
			(select rv.description as adresscountydesc  from referencevalues rv where rv.ref_key = e.adresscounty and rv.referencetypeid = 306 and rv.activeflag = 1 limit 1),
			(select rv.description as currentgrade from referencevalues rv where rv.ref_key = e.currentgradetypekey and rv.referencetypeid = 185 and rv.activeflag = 1 limit 1 ),
			e.statustypekey,
			(SELECT json_agg(pea) FROM (SELECT *, (select fullname from v_userprofile where securityusersid = ea.updatedby) as username, (case when date(ea.enddate) > date(now()) then true else false end) allowedit  FROM personeducationalertactions ea WHERE ea.personeducationid = e.personeducationid AND ea.activeflag = 1 ) pea)::json AS "educationalert"	,
            (SELECT json_agg(docu) FROM(

                                        SELECT doc.s3bucketpathname,doc.originalfilename,doc.documentpropertiesid,doc.rootobjecttypekey , doc.additionalobjectid, doc.additionalobjecttype, doc.filename,doc.actualdocumentdate, doc.documentdate, doc.updatedby, 
                                        (select fullname from userprofile u2 where u2.securityusersid = doc.updatedby), doc.updatedon,
										(select attachmentclassificationtypekey from documentattachment where documentpropertiesid = doc.documentpropertiesid),
										(select attachmentclassificationsubtypekey from documentattachment where documentpropertiesid = doc.documentpropertiesid),
										doc.uploadstatus, 
										doc.finalstatus,										
										doc.ecmsdocumentid
										FROM documentproperties doc
									    where doc.additionalobjectid =e.personeducationid:: character varying and doc.objectid = p.personid and doc.activeflag in (1,3,4,5)
									   )
                    docu )::json as "personEducationDcouments",
			(SELECT json_agg(history) FROM(

                                        SELECT peh.*,rv.description as statustypekeydesc,up.displayname 
										FROM personeducation_history peh
										join userprofile up on up.securityusersid = peh.updatedby
										left join referencevalues rv on rv.ref_key = peh.statustypekey and rv.referencetypeid = 146 and rv.teamtypekey='CW'
									    where peh.personeducationid:: character varying =e.personeducationid:: character varying and peh.activeflag =1
									   )
                    history )::json as "personEducationHistory"

		FROM personeducation e 
		WHERE e.personid = p.personid AND e.activeflag = 1    
			
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
	WHERE p.personid = v_personid AND p.activeflag = 1;
	


END;

 
$function$
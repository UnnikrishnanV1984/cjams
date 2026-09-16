CREATE OR REPLACE FUNCTION cjams.addupdateeducation(personid uuid, personeducation json, personeducationtesting json, personaccomplishment json, securityuserid character varying)
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
    v_educationjson json;
   	v_educationtestingjson json;
   	v_educationaccomplishmentjson json;
    v_securityuserid character varying;
    v_education json;
	v_educationtesting json;
   	v_educationaccomplishment json;
	v_educationalert json;
	v_result json;

	V_classtypetypekey character varying ;
	V_currentgradelevel character varying ;
	V_functioninggradelevel character varying ;
	V_lastgradelevel character varying ;
		
	v_speacialeducationrestrictivekey character varying ;
	v_lastattendeddate character varying ;
	v_schoolexitcomments character varying ;
	v_schoolchangereason character varying ;
	v_disciplinaryactioncomments character varying ;

	v_persondescription text;

BEGIN
    
    v_personid := personid :: uuid;
    v_educationjson := personEducation;
	v_educationtestingjson := personEducationTesting;
   	v_educationaccomplishmentjson := personAccomplishment;
	v_securityuserid := securityuserid;
   
	-- Delete Person education --
--	UPDATE  personeducation e 
--	SET activeflag = 0 
--	WHERE e.personid = v_personid;   

    select personDescription into v_persondescription from  getpersonnameandid(v_personid);

	FOR  v_education  IN  SELECT  *  FROM    json_array_elements(v_educationjson)  LOOP
	
		IF (v_education  ->> 'personeducationid') IS NULL THEN
		
			INSERT INTO personeducation (
			    personid, 
			    educationname, 
			    educationtypekey, 
				schoolsettingtypekey,
				transportmodetypekey,
				transportmodetypedetail,
				schooladdress1,
				schooladdress2,
				schoolzipcode,
				adrcityname,
				adresscounty,
				statecode,
				startdate,
				enddate,
				bestdetermination,
				contactname,
				adrworkphone,
				adrworkxtn,
				schoolschedule,
				schooladjustment,
				isspecialeducation,
				specialeducationtypekey,
				lastiepdate,
				lastifspdate,
				ifsplastdate,
				enrollmentdate,
				nonewenrollment,
				numberofabsences,
				isreceived,
				isverified,
				isexcuesed,
				extracurricular,
			
				firstqtrabsence,
				firstqtrabsenceexcused,
				firstqtrabsencenotexcused,
				firstqtrabsencetardy,
				secondqtrabsence,
				secondqtrabsenceexcused,
				secondqtrabsencenotexcused,
				secondqtrabsencetardy,
				thirdqtrabsence,
				thirdqtrabsenceexcused,
				thirdqtrabsencenotexcused,
				thirdqtrabsencetardy,
				fourthqtrabsence,
				fourthqtrabsenceexcused,
				fourthqtrabsencenotexcused,
				fourthqtrabsencetardy,				
				summerschoolname,				
				highestgradetypekey,
				schoolenrolltypekey,
				currentgradetypekey,
				lastgradetypekey,
			
				classtypetypekey,
				currentgradelevel,
				functioninggradelevel,
				lastgradelevel,
				
				firstqtrperformancetypekey,
				secondqtrperformancetypekey,
				thirdqtrperformancetypekey,
				fourthqtrperformancetypekey,
				
				speacialeducationrestrictivekey,
				lastattendeddate,
				schoolexitcomments,
				schoolchangereason,
				disciplinaryactioncomments,
			    insertedby, 
			    insertedon,
				updatedby,
				updatedon,
			    sasidno,
				statustypekey,
				delayinenrollment,
				delayinenrollmentdetail,
				bidadded
			    ) 
			values(
			    v_personid,
			    v_education  ->> 'educationname',
			    v_education  ->> 'educationtypekey',
			    v_education  ->> 'schoolsettingtypekey',
				v_education  ->> 'transportmodetypekey',
				v_education  ->> 'transportmodetypedetail',
				v_education  ->> 'schooladdress1',
				v_education  ->> 'schooladdress2',
				v_education  ->> 'schoolzipcode',
				v_education  ->> 'adrcityname',
				v_education  ->> 'adresscounty',
				v_education  ->> 'statecode',
				(v_education  ->> 'startdate')::timestamp,
				(v_education  ->> 'enddate')::timestamp,
				(v_education  ->> 'bestdetermination')::json,
				v_education  ->> 'contactname',
				v_education  ->> 'adrworkphone',
				v_education  ->> 'adrworkxtn',
				v_education  ->> 'schoolschedule',
				v_education  ->> 'schooladjustment',
				(v_education  ->> 'isspecialeducation')::bool,
				v_education  ->> 'specialeducationtypekey',
				(v_education  ->> 'lastiepdate')::timestamp,
				(v_education  ->> 'lastifspdate')::timestamp,
				(v_education  ->> 'ifsplastdate')::timestamp,
				(v_education  ->> 'enrollmentdate')::timestamp,
				(v_education  ->> 'nonewenrollment')::bool,
				(v_education  ->> 'numberofabsences')::int4,
				(v_education  ->> 'isreceived')::bool,
				(v_education  ->> 'isverified')::bool,
				(v_education  ->> 'isexcuesed')::bool,
				v_education  ->> 'extracurricular',
							
				case when (v_education  ->> 'firstqtrabsence') = 'true' THEN 1 else 0 END,
				(v_education  ->> 'firstqtrabsenceexcused')::int4,
				(v_education  ->> 'firstqtrabsencenotexcused')::int,
				(v_education  ->> 'firstqtrabsencetardy')::int4,
				case when (v_education  ->> 'secondqtrabsence') = 'true' THEN 1 else 0 END,				
				(v_education  ->> 'secondqtrabsenceexcused')::int4,
				(v_education  ->> 'secondqtrabsencenotexcused')::int4,
				(v_education  ->> 'secondqtrabsencetardy')::int4,
				case when (v_education  ->> 'thirdqtrabsence') = 'true' THEN 1 else 0 END,
				(v_education  ->> 'thirdqtrabsenceexcused')::int4,
				(v_education  ->> 'thirdqtrabsencenotexcused')::int4,
				(v_education  ->> 'thirdqtrabsencetardy')::int4,
				case when (v_education  ->> 'fourthqtrabsence') = 'true' THEN 1 else 0 END,
				(v_education  ->> 'fourthqtrabsenceexcused')::int4,
				(v_education  ->> 'fourthqtrabsencenotexcused')::int4,
				(v_education  ->> 'fourthqtrabsencetardy')::int4,				
				v_education  ->> 'summerschoolname',
				v_education  ->> 'highestgradetypekey',
				(v_education  ->> 'schoolenrolltypekey'):: character varying,
				v_education  ->> 'currentgradetypekey',
				
				v_education  ->> 'lastgradetypekey',
				
				v_education  ->> 'classtypetypekey',
				v_education  ->> 'currentgradelevel',
				v_education  ->> 'functioninggradelevel',
				v_education  ->> 'lastgradelevel',
				
				v_education  ->> 'firstqtrperformancetypekey',
				v_education  ->> 'secondqtrperformancetypekey',
				v_education  ->> 'thirdqtrperformancetypekey',
				v_education  ->> 'fourthqtrperformancetypekey',
				
				v_education  ->> 'speacialeducationrestrictivekey',
				(v_education  ->> 'lastattendeddate')::timestamp,
				v_education  ->> 'schoolexitcomments',
				v_education  ->> 'schoolchangereason',
				v_education  ->> 'disciplinaryactioncomments',
			    v_securityuserid, 
			    now(),
				v_securityuserid, 
			    now(),
				(v_education  ->> 'sasidno'	) :: character varying,
				v_education ->> 'statustypekey',
				v_education ->> 'delayinenrollment',
				v_education ->> 'delayinenrollmentdetail',
				(v_education  ->> 'bidadded')::int4
			 );	
			 
		ELSE
		
		
		-- insert auditlog here with education modified  
		INSERT INTO auditlog(
							   logtypekey,
							   intakeserviceid,
							   servicerequestnumber,
							   referenceid, 
							   description, 
							   isnew,
							   isedit,
							   isdelete,
							   insertedby,
							   updatedby,
							   insertedon,
							   updatedon,
							   metadata,
							   ipaddress,
							   old_id,
							   modifieddata,
							   objectid,
							   objecttype)
						VALUES('IN035',
								NULL,
								null,
								NULL,
								concat('Education  modified for', ' ', v_persondescription ),
								false,
								true,
								false,
								v_securityuserid,
								v_securityuserid,
								now(),
								now(),
								null,
								null,
								NULL,
								NULL,
								v_education  ->> 'objectid',
								v_education  ->> 'objecttype');
		END IF;
		--  select * into  from persed  wher perseduid = (v_education  ->> 'personeducationid'):: uuid 
		select classtypetypekey,
				currentgradelevel,
				functioninggradelevel,
				lastgradelevel,
				speacialeducationrestrictivekey,
				lastattendeddate,
				schoolexitcomments,
				schoolchangereason,
				disciplinaryactioncomments
		into  v_classtypetypekey,
				v_currentgradelevel,
				v_functioninggradelevel,
				v_lastgradelevel,
				v_speacialeducationrestrictivekey,
				v_lastattendeddate,
				v_schoolexitcomments,
				v_schoolchangereason,
				v_disciplinaryactioncomments
		from 	personeducation 
		where personeducationid = (v_education  ->> 'personeducationid'):: uuid;
		
	-- one if condition  -- check grade level variables  (4 or cond)
		if 		((v_education  ->> 'classtypetypekey') != v_classtypetypekey) or 
				((v_education  ->> 'currentgradelevel') != v_currentgradelevel) or 
				((v_education  ->> 'functioninggradelevel') != v_functioninggradelevel) or 
				((v_education  ->> 'lastgradelevel') !=  v_lastgradelevel)
		then   	
		INSERT INTO auditlog(
							   logtypekey,
							   intakeserviceid,
							   servicerequestnumber,
							   referenceid, 
							   description, 
							   isnew,
							   isedit,
							   isdelete,
							   insertedby,
							   updatedby,
							   insertedon,
							   updatedon,
							   metadata,
							   ipaddress,
							   old_id,
							   modifieddata,
							   objectid,
							   objecttype)
						VALUES('NY005',
								NULL,
								null,
								NULL,
								concat('Education level is modified for', ' ', v_persondescription ),
								false,
								true,
								false,
								v_securityuserid,
								v_securityuserid,
								now(),
								now(),
								null,
								null,
								NULL,
								NULL,
								v_education  ->> 'objectid',
								v_education  ->> 'objecttype');
			END IF;
				
		-- if condition  -- special education  
			if  ((v_education  ->> 'speacialeducationrestrictivekey') != v_speacialeducationrestrictivekey) or
				((v_education  ->> 'lastattendeddate') != v_lastattendeddate) or
				((v_education  ->> 'schoolexitcomments') != v_schoolexitcomments) or
 				((v_education  ->> 'disciplinaryactioncomments') != v_disciplinaryactioncomments)
 			then
 			INSERT INTO auditlog(
							   logtypekey,
							   intakeserviceid,
							   servicerequestnumber,
							   referenceid, 
							   description, 
							   isnew,
							   isedit,
							   isdelete,
							   insertedby,
							   updatedby,
							   insertedon,
							   updatedon,
							   metadata,
							   ipaddress,
							   old_id,
							   modifieddata,
							   objectid,
							   objecttype)
						VALUES('NY006',
								NULL,
								null,
								NULL,
								concat('Special Education is modified for', ' ', v_persondescription ),
								false,
								true,
								false,
								v_securityuserid,
								v_securityuserid,
								now(),
								now(),
								null,
								null,
								NULL,
								NULL,
								v_education  ->> 'objectid',
								v_education  ->> 'objecttype');
							
			END IF;				
							
			UPDATE  personeducation e 
			SET 			
				activeflag = 1,
				educationname = v_education  ->> 'educationname',
			    educationtypekey = v_education  ->> 'educationtypekey',
				transportmodetypekey = v_education  ->> 'transportmodetypekey',
				transportmodetypedetail = v_education  ->> 'transportmodetypedetail',
				schoolsettingtypekey = v_education  ->>'schoolsettingtypekey',
				schooladdress1 = v_education  ->> 'schooladdress1',
				schooladdress2 = v_education  ->> 'schooladdress2',
				schoolzipcode = v_education  ->> 'schoolzipcode',
				adrcityname = v_education  ->> 'adrcityname',
				adresscounty = v_education  ->> 'adresscounty',
				statecode = v_education  ->> 'statecode',
				startdate = (v_education  ->> 'startdate')::timestamp,
				enddate = (v_education  ->> 'enddate')::timestamp,
				bestdetermination = (v_education  ->> 'bestdetermination'):: json,
				contactname = v_education  ->> 'contactname',
				adrworkphone = v_education  ->> 'adrworkphone',
				adrworkxtn = v_education  ->> 'adrworkxtn',
				schoolschedule = v_education  ->> 'schoolschedule',
				schooladjustment = v_education  ->> 'schooladjustment',
				isspecialeducation = (v_education  ->> 'isspecialeducation')::bool,
				specialeducationtypekey = v_education  ->> 'specialeducationtypekey',
				lastiepdate = (v_education  ->> 'lastiepdate')::timestamp,
				lastifspdate= (v_education  ->> 'lastifspdate')::timestamp,
				ifsplastdate = (v_education  ->> 'ifsplastdate')::timestamp,
				enrollmentdate = (v_education  ->> 'enrollmentdate')::timestamp,
				nonewenrollment = (v_education  ->> 'nonewenrollment')::bool,
				numberofabsences = (v_education  ->> 'numberofabsences')::int4,
				isreceived = (v_education  ->> 'isreceived')::bool,
				isverified = (v_education  ->> 'isverified')::bool,
				isexcuesed = (v_education  ->> 'isexcuesed')::bool,
				extracurricular = v_education  ->> 'extracurricular',
				
				firstqtrabsence = (v_education  ->> 'firstqtrabsence')::int4,
				firstqtrabsenceexcused = (v_education  ->> 'firstqtrabsenceexcused')::int4,
				firstqtrabsencenotexcused = (v_education  ->> 'firstqtrabsencenotexcused')::int4,
				firstqtrabsencetardy = (v_education  ->> 'firstqtrabsencetardy')::int4,
				secondqtrabsence = (v_education  ->> 'secondqtrabsence')::int4,
				secondqtrabsenceexcused = (v_education  ->> 'secondqtrabsenceexcused')::int4,
				secondqtrabsencenotexcused = (v_education  ->> 'secondqtrabsencenotexcused')::int4,
				secondqtrabsencetardy = (v_education  ->> 'secondqtrabsencetardy')::int4,
				thirdqtrabsence = (v_education  ->> 'thirdqtrabsence')::int4,
				thirdqtrabsenceexcused = (v_education  ->> 'thirdqtrabsenceexcused')::int4,
				thirdqtrabsencenotexcused = (v_education  ->> 'thirdqtrabsencenotexcused')::int4,
				thirdqtrabsencetardy = (v_education  ->> 'thirdqtrabsencetardy')::int4,
				fourthqtrabsence = (v_education  ->> 'fourthqtrabsence')::int4,
				fourthqtrabsenceexcused = (v_education  ->> 'fourthqtrabsenceexcused')::int4,
				fourthqtrabsencenotexcused = (v_education  ->> 'fourthqtrabsencenotexcused')::int4,
				fourthqtrabsencetardy = (v_education  ->> 'fourthqtrabsencetardy')::int4,				
				summerschoolname = v_education  ->> 'summerschoolname',
				highestgradetypekey = v_education  ->> 'highestgradetypekey',
				schoolenrolltypekey = (v_education  ->> 'schoolenrolltypekey')::character varying,
				currentgradetypekey = v_education  ->> 'currentgradetypekey',
				lastgradetypekey = v_education  ->> 'lastgradetypekey',
				
				classtypetypekey = v_education  ->> 'classtypetypekey',
				currentgradelevel = v_education  ->> 'currentgradelevel',	
				functioninggradelevel = v_education  ->> 'functioninggradelevel',	
				lastgradelevel = v_education  ->> 'lastgradelevel',
				
				firstqtrperformancetypekey = v_education  ->> 'firstqtrperformancetypekey',
				secondqtrperformancetypekey = v_education  ->> 'secondqtrperformancetypekey',
				thirdqtrperformancetypekey = v_education  ->> 'thirdqtrperformancetypekey',
				fourthqtrperformancetypekey = v_education  ->> 'fourthqtrperformancetypekey',
				
				speacialeducationrestrictivekey = v_education  ->> 'speacialeducationrestrictivekey',
				lastattendeddate = (v_education  ->> 'lastattendeddate')::timestamp,
				schoolexitcomments = v_education  ->> 'schoolexitcomments',
				schoolchangereason = v_education  ->> 'schoolchangereason',
				disciplinaryactioncomments = v_education  ->> 'disciplinaryactioncomments',
				updatedby = v_securityuserid,
				updatedon = now()	,
				sasidno = (v_education  ->> 'sasidno'):: character varying,
				statustypekey = v_education ->> 'statustypekey',
				delayinenrollment = v_education ->> 'delayinenrollment',
				delayinenrollmentdetail = v_education ->> 'delayinenrollmentdetail',
				bidadded = (v_education  ->> 'bidadded')::int4
			WHERE e.personeducationid = (v_education  ->> 'personeducationid'):: uuid ;		
		

		IF((v_education ->> 'educationalert')::json IS NOT NULL) THEN	

			FOR  v_educationalert  IN  SELECT  *  FROM    json_array_elements((v_education ->> 'educationalert')::json)  LOOP

					IF((v_educationalert ->> 'personeducationalertactionid')::uuid IS NOT NULL) THEN

						UPDATE personeducationalertactions 
						SET actiontype = coalesce((v_educationalert ->> 'actiontype')::character varying, actiontype)
							, reasoncode = coalesce((v_educationalert ->> 'reasoncode')::character varying, reasoncode)
							, startdate = coalesce((v_educationalert ->> 'startdate')::timestamp, startdate)
							, enddate = coalesce((v_educationalert ->> 'enddate')::timestamp, enddate)
							, endreason = coalesce((v_educationalert ->> 'endreason')::character varying, endreason)
							, notes = coalesce((v_educationalert ->> 'notes')::character varying, notes)
							, updatedby = v_securityuserid::character varying
							, updatedon = now()
						WHERE personeducationalertactionid  = (v_educationalert ->> 'personeducationalertactionid')::uuid;

					ELSE 

						INSERT INTO cjams.personeducationalertactions( 
								personeducationid
								, personid
								, actiontype
								, reasoncode
								, startdate
								, enddate
								, endreason
								, notes
								, activeflag
								, insertedby
								, insertedon
								, updatedby
								, updatedon
						) VALUES( (v_education  ->> 'personeducationid'):: uuid
								, v_personid
								, (v_educationalert ->> 'actiontype')::character varying
								, (v_educationalert ->> 'reasoncode')::character varying
								, (v_educationalert ->> 'startdate')::timestamp
								, (v_educationalert ->> 'enddate')::timestamp
								, (v_educationalert ->> 'endreason')::character varying
								, (v_educationalert ->> 'notes')::character varying
								, 1
								, v_securityuserid::character varying
								, now()
								, v_securityuserid::character varying
								, now()
						);

					END IF;

			END LOOP;


			
		END IF;




	END LOOP;

	-- Delete Person education testing --
--	UPDATE  personeducationtesting et 
--	SET activeflag = 0 
--	WHERE et.personid = v_personid;   

	FOR  v_educationtesting  IN  SELECT  *  FROM    json_array_elements(v_educationtestingjson)  LOOP
	
		IF (v_educationtesting  ->> 'personeducationtestingid') IS NULL THEN
		
			INSERT INTO personeducationtesting (
			    personid, 
			    testingtypekey, 
			    readinglevel, 
				readingtestdate,
				testingprovider,				
			    insertedby, 
			    insertedon
			    ) 
			values(
			    v_personid,
				v_educationtesting  ->> 'testingtypekey',
			    (v_educationtesting  ->> 'readinglevel')::int4,
			    (v_educationtesting  ->> 'readingtestdate')::timestamp,
				v_educationtesting  ->> 'testingprovider',
			    v_securityuserid, 
			    now()	
			    );		
					
		ELSE
		
			UPDATE  personeducationtesting et 
			SET 			
				activeflag = 1,
				testingtypekey = v_educationtesting  ->> 'testingtypekey',
			    readinglevel = (v_educationtesting  ->> 'readinglevel')::int4,
			    readingtestdate = (v_educationtesting  ->> 'readingtestdate')::timestamp,
				testingprovider = v_educationtesting  ->> 'testingprovider',				
				updatedby = v_securityuserid,
				updatedon = now()			
			WHERE et.personeducationtestingid = (v_educationtesting  ->> 'personeducationtestingid') :: uuid;		
		
		END IF;
	
	END LOOP;

	-- Delete Person education accomplishment --
--	UPDATE  personaccomplishment ea 
--	SET activeflag = 0 
--	WHERE ea.personid = v_personid;   

	FOR  v_educationaccomplishment  IN  SELECT  *  FROM    json_array_elements(v_educationaccomplishmentjson)  LOOP
	
		IF (v_educationaccomplishment  ->> 'personaccomplishmentid') IS NULL THEN
		
			INSERT INTO personaccomplishment (
			    personid, 
			    highestgradetypekey, 
			    accomplishmentdate, 
				isrecordreceived,
				receiveddate,				
			    insertedby, 
			    insertedon
			    ) 
			values(
			    v_personid,
				v_educationaccomplishment  ->> 'highestgradetypekey',
			    (v_educationaccomplishment  ->> 'accomplishmentdate')::timestamp,
			    (v_educationaccomplishment  ->> 'isrecordreceived')::bool,
				(v_educationaccomplishment  ->> 'receiveddate')::timestamp,
			    v_securityuserid, 
			    now()
			    );		
					
		ELSE
		
			UPDATE  personaccomplishment ea 
			SET 			
				activeflag = 1,
				highestgradetypekey = v_educationaccomplishment  ->> 'highestgradetypekey',
			    accomplishmentdate = (v_educationaccomplishment  ->> 'accomplishmentdate')::timestamp,
			    isrecordreceived = (v_educationaccomplishment  ->> 'isrecordreceived')::bool,
				receiveddate = (v_educationaccomplishment  ->> 'receiveddate')::timestamp,				
				updatedby = v_securityuserid,
				updatedon = now()			
			WHERE ea.personaccomplishmentid = (v_educationaccomplishment  ->> 'personaccomplishmentid') :: uuid;		
		
		END IF;
	
	END LOOP;

RETURN QUERY

	SELECT p.personid AS "Pid", 
	(SELECT json_agg(pe) FROM 
		(
		SELECT 
			e.personeducationid, e.personid, e.educationname, e.educationtypekey, e.schoolsettingtypekey, e.transportmodetypekey, 
			e.transportmodetypedetail,e.schooladdress1,e.schooladdress2, e.schoolzipcode, e.adrcityname, e.adresscounty, e.statecode, e.startdate, e.enddate, 
			e.contactname, e.adrworkphone, e.adrworkxtn, e.schoolschedule, e.schooladjustment, e.isspecialeducation, 
			e.specialeducationtypekey, e.lastiepdate, e.lastifspdate, e.ifsplastdate, e.enrollmentdate, e.numberofabsences, e.isreceived, e.isverified, 
			e.isexcuesed, e.extracurricular, e.bestdetermination,e.nonewenrollment,
			e.firstqtrabsence, e.firstqtrabsenceexcused, e.firstqtrabsencenotexcused, e.firstqtrabsencetardy, 
			e.secondqtrabsence, e.secondqtrabsenceexcused, e.secondqtrabsencenotexcused, e.secondqtrabsencetardy, 
			e.thirdqtrabsence, e.thirdqtrabsenceexcused, e.thirdqtrabsencenotexcused, e.thirdqtrabsencetardy, 
			e.fourthqtrabsence, e.fourthqtrabsenceexcused, e.fourthqtrabsencenotexcused, e.fourthqtrabsencetardy, 
			e.summerschoolname, e.highestgradetypekey,e.schoolenrolltypekey, e.currentgradetypekey, e.lastgradetypekey,
			e.classtypetypekey, e.currentgradelevel, e.functioninggradelevel, e.lastgradelevel, 
			e.firstqtrperformancetypekey, e.secondqtrperformancetypekey, e.thirdqtrperformancetypekey, e.fourthqtrperformancetypekey, 
			e.speacialeducationrestrictivekey, e.lastattendeddate, e.schoolexitcomments, e.schoolchangereason, e.disciplinaryactioncomments
			,e.sasidno
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
	WHERE p.personid = v_personid AND p.activeflag=1;


END;

 
$function$
;
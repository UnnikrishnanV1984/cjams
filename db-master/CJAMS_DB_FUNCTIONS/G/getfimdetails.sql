DROP FUNCTION IF EXISTS  getfimdetails( uuid, integer,  integer);
DROP FUNCTION IF EXISTS  getfimdetails( uuid, integer,  integer, character varying, integer);
DROP FUNCTION IF EXISTS  getfimdetails( uuid, integer,  integer, character varying, integer, integer);
DROP FUNCTION IF EXISTS  getfimdetails( uuid, integer,  integer, integer, integer);

CREATE OR REPLACE FUNCTION cjams.getfimdetails(l_intakeserviceid uuid, l_page integer, l_limit integer, 
isExpungementSuperUser integer DEFAULT 0, isexpunged integer DEFAULT 0::integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-- 06/22/2023 Manasa Kasula Fix to fetch insertedby for the meetings upload
-- 05/08/2024 Yogeshvar Senthilkumar - Add totalcount for pagination support
-- 11/17/2025 -Umasanakar raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases

DECLARE

v_fimdetails json;
_offset  integer;
v_isexpunged integer := 1;

BEGIN 

_offset := (l_page - 1) * l_limit;  

v_isexpunged = 0;
IF isExpungementSuperUser= 1 THEN
	v_isexpunged = isexpunged;
END IF;
RAISE NOTICE 'isExpungementSuperUser=%, v_isexpunged=%', isExpungementSuperUser, v_isexpunged;


    IF v_isexpunged = 1 THEN
	    RAISE NOTICE 'BLOCK: FULLY EXPUNGED';


        --------------------------------------------------------------------
        -- FULLY EXPUNGED (expunge.intakeservicerequestactor_expunge only)
        --------------------------------------------------------------------

		SELECT Json_agg(fim) into v_fimdetails from 
		(SELECT MR.intakeserviceid, 
		       MR.meetingdate, 
		       MR.meetingtypekey, 
		        MT.typedescription as meetingtype,
		       MR.persontype, 
		       MR.personname, 
		       MR.meetingdescription, 
		       MR.meetingcomments, 
		       MR.isfollowupmeeting, 
		       MR.parentmeetingid, 
		       MR.iscompleted,
			   (case when MR.uploadedfile is null then jsonb(json_build_object ('data',(SELECT json_agg(docs) FROM  (
				SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, dp.other,
				(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), 
				dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
				(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
				SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
				(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
				WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
				) x),
				dp.uploadstatus, 
				dp.finalstatus, 
				dp.ecmsdocumentid
				from documentproperties dp where dp.additionalobjectid = MR.meetingrecordingid::varchar and dp.additionalobjecttype = 'meetingrecording' and dp.activeflag in (1,3,4,5)
				)docs)))::json else MR.uploadedfile::json end) as uploadedfile, 
		       MR.ismeetingdecision,
			   MR.followupdate,
			   MR.meetingdecision,
			   MR.meetingrecordingid,
		       (SELECT Json_agg(actor) 
			FROM  (SELECT mra.meetingrecordingid, 
				      mra.personid,
				      p.firstname,
				      p.lastname,
				      isra.actorid,
				      at.actortype,
				      at.typedescription 
			       FROM   meetingrecordingactor mra inner join person p on p.personid = mra.personid
			       inner join expunge.intakeservicerequestactor_expunge isra on  isra.intakeservicerequestactorid = mra.intakeservicerequestactorid
			       inner join actortype at on at.actortype = isra.intakeservicerequestpersontypekey
			       WHERE  mra.meetingrecordingid = MR.meetingrecordingid 
				      AND mra.activeflag = 1)actor) :: json AS recordingactor, 
		       (SELECT Json_agg(participant) 
			FROM  (SELECT participanttype, 
				      participantkey, 
				      participantroledesc, 
				      firstname, 
				      lastname, 
				      emailid, 
				      personid, 
				      isinvited, 
				      isattended, 
				      isaccpted,
                      electronicsignature 
			       FROM   meetingparticipants 
			       WHERE  meetingrecordingid = MR.meetingrecordingid 
				      AND activeflag = 1)participant) :: json AS participants,
					  	(SELECT json_agg(hearingdetail) FROM 
			(SELECT
			
				*
				
			FROM meetingrecordinghearingdetail mpd


			 WHERE mpd.meetingrecordingid = MR.meetingrecordingid  and mpd.activeflag = 1 )hearingdetail
		) :: json AS hearingdetail,  
		       (SELECT Json_agg(fimtype) 
			FROM  (SELECT familymeetingtypekey, 
				      familymeetingsubtypekey 
			       FROM   meetingfimdetails 
			       WHERE  meetingrecordingid = MR.meetingrecordingid 
				      AND activeflag = 1)fimtype) :: json AS fimdetails,
					  count(1) over() as totalcount
				    
		FROM   meetingrecording MR 
		left join meetingtype MT on MR.meetingtypekey=MT.meetingtypekey
		where MR.intakeserviceid = l_intakeserviceid 
		LIMIT l_limit OFFSET _offset) fim ;

    ELSIF v_isexpunged = 2 THEN
	    RAISE NOTICE 'BLOCK: PARTIALLY EXPUNGED';


        --------------------------------------------------------------------
        -- PARTIALLY EXPUNGED (UNION normal + encr for intakeservicerequestactor)
        --------------------------------------------------------------------

		SELECT Json_agg(fim) into v_fimdetails from 
		(SELECT MR.intakeserviceid, 
		       MR.meetingdate, 
		       MR.meetingtypekey, 
		        MT.typedescription as meetingtype,
		       MR.persontype, 
		       MR.personname, 
		       MR.meetingdescription, 
		       MR.meetingcomments, 
		       MR.isfollowupmeeting, 
		       MR.parentmeetingid, 
		       MR.iscompleted,
			   (case when MR.uploadedfile is null then jsonb(json_build_object ('data',(SELECT json_agg(docs) FROM  (
				SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, dp.other,
				(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), 
				dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
				(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
				SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
				(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
				WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
				) x),
				dp.uploadstatus, 
				dp.finalstatus, 
				dp.ecmsdocumentid
				from documentproperties dp where dp.additionalobjectid = MR.meetingrecordingid::varchar and dp.additionalobjecttype = 'meetingrecording' and dp.activeflag in (1,3,4,5)
				)docs)))::json else MR.uploadedfile::json end) as uploadedfile, 
		       MR.ismeetingdecision,
			   MR.followupdate,
			   MR.meetingdecision,
			   MR.meetingrecordingid,
		       (SELECT Json_agg(actor) 
			FROM  (SELECT mra.meetingrecordingid, 
				      mra.personid,
				      p.firstname,
				      p.lastname,
				      isra.actorid,
				      at.actortype,
				      at.typedescription 
			       FROM   meetingrecordingactor mra inner join person p on p.personid = mra.personid
			       inner join (
						SELECT intakeservicerequestactorid,
						       intakeservicerequestpersontypekey,
						       actorid
						FROM   intakeservicerequestactor
						UNION ALL
						SELECT intakeservicerequestactorid,
						       intakeservicerequestpersontypekey,
						       actorid
						FROM   expunge.intakeservicerequestactor_expunge
			       ) isra on  isra.intakeservicerequestactorid = mra.intakeservicerequestactorid
			       inner join actortype at on at.actortype = isra.intakeservicerequestpersontypekey
			       WHERE  mra.meetingrecordingid = MR.meetingrecordingid 
				      AND mra.activeflag = 1)actor) :: json AS recordingactor, 
		       (SELECT Json_agg(participant) 
			FROM  (SELECT participanttype, 
				      participantkey, 
				      participantroledesc, 
				      firstname, 
				      lastname, 
				      emailid, 
				      personid, 
				      isinvited, 
				      isattended, 
				      isaccpted,
                      electronicsignature 
			       FROM   meetingparticipants 
			       WHERE  meetingrecordingid = MR.meetingrecordingid 
				      AND activeflag = 1)participant) :: json AS participants,
					  	(SELECT json_agg(hearingdetail) FROM 
			(SELECT
			
				*
				
			FROM meetingrecordinghearingdetail mpd


			 WHERE mpd.meetingrecordingid = MR.meetingrecordingid  and mpd.activeflag = 1 )hearingdetail
		) :: json AS hearingdetail,  
		       (SELECT Json_agg(fimtype) 
			FROM  (SELECT familymeetingtypekey, 
				      familymeetingsubtypekey 
			       FROM   meetingfimdetails 
			       WHERE  meetingrecordingid = MR.meetingrecordingid 
				      AND activeflag = 1)fimtype) :: json AS fimdetails,
					  count(1) over() as totalcount
				    
		FROM   meetingrecording MR 
		left join meetingtype MT on MR.meetingtypekey=MT.meetingtypekey
		where MR.intakeserviceid = l_intakeserviceid 
		LIMIT l_limit OFFSET _offset) fim ;

    ELSE

        --------------------------------------------------------------------
        -- NORMAL (original logic – unchanged body)
        --------------------------------------------------------------------
    RAISE NOTICE 'BLOCK: NORMAL';

		SELECT Json_agg(fim) into v_fimdetails from 
		(SELECT MR.intakeserviceid, 
		       MR.meetingdate, 
		       MR.meetingtypekey, 
		        MT.typedescription as meetingtype,
		       MR.persontype, 
		       MR.personname, 
		       MR.meetingdescription, 
		       MR.meetingcomments, 
		       MR.isfollowupmeeting, 
		       MR.parentmeetingid, 
		       MR.iscompleted,
			   (case when MR.uploadedfile is null then jsonb(json_build_object ('data',(SELECT json_agg(docs) FROM  (
				SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, dp.other,
				(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), 
				dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
				(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
				SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
				(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
				WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
				) x),
				dp.uploadstatus, 
				dp.finalstatus, 
				dp.ecmsdocumentid
				from documentproperties dp where dp.additionalobjectid = MR.meetingrecordingid::varchar and dp.additionalobjecttype = 'meetingrecording' and dp.activeflag in (1,3,4,5)
				)docs)))::json else MR.uploadedfile::json end) as uploadedfile, 
		       MR.ismeetingdecision,
			   MR.followupdate,
			   MR.meetingdecision,
			   MR.meetingrecordingid,
		       (SELECT Json_agg(actor) 
			FROM  (SELECT mra.meetingrecordingid, 
				      mra.personid,
				      p.firstname,
				      p.lastname,
				      isra.actorid,
				      at.actortype,
				      at.typedescription 
			       FROM   meetingrecordingactor mra inner join person p on p.personid = mra.personid
			       inner join intakeservicerequestactor isra on  isra.intakeservicerequestactorid = mra.intakeservicerequestactorid
			       inner join actortype at on at.actortype = isra.intakeservicerequestpersontypekey
			       WHERE  mra.meetingrecordingid = MR.meetingrecordingid 
				      AND mra.activeflag = 1)actor) :: json AS recordingactor, 
		       (SELECT Json_agg(participant) 
			FROM  (SELECT participanttype, 
				      participantkey, 
				      participantroledesc, 
				      firstname, 
				      lastname, 
				      emailid, 
				      personid, 
				      isinvited, 
				      isattended, 
				      isaccpted,
                      electronicsignature 
			       FROM   meetingparticipants 
			       WHERE  meetingrecordingid = MR.meetingrecordingid 
				      AND activeflag = 1)participant) :: json AS participants,
					  	(SELECT json_agg(hearingdetail) FROM 
			(SELECT
			
				*
				
			FROM meetingrecordinghearingdetail mpd


			 WHERE mpd.meetingrecordingid = MR.meetingrecordingid  and mpd.activeflag = 1 )hearingdetail
		) :: json AS hearingdetail,  
		       (SELECT Json_agg(fimtype) 
			FROM  (SELECT familymeetingtypekey, 
				      familymeetingsubtypekey 
			       FROM   meetingfimdetails 
			       WHERE  meetingrecordingid = MR.meetingrecordingid 
				      AND activeflag = 1)fimtype) :: json AS fimdetails,
					  count(1) over() as totalcount
				    
		FROM   meetingrecording MR 
		left join meetingtype MT on MR.meetingtypekey=MT.meetingtypekey
		where MR.intakeserviceid = l_intakeserviceid 
		AND MR.activeflag = 1
		LIMIT l_limit OFFSET _offset) fim ;

    END IF;

RETURN v_fimdetails;
END

$function$
;

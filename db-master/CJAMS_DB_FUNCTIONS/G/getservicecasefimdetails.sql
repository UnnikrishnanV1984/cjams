

DROP FUNCTION IF EXISTS  cjams.getservicecasefimdetails(l_servicecaseid uuid, l_page integer, l_limit integer);

CREATE OR REPLACE FUNCTION cjams.getservicecasefimdetails(l_servicecaseid uuid, l_page integer, l_limit integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-- 06/22/2023 Manasa Kasula Fix to fetch insertedby for the meetings upload
-- 05/08/2024 Yogeshvar Senthilkumar - Add totalcount for pagination support
DECLARE

v_fimdetails json;
_offset  integer;

BEGIN 

_offset := (l_page - 1) * l_limit;  

SELECT Json_agg(fim) INTO v_fimdetails FROM 
	(SELECT 
		MR.meetingrecordingid,
		MR.servicecaseid, 
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
		MR.placementid,
		(case when MR.uploadedfile is null then jsonb(json_build_object ('data',(SELECT json_agg(docs) FROM  (
			SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, dp.other, 
			(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), dp.updatedby, dp.documentdate, 
			dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
			(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
			SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
			(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
			WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
			) x),dp.uploadstatus, dp.finalstatus, dp.ecmsdocumentid 
			from documentproperties dp where dp.additionalobjectid = MR.meetingrecordingid::varchar and dp.additionalobjecttype = 'meetingrecording' and dp.activeflag in (1,3,4,5)
		)docs)))::json else MR.uploadedfile::json end) as uploadedfile, 
		MR.ismeetingdecision,
		MR.followupdate,
		MR.meetingdecision,
		(SELECT json_agg(actor) FROM 
			(SELECT 
				mra.meetingrecordingid, 
				mra.personid,
				p.firstname,
				p.lastname,
				isra.actorid,
				at.actortype,
				at.typedescription 
			 FROM meetingrecordingactor mra 
			 INNER JOIN person p ON p.personid = mra.personid AND p.activeflag=1
			 INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = mra.intakeservicerequestactorid AND isra.activeflag=1
			 INNER JOIN actortype at ON at.actortype = isra.intakeservicerequestpersontypekey AND at.activeflag=1
			 WHERE mra.meetingrecordingid = MR.meetingrecordingid AND mra.activeflag = 1)actor
		) :: json AS recordingactor, 
		(SELECT json_agg(participant) FROM 
			(SELECT 
				participanttype, 
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
			FROM meetingparticipants WHERE meetingrecordingid = MR.meetingrecordingid AND activeflag = 1)participant
		) :: json AS participants, 

		(SELECT json_agg(hearingdetail) FROM 
			(SELECT
			
				*
				
			FROM meetingrecordinghearingdetail mpd
--	left join person p1 on p1.personid =mpd.clientid ::uuid
--			left join Intakeservicerequestcourthearing isrh on isrh.intakeservicerequestcourthearingid =mpd.intakeservicerequestcourthearingid::uuid
--			left join hearingtype pt on   pt.hearingtypekey =trim('"' from (SELECT jsonb_array_elements(isrh.hearingtype):: character varying limit 1))

			 WHERE mpd.meetingrecordingid = MR.meetingrecordingid  and mpd.activeflag = 1 )hearingdetail
		) :: json AS hearingdetail, 
		
		(SELECT json_agg(fimtype) FROM 
			(SELECT 
				familymeetingtypekey, 
				familymeetingsubtypekey 
			FROM meetingfimdetails WHERE meetingrecordingid = MR.meetingrecordingid AND activeflag = 1)fimtype
		) :: json AS fimdetails,
		count(1) over() as totalcount
FROM meetingrecording MR 
left join meetingtype MT on MR.meetingtypekey=MT.meetingtypekey
WHERE MR.activeflag = 1 and (MR.servicecaseid = l_servicecaseid 
     OR MR.intakeserviceid IN (SELECT intakeserviceid FROM intakeservicerequest WHERE servicecaseid = l_servicecaseid AND activeflag =1 ) )
     
LIMIT l_limit OFFSET _offset) fim;

RETURN v_fimdetails;
END

$function$;
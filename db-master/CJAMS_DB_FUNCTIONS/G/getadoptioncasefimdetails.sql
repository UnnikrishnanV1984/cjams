------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Nagendra Prasad Sunku
-- Date Created : 02/17/2023 
-- Stored Procedure to Select AdoptionCase Family Involvement Meeting(CIDM-6108)

-- Revision(s)
-- 06/22/2023 Manasa Kasula Fix to fetch insertedby for the meetings upload
-- 05/08/2024 Yogeshvar Senthilkumar Add totalcount for pagination support
------------------------------------------------------------------------  

DROP FUNCTION IF EXISTS  cjams.getadoptioncasefimdetails(l_adoptioncaseid uuid, l_page integer, l_limit integer);

CREATE OR REPLACE FUNCTION cjams.getadoptioncasefimdetails(l_adoptioncaseid uuid, l_page integer, l_limit integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE

v_fimdetails json;
_offset  integer;

BEGIN 

_offset := (l_page - 1) * l_limit;  

SELECT json_agg(fim) INTO v_fimdetails FROM 
	(SELECT 
		MR.meetingrecordingid,
		MR.adoptioncaseid, 
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
			SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.other,  dp.documenttypekey, dp.insertedon, dp.updatedon,
			(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), dp.updatedby, dp.documentdate, dp.other,
			dp.mime, dp.s3bucketpathname, dp.description,dp.filename,dp.numberofbytes, dp.originalfilename,
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
				aca.personid,
				at.actortype,
				at.typedescription 
			 FROM meetingrecordingactor mra 
			 INNER JOIN person p ON p.personid = mra.personid AND p.activeflag=1
			 INNER JOIN adoptioncaseactor aca ON aca.adoptioncaseactorid = mra.adoptioncaseactorid AND aca.activeflag=1
			 INNER JOIN actortype at ON at.actortype = aca.actortypekey AND at.activeflag=1
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
		(SELECT json_agg(fimtype) FROM 
			(SELECT 
				familymeetingtypekey, 
				familymeetingsubtypekey 
			FROM meetingfimdetails WHERE meetingrecordingid = MR.meetingrecordingid AND activeflag = 1)fimtype
		) :: json AS fimdetails,
		count(1) over() as totalcount
FROM meetingrecording MR 
left join meetingtype MT on MR.meetingtypekey=MT.meetingtypekey
WHERE MR.activeflag = 1 and (MR.adoptioncaseid = l_adoptioncaseid 
     OR MR.adoptioncaseid IN (SELECT adoptioncaseid FROM adoptioncase WHERE adoptioncaseid = l_adoptioncaseid AND activeflag =1 ) )
     
LIMIT l_limit OFFSET _offset) fim;

RETURN v_fimdetails;
END

$function$;

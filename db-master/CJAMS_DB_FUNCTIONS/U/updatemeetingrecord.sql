DROP FUNCTION IF EXISTS  updatemeetingrecord(uuid,v_securityuserid uuid);

CREATE OR REPLACE FUNCTION cjams.updatemeetingrecord(v_meetingrecordid uuid,v_securityuserid uuid)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 

BEGIN

	 UPDATE meetingrecordingactor set activeflag =0 WHERE  meetingrecordingid = v_meetingrecordid;
    UPDATE meetingparticipants set activeflag =0 WHERE  meetingrecordingid = v_meetingrecordid;
    UPDATE meetingfimdetails  set activeflag =0 WHERE  meetingrecordingid = v_meetingrecordid;
    UPDATE meetingrecordinghearingdetail  set activeflag =0,updatedon=now(),updatedby=v_securityuserid WHERE  meetingrecordingid = v_meetingrecordid;

     RETURN 'Success';
END;

$function$
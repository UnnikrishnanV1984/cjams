DROP FUNCTION IF EXISTS cjams.addivecaseclosurereview(suserid character varying, servicecaseid uuid, objecttype text, v_status character varying, dispostionid character varying, clientid character varying, casenumber text);
CREATE OR REPLACE FUNCTION cjams.addivecaseclosurereview(suserid character varying, servicecaseid uuid, objecttype text, v_status character varying, dispostionid character varying, clientid character varying, casenumber text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
 
    DECLARE
        returnStatus text;
		v_usernotificationid uuid;
		v_ivecaseclosurereviewId uuid;
		v_teamid uuid;
		v_date timestamp without time zone;
		v_tousersid RECORD;
    BEGIN
		v_date:= now();

		--  save to ivecaseclosurereview
	    INSERT INTO cjams.ivecaseclosurereview
		(ivecaseclosurereviewId, objectId, objecttype, dispositionId,insertedby,updatedby,insertedon,updatedon,ivereviewstatus,activeFlag)
		VALUES(gen_random_uuid(), servicecaseid, objecttype, NULL, suserid, suserid, v_date, v_date, v_status, 1) RETURNING ivecaseclosurereviewId INTO  v_ivecaseclosurereviewId;
	
	   	--  insert to routing table
	    INSERT INTO cjams.routing
		(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
		VALUES(gen_random_uuid(), 'IVECCR', suserid, NULL, NULL, 'CWCW', 'IVESV', v_ivecaseclosurereviewId, 201, 1, suserid, v_date, suserid, v_date, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

		--  insert to notification table
		-- select * from cjams.send_notification(NULL, suserid, NULL, 'System', NULL, 'Case Closure Review', 'Need Case closure Checklist Review for case #' || casenumber, servicecaseid, false);
		--  INSERT INTO cjams.usernotification
		--  (usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, url, subject, priorityleveltypekey, body, hasattachments, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", teammemberid, isread, attachmentlocation, isexternalentity, ismailsent, mailsentdate, old_id, objecttype, objectcasenumber, entityid, isdeleted, teamtypekey)
		--  VALUES(gen_random_uuid(), suserid, 'System', servicecaseid, 1, NULL, 'Case Closure Review', NULL,'Need Case closure Checklist Review for case #' || casenumber, NULL,'cwadmin', v_date, 'cwadmin', v_date, v_date, NULL, NULL, NULL, false,null, false,false, NULL, NULL, NULL, NULL, NULL, NULL, 'CW') RETURNING "usernotificationid" INTO  v_usernotificationid;
		FOR v_tousersid IN 
			select up.securityusersid from userprofile up 
				inner join teammemberassignment tma on tma.securityusersid = up.securityusersid
   				inner join teammember tm on tm.teammemberid = tma.teammemberid 
			where up.teamtypekey = 'CW' and tm.roletypekey = 'IVESV'
			loop
				INSERT INTO usernotification 
				(	securityusersid,usernotificationtypekey,
					objectid,activeflag,subject,priorityleveltypekey,body,isexternalentity,updatedby,
					updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, teamtypekey, entityid
				)
				VALUES 
				(	v_tousersid.securityusersid, 'System', 
					servicecaseid, 1, 'Need Case Closure Checklist Review for Case #' || casenumber, 'High', 'Case Closure Review', false, suserid,
					v_date, suserid,v_date,v_date,false, objecttype, casenumber, 'CW', v_ivecaseclosurereviewId
				) RETURNING "usernotificationid" INTO  v_usernotificationid;
		
				INSERT INTO usernotificationmap
				(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
					effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
				)
				VALUES 
				(	v_usernotificationid, suserid, v_tousersid.securityusersid, false,
					v_date, 1, suserid,v_date, suserid,v_date
				);
			end loop;
	    returnStatus:= 'Success';
	    RETURN returnStatus;
    END;
$function$
;

DROP FUNCTION if exists cjams.addupdatesafecareplan(v_data json);

CREATE OR REPLACE FUNCTION cjams.addupdatesafecareplan(v_data json)
 RETURNS TABLE(message character varying, success boolean,planid character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vigneshwar Kumar
-- Date Created : 07/13/2022 
-- Stored Procedure to Insert/Update the Safe Care Plan(CIDM-5024)
-- 9/8/2025- Triveni Bala- POSC user story changes
-- Revision(s)
------------------------------------------------------------------------  
DECLARE
	v_safecareplanid uuid;
	v_approvalstatus character varying; 
    v_responsemessage character varying;
   	v_teamid uuid;
	v_auditmessage character varying;   
   
BEGIN 
	v_approvalstatus := (v_data->>'approvalstatus')::character varying;
	v_responsemessage = 'Safe care plan saved successfully';
	v_auditmessage = '';
	select teamid into v_teamid from v_userprofile vu where securityusersid::character varying  = (v_data->>'securityuserid')::character varying ;

	IF ( LENGTH(v_data->>'safecareplanid') > 1 ) THEN 
		-- Update
		v_safecareplanid := (v_data->>'safecareplanid')::uuid ;

		UPDATE cjams.safecareplan
		SET objectid = coalesce((v_data->>'objectid')::character varying, objectid),
			objecttypekey = coalesce((v_data->>'objecttypekey')::character varying, objecttypekey),	
			safecaredate = coalesce((v_data->>'safecaredate')::date, safecaredate),	
			persondetails = coalesce((v_data->>'persondetails')::json, persondetails),	
			planparticipants = coalesce((v_data->>'planparticipants')::json, planparticipants),		
			healthneedsdetails = coalesce((v_data->>'healthneedsdetails')::json, healthneedsdetails),	
			otherservices = coalesce((v_data->>'otherservices')::json, otherservices),	
			planreviewdetails = coalesce((v_data->>'planreviewdetails')::json, planreviewdetails),
			"comments" = coalesce((v_data->>'comments')::character varying, "comments"),	
			justification = coalesce((v_data->>'justification')::character varying, justification),	
			consentform = coalesce((v_data->>'consentform')::json, consentform),	
			recommendedforclosure = coalesce((v_data->>'recommendedforclosure')::boolean, recommendedforclosure),
			insufficientevidencetocourt = coalesce((v_data->>'insufficientevidencetocourt')::boolean, insufficientevidencetocourt),
			familypreservationtransfer = coalesce((v_data->>'familypreservationtransfer')::boolean, familypreservationtransfer),
			referredtocps = coalesce((v_data->>'referredtocps')::boolean, referredtocps),
			shelterorder = coalesce((v_data->>'shelterorder')::boolean, shelterorder),
			signatures = coalesce((v_data->>'signatures')::json, signatures),
			updatedby = (v_data->>'securityuserid')::uuid,
			updatedon = now(),
			approvalstatus  = coalesce((v_data->>'approvalstatus')::character varying, approvalstatus)	
		WHERE safecareplanid = v_safecareplanid;

	ELSE
		-- Insert
		INSERT INTO cjams.safecareplan
			(	objectid,
				objecttypekey,	
				safecaredate,
				persondetails,	
				planparticipants,	
				healthneedsdetails,	
				otherservices,
				planreviewdetails,
				comments,
				justification, 
				consentform,
				recommendedforclosure,
				insufficientevidencetocourt,
				familypreservationtransfer,
				referredtocps,
				shelterorder,
				signatures,
				approvalstatus, 
				updatedby,	
				updatedon,	
				insertedby,	
				insertedon,	
				activeflag
			)
		VALUES
			(	(v_data->>'objectid')::character varying,
				(v_data->>'objecttypekey')::character varying,
				(v_data->>'safecaredate')::date,	
				(v_data->>'persondetails')::json, 
				(v_data->>'planparticipants')::json, 	
				(v_data->>'healthneedsdetails')::json,
				(v_data->>'otherservices')::json, 	
				(v_data->>'planreviewdetails')::json,	
				(v_data->>'comments')::character varying,
				(v_data->>'justification')::character varying,	
				(v_data->>'consentform')::json,	
				(v_data->>'recommendedforclosure')::boolean,
				(v_data->>'insufficientevidencetocourt')::boolean,
				(v_data->>'familypreservationtransfer')::boolean,
				(v_data->>'referredtocps')::boolean,
				(v_data->>'shelterorder')::boolean,
				(v_data->>'signatures')::json,
				(v_data->>'approvalstatus')::character varying, 	
				(v_data->>'securityuserid')::uuid,
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				1
			) RETURNING safecareplanid INTO  v_safecareplanid; 
	
	END IF;

	-- Insert into Routing (Supervisor Approval request)	

	IF btrim(v_approvalstatus) = '15' THEN -- Review
		INSERT INTO cjams.routing
			(	eventcode, 
				fromsecurityusersid, 
				tosecurityusersid, 
				teamid, 
				fromroleid, 
				toroleid, 
				objectid, 
				routingstatustypeid, 
				activeflag, 
				insertedby, 
				insertedon, 
				updatedby, 
				updatedon, 
				isreviewrequest, 
				remarks, 
				old_id, 
				routeddescription, 
				objecttypekey,
				servicerequestnumber
			)
		VALUES
			(	'SENSCP',-- 'CW to SP - Review' 
				(v_data->>'securityuserid')::uuid, 
				(v_data->>'approverid')::uuid,
				v_teamid, 
				'CWIW', 
				'CWSP', 
				v_safecareplanid::character varying,  
				15, -- Review  
				1, 
				(v_data->>'securityuserid')::uuid, 
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				true, 
				'Forwarded to Supervisor', 
				NULL, 
				'Safe Care Plan Review Request',
				'safecareplan',
				(v_data->>'servicerequestnumber')::character varying
			);
			
			v_responsemessage = 'Safe care plan request has been submitted to the supervisor successfully';
			v_auditmessage = 'Submitted for supervisor approval';

	ELSEIF btrim(v_approvalstatus) = '17' THEN -- Rejected 
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_safecareplanid::character varying	
			and activeflag = 1;
			
		INSERT INTO cjams.routing
			(	eventcode, 
				fromsecurityusersid, 
				tosecurityusersid, 
				teamid, 
				fromroleid, 
				toroleid, 
				objectid, 
				routingstatustypeid, 
				activeflag, 
				insertedby, 
				insertedon, 
				updatedby, 
				updatedon, 
				isreviewrequest, 
				remarks, 
				old_id, 
				routeddescription, 
				objecttypekey
			)
		VALUES
			(	'SENSCP', 
				(v_data->>'securityuserid')::uuid, 
				(v_data->>'requestorid')::uuid,
				v_teamid, 
				'CWSP', 
				'CWIW', 
				v_safecareplanid::character varying,  
				17, -- Rejected  
				1, 
				(v_data->>'securityuserid')::uuid, 
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				true, 
				'Forwarded to Caseworker as Rejected', 
				NULL, 
				'Safe Care Plan request has been rejected', 
				'safecareplan'
			);
			
			v_responsemessage = 'Request has been rejected successfully';
			v_auditmessage = 'Supervisor rejected the approval';
		
	ELSEIF btrim(v_approvalstatus) = '16' THEN -- Supervisor Approval & Submit for Finance Worker
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_safecareplanid::character varying	
			and activeflag = 1 ;
			
		INSERT INTO cjams.routing
			(	eventcode, 
				fromsecurityusersid,
				tosecurityusersid, 
				teamid, 
				fromroleid, 
				toroleid, 
				objectid, 
				routingstatustypeid, 
				activeflag, 
				insertedby, 
				insertedon, 
				updatedby, 
				updatedon, 
				isreviewrequest, 
				remarks, 
				old_id, 
				routeddescription, 
				objecttypekey
			)
		VALUES
			(	'SENSCP', 
				(v_data->>'securityuserid')::uuid, 
				(v_data->>'requestorid')::uuid,
				v_teamid, 
				'CWSP', 
				'CWCW', 
				v_safecareplanid::character varying,  
				16, -- Supervisor Approval
				1, 
				(v_data->>'securityuserid')::uuid, 
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				true, 
				'Safe Care Plan Approved', 
				NULL, 
				'Safe Care Plan Request Approved', 
				'safecareplan'
			);
			
			v_responsemessage = 'Safe Care Plan request has been approved successfully';
			v_auditmessage = 'Supervisor approved the approval';
	ELSE
			v_auditmessage = 'Plan of safe care has been saved as draft';
	END IF;


	IF(v_auditmessage != '') THEN
			INSERT INTO safecareplan_history(safecareplanid, safecareplanhistorytype, justification, insertedby, insertedon, updatedby, updatedon)
			VALUES(v_safecareplanid, 'REVISION', v_auditmessage, (v_data->>'securityuserid')::uuid, now(), (v_data->>'securityuserid')::uuid, now());
	END IF;

	RETURN QUERY SELECT v_responsemessage, true, v_safecareplanid::character varying;

	-- Handling exceptions
	EXCEPTION WHEN OTHERS then
	BEGIN
		RAISE NOTICE 'Internal error: %', sqlerrm;
		RETURN QUERY SELECT 'Unable to process add or update safecare plan. Please try again later.'::character varying, false, v_safecareplanid::character varying;  
	END; 

END;
$function$;
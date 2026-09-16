DROP FUNCTION if exists cjams.cpsresponsetimerskipapproval(v_data json);

CREATE OR REPLACE FUNCTION cjams.cpsresponsetimerskipapproval(v_data json)
 RETURNS TABLE(message character varying, success boolean)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Shamili
-- Date Created : 09/27/2022 
------------------------------------------------------------------------  
DECLARE
	v_intakeserviceid uuid;
	v_approvalstatus character varying; 
    v_responsemessage character varying;
	v_caseworkerid uuid;
	
BEGIN 
	v_intakeserviceid := (v_data->>'intakeserviceid')::uuid;
	v_approvalstatus := (v_data->>'approvalstatus')::character varying;

	IF btrim(v_approvalstatus) = '15' THEN -- Review
		INSERT INTO cjams.routing(
			routingid, 
			eventcode, 
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
			routeddescription
		) 	VALUES  (	
			gen_random_uuid(), 
			'CPSRTS', 
			(v_data->>'securityuserid')::uuid, 
			(select supervisorid::uuid  from userprofile u where securityusersid::character varying  = (v_data->>'securityuserid')::character varying and activeflag = 1 limit 1),
			(select teamid from v_userprofile vu where securityusersid::character varying  = (v_data->>'securityuserid')::character varying limit 1), 
			'CWCW', 
			'CWSP', 
			v_intakeserviceid::character varying,  
			15, -- Request for Approval 
			1, 
			(v_data->>'securityuserid')::uuid, 
			now(), 
			(v_data->>'securityuserid')::uuid,
			now(), 
			true, 
			'CPS Response Timer Skip Request to Supervisor', 
			NULL, 
			'CPS Response Timer Skip Request to Supervisor'
        );

		v_responsemessage = 'Request has been submitted to the supervisor successfully';
		
	ELSEIF btrim(v_approvalstatus) = '16' THEN -- Rejected 

    select fromsecurityusersid into v_caseworkerid from routing 
    where objectid = v_intakeserviceid::character varying and eventcode = 'CPSRTS'
	and activeflag = 1 limit 1;

		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_intakeserviceid::character varying and eventcode = 'CPSRTS'
			and activeflag = 1 ;
			
		INSERT INTO cjams.routing(
			routingid, 
			eventcode, 
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
			routeddescription
		) 	VALUES  (	
			gen_random_uuid(), 
			'CPSRTS', 
			(v_data->>'securityuserid')::uuid, 
			v_caseworkerid::uuid,
			(select teamid from v_userprofile vu where securityusersid::character varying  = (v_data->>'securityuserid')::character varying limit 1), 
			'CWSP', 
			'CWCW', 
			v_intakeserviceid::character varying,  
			16, 
			1, 
			(v_data->>'securityuserid')::uuid, 
			now(), 
			(v_data->>'securityuserid')::uuid,
			now(), 
			true, 
			'CPS Response Timer Skip Approved', 
			NULL, 
			'CPS Response Timer Skip Approved'
        );
			
		v_responsemessage = 'Request has been approved successfully';
		
	ELSEIF btrim(v_approvalstatus) = '17' THEN -- Rejection 
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_intakeserviceid::character varying and eventcode = 'CPSRTS'
			and activeflag = 1 ;
			
		INSERT INTO cjams.routing
			(	routingid, 
				eventcode, 
				fromsecurityusersid, 
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
		) 	VALUES  (	
			gen_random_uuid(), 
			'CPSRTS', 
			(v_data->>'securityuserid')::uuid, 
			(v_data->>'requestedby')::uuid,
			(select teamid from v_userprofile vu where securityusersid::character varying  = (v_data->>'securityuserid')::character varying limit 1), 
			'CWSP', 
			'CWCW', 
			v_intakeserviceid::character varying,  
			17, 
			1, 
			(v_data->>'securityuserid')::uuid, 
			now(), 
			(v_data->>'securityuserid')::uuid,
			now(), 
			true, 
			'CPS Response Timer Skip Rejected', 
			NULL, 
			'CPS Response Timer Skip Rejected'
        );
			
		v_responsemessage = 'Request has been rejected successfully';
		
	END IF;
		
	RETURN QUERY SELECT v_responsemessage, false;
	
	-- Handling exceptions
	EXCEPTION WHEN OTHERS then
	BEGIN
		RAISE NOTICE 'Internal error: %', sqlerrm;
		RETURN QUERY SELECT 'Unable to process cps response timers skip approval. Please try again later.'::character varying, false;  
	END; 

END;
$function$
;

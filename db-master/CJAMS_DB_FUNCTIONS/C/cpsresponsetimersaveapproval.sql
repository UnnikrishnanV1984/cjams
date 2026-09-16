CREATE OR REPLACE FUNCTION cjams.cpsresponsetimersaveapproval(v_cpsresponsetimeractionsid uuid, v_data json)
 RETURNS TABLE(message character varying, success boolean)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vigneshwar Kumar
-- Date Created : 10/03/2022 

-- Revision(s)
-- 10/05/2022 - Vineet Tirodkar - To update supervisor comments upon Approval (CIDM-5447/B-144171)
-- 10/27/2022 - Vineet Tirodkar - To delete all prior pending approvals upon most recent approval/rejection (CDM-25925)
------------------------------------------------------------------------  
DECLARE
	v_approvalstatus character varying; 
    v_responsemessage character varying;
	v_caseworkerid uuid;
	v_supervisorid uuid;
	v_intakeserviceid uuid;
	v_servicerequestnumber character varying;

BEGIN 
	v_approvalstatus := (v_data->>'approvalstatus')::character varying;
	v_supervisorid := (v_data->>'supervisorid')::uuid;
	
	select isr.servicerequestnumber ,
			c.intakeserviceid
		into v_servicerequestnumber,
			v_intakeserviceid
	from cpsresponsetimeractions c,
		intakeservicerequest isr 
	where c.intakeserviceid = isr.intakeserviceid 
		and c.cpsresponsetimeractionsid =  v_cpsresponsetimeractionsid
		and c.activeflag = 1
		and isr.activeflag = 1 ;


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
			routeddescription,
			servicerequestnumber
		) 	VALUES  (	
			gen_random_uuid(), 
			'CPSRTSV', 
			(v_data->>'securityuserid')::uuid, 
			v_supervisorid,
			(select teamid from v_userprofile vu where securityusersid::character varying  = (v_data->>'securityuserid')::character varying limit 1), 
			'CWCW', 
			'CWSP', 
			v_cpsresponsetimeractionsid::character varying,  
			15, -- Request for Approval 
			1, 
			(v_data->>'securityuserid')::uuid, 
			now(), 
			(v_data->>'securityuserid')::uuid,
			now(), 
			true, 
			'CPS Response Timer Save Request to Supervisor', 
			NULL, 
			'CPS Response Timer Save Request to Supervisor',
			v_servicerequestnumber
        );

		v_responsemessage = 'Request has been submitted to the supervisor successfully';
		
	ELSEIF btrim(v_approvalstatus) = '16' THEN -- Approval

		select fromsecurityusersid 
			into v_caseworkerid 
		from routing 
		where objectid = v_cpsresponsetimeractionsid::character varying 
			and eventcode = 'CPSRTSV'
			and activeflag = 1 limit 1;

		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_cpsresponsetimeractionsid::character varying 
			and eventcode = 'CPSRTSV'
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
			routeddescription,
			servicerequestnumber
		) 	VALUES  (	
			gen_random_uuid(), 
			'CPSRTSV', 
			(v_data->>'securityuserid')::uuid, 
			v_caseworkerid::uuid,
			(select teamid from v_userprofile vu where securityusersid::character varying  = (v_data->>'securityuserid')::character varying limit 1), 
			'CWSP', 
			'CWCW', 
			v_cpsresponsetimeractionsid::character varying,  
			16, 
			1, 
			(v_data->>'securityuserid')::uuid, 
			now(), 
			(v_data->>'securityuserid')::uuid,
			now(), 
			true, 
			'CPS Response Timer Save Approved', 
			NULL, 
			'CPS Response Timer Save Approved',
			v_servicerequestnumber
        );
			
		update cjams.cpsresponsetimeractions
		set supervisorcomments = (v_data->>'supervisorcomments')::character varying,
			updatedby = (v_data->>'securityuserid')::uuid,
			updatedon = now()
		where cpsresponsetimeractionsid = v_cpsresponsetimeractionsid ;
		
		v_responsemessage = 'Request has been approved successfully';
		
	ELSEIF btrim(v_approvalstatus) = '17' THEN -- Rejection 
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_cpsresponsetimeractionsid::character varying 
			and eventcode = 'CPSRTSV'
			and activeflag = 1 ;
			
		INSERT INTO cjams.routing
			(	routingid, 
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
				routeddescription, 
				servicerequestnumber
		) 	VALUES  (	
			gen_random_uuid(), 
			'CPSRTSV', 
			(v_data->>'securityuserid')::uuid, 
			v_caseworkerid::uuid,
			(select teamid from v_userprofile vu where securityusersid::character varying  = (v_data->>'securityuserid')::character varying limit 1), 
			'CWSP', 
			'CWCW', 
			v_cpsresponsetimeractionsid::character varying,  
			17, 
			1, 
			(v_data->>'securityuserid')::uuid, 
			now(), 
			(v_data->>'securityuserid')::uuid,
			now(), 
			true, 
			'CPS Response Timer Save Rejected', 
			NULL, 
			'CPS Response Timer Save Rejected',
			v_servicerequestnumber
        );
		
		update cjams.cpsresponsetimeractions
		set supervisorcomments = (v_data->>'supervisorcomments')::character varying,
			updatedby = (v_data->>'securityuserid')::uuid,
			updatedon = now()
		where cpsresponsetimeractionsid = v_cpsresponsetimeractionsid ;
			
		v_responsemessage = 'Request has been rejected successfully';
		
	END IF;
	
	-- CDM-25925
	IF btrim(v_approvalstatus) = '16' or btrim(v_approvalstatus) = '17' THEN -- Approval/Rejection  
		-- CPSRTS - CPS Response Timer Skip Request to Supervisor
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_intakeserviceid::character varying 
			and eventcode = 'CPSRTS'
			and routingstatustypeid = '15' -- Pending
			and activeflag = 1 ;
		
		-- CPSRTSV - CPS Response Timer Save Request to Supervisor
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where servicerequestnumber = v_servicerequestnumber
			and objectid <> v_cpsresponsetimeractionsid::character varying 
			and eventcode = 'CPSRTSV'
			and routingstatustypeid = '15' -- Pending
			and activeflag = 1 ;
	END IF;
	
	RETURN QUERY SELECT v_responsemessage, false;
	
	-- Handling exceptions
	EXCEPTION WHEN OTHERS then
	BEGIN
		RAISE NOTICE 'Internal error: %', sqlerrm;
		RETURN QUERY SELECT 'Unable to process cps response timer save approval. Please try again later.'::character varying, false;  
	END; 

END;
$function$
;

DROP FUNCTION if exists cjams.addupdateancillaryservices(v_data json);

CREATE OR REPLACE FUNCTION cjams.addupdateancillaryservices(v_data json)
  RETURNS TABLE(message character varying, success boolean, paymentid text)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vigneshwar Kumar
-- Date Created : 04/14/2022 
-- Stored Procedure to Insert/Update the Ancillary Payments(CIDM-4406)

-- Revision(s)
------------------------------------------------------------------------  
DECLARE
	v_ancillaryservicesid uuid;
	v_approvalstatus character varying; 
    v_alternateid integer;
    v_responsemessage character varying;
    v_teamid uuid;
	v_paymentid text;
	v_paymentstatus boolean;
BEGIN 
	v_approvalstatus := (v_data->>'approvalstatus')::character varying ;
	v_paymentstatus := true;

	select teamid into v_teamid from v_userprofile vu where securityusersid::character varying  = (v_data->>'securityuserid')::character varying ;

	IF ( LENGTH(v_data->>'ancillaryservicesid') > 1 ) THEN 
		-- Update
		v_ancillaryservicesid := (v_data->>'ancillaryservicesid')::uuid ;

		UPDATE cjams.ancillaryservices
		SET paymenttype	= coalesce((v_data->>'paymenttype')::character varying, paymenttype),
			providerserviceid = coalesce((v_data->>'providerserviceid')::integer, providerserviceid),	
			startdate = coalesce((v_data->>'startdate')::date, startdate),	
			enddate	= coalesce((v_data->>'enddate')::date, enddate),	
			noofbeds = coalesce((v_data->>'noofbeds')::integer, noofbeds),		
			costnotexceed = coalesce((v_data->>'costnotexceed')::numeric, costnotexceed),	
			"comments" = coalesce((v_data->>'comments')::character varying, "comments"),	
			finalamount	= coalesce((v_data->>'finalamount')::numeric, "finalamount"),	
			supervisorapprovalstatuscode = coalesce((v_data->>'supervisorapprovalstatuscode')::character varying, supervisorapprovalstatuscode),	
			paymentapprovalstatuscode = coalesce((v_data->>'paymentapprovalstatuscode')::character varying, paymentapprovalstatuscode),	
			supervisorapprovaldate = coalesce((v_data->>'supervisorapprovaldate')::timestamp, supervisorapprovaldate),		
			paymentapprovaldate = coalesce((v_data->>'paymentapprovaldate')::timestamp, paymentapprovaldate),	
			updatedby = (v_data->>'securityuserid')::uuid,
			updatedon = now(),
			statecountycode = coalesce((v_data->>'statecountycode')::character varying , statecountycode)
		WHERE ancillaryservicesid = v_ancillaryservicesid ;
	
	ELSE
		-- Insert
		raise notice 'variable %',(v_data->>'securityuserid'); 
		INSERT INTO cjams.ancillaryservices
			(	ancillaryservicesid,	
				paymenttype,
				providerserviceid,	
				startdate,
				enddate,	
				noofbeds,	
				costnotexceed,	
				"comments",	
				finalamount,	
				financecategorycode,	
				updatedby,	
				updatedon,	
				insertedby,	
				insertedon,	
				activeflag,
				statecountycode	
			)
		VALUES
			(	gen_random_uuid(), 
				(v_data->>'paymenttype')::character varying,
				(v_data->>'providerserviceid')::integer,
				(v_data->>'startdate')::date,
				(v_data->>'enddate')::date,
				(v_data->>'noofbeds')::integer,
				(v_data->>'costnotexceed')::numeric,
				(v_data->>'comments')::character varying,
				(v_data->>'finalamount')::numeric,
				(v_data->>'financecategorycode')::character varying,
				(v_data->>'securityuserid')::uuid,
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				1,
				(select statecountycode from v_userprofile where securityusersid = (v_data->>'securityuserid')::character varying)
			) RETURNING ancillaryservicesid INTO  v_ancillaryservicesid; 
	
	END IF;

	-- Insert into Routing (Supervisor Approval request)	

	IF btrim(v_approvalstatus) = '110' THEN -- Review
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
			(	'ANCSU',-- 'CW to SP - Review' 
				(v_data->>'securityuserid')::uuid, 
				(v_data->>'approvedby')::uuid,
				v_teamid, 
				'CWIW', 
				'CWSP', 
				v_ancillaryservicesid::character varying,  
				110, -- Review  
				1, 
				(v_data->>'securityuserid')::uuid, 
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				true, 
				'Forwarded to Supervisor', 
				NULL, 
				'Ancillary Service Payment Review Request',
				'Ancillaryservices'
			);
			
			raise notice 'variable %',v_ancillaryservicesid;
			v_responsemessage = 'Request has been submitted to the supervisor successfully';
		
	ELSEIF btrim(v_approvalstatus) = '62' THEN -- Rejected 
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_ancillaryservicesid::character varying	
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
				objecttypekey
			)
		VALUES
			(	gen_random_uuid(), 
				'ANCSU', 
				(v_data->>'securityuserid')::uuid, 
				(v_data->>'approvedby')::uuid,
				v_teamid, 
				(select roletypekey from v_userprofile vu where securityusersid =  (v_data->>'securityuserid')::varchar), 
				(select roletypekey from v_userprofile vu where securityusersid =  (v_data->>'approvedby')::varchar), 
				v_ancillaryservicesid::character varying,  
				62, -- Rejected  
				1, 
				(v_data->>'securityuserid')::uuid, 
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				true, 
				'Forwarded to Supervisor', 
				NULL, 
				'Ancillary Service Payment Request Rejected', 
				'Ancillaryservices'
			);
			
			v_responsemessage = 'Request has been rejected successfully';
		
	ELSEIF btrim(v_approvalstatus) = '111' THEN -- Supervisor Approval & Submit for Finance Worker
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'approvedby')::uuid, 
			updatedon = now()
		where objectid = v_ancillaryservicesid::character varying	
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
			)
		VALUES
			(	gen_random_uuid(), 
				'ANCSFR', 
				(v_data->>'securityuserid')::uuid, 
				v_teamid, 
				'CWSP', 
				'FNSFS', 
				v_ancillaryservicesid::character varying,  
				111, -- Supervisor Approval & Submit for Finance Supervisor  
				1, 
				(v_data->>'securityuserid')::uuid, 
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				true, 
				'Forwarded to Finance Worker', 
				NULL, 
				'Ancillary Services Payment Request to Finance Worker', 
				'Ancillaryservices'
			);
			
			v_responsemessage = 'Request has been submitted to the Finance Worker successfully';
		
	ELSEIF btrim(v_approvalstatus) = '112' THEN -- Finance worker to Finance supervisor
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_ancillaryservicesid::character varying	
			and activeflag = 1;
			
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
			)
		VALUES
			(	gen_random_uuid(), 
				'ANCSR', 
				(v_data->>'securityuserid')::uuid, 
				v_teamid, 
				'FNSFW', 
				'FNSFS', 
				v_ancillaryservicesid::character varying,  
				112, -- Finance Worker to Finance Supervisor  
				1, 
				(v_data->>'securityuserid')::uuid, 
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				true, 
				'Forwarded to Finance Worker', 
				NULL, 
				'Ancillary Services Funding Request to Finance Worker', 
				'Ancillaryservices'
			);
			
			v_responsemessage = 'Request has been submitted to the Finance Worker successfully';


	ELSEIF btrim(v_approvalstatus) = '113' THEN -- Finance Worker Approval
		update routing
		set activeflag = 0,
			updatedby = (v_data->>'securityuserid')::uuid, 
			updatedon = now()
		where objectid = v_ancillaryservicesid::character varying	
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
				objecttypekey
			)
		VALUES
			(	gen_random_uuid(), 
				'ANCSU', 
				(v_data->>'securityuserid')::uuid, 
				(v_data->>'approvedby')::uuid,
				v_teamid, 
				'FNSFS', 
				'FNSFW', 
				v_ancillaryservicesid::character varying,  
				113, -- Finance Supervisor Approval  
				1, 
				(v_data->>'securityuserid')::uuid, 
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				true, 
				'Ancillary Services Payment Request Approved', 
				NULL, 
				'Ancillary Services Payment Request Approved', 
				'Ancillaryservices'
			);
		
			SELECT a.paymentid as pay_id, a.success INTO v_paymentid, v_paymentstatus FROM cjams.sp_fin_ancillary_payments((v_data->>'purchaserequest')::json) a; 

			IF v_paymentstatus = true THEN
				UPDATE cjams.ancillaryservices 
				SET purchasedetails = (v_data->>'purchaserequest')::json, paymentid = v_paymentid, updatedon = now(),
				updatedby = (v_data->>'securityuserid')::uuid 
				WHERE ancillaryservicesid = v_ancillaryservicesid;
				
				v_responsemessage = 'Payment request has been approved successfully';
			ELSE 
				v_responsemessage = 'Error in processing the payment approval. Please try again later';
			END IF;
	END IF;

	IF v_paymentstatus = true THEN
		RETURN QUERY SELECT v_responsemessage, true, v_paymentid;
	ELSE 
		RETURN QUERY SELECT v_responsemessage, false, v_paymentid;
	END IF;

	-- Handling exceptions
	EXCEPTION WHEN OTHERS then
	BEGIN
		RAISE NOTICE 'Internal error: %', sqlerrm;
		RETURN QUERY SELECT 'Unable to process add or update ancillary services. Please try again later.'::character varying, false, v_paymentid;  
	END; 

END;
$function$;
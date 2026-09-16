CREATE OR REPLACE FUNCTION cjams.addupdatecpsresponsetimeractions(v_data json)
 RETURNS TABLE(message character varying, success boolean)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Shamili
-- Date Created : 08/31/2022 
-- Stored Procedure to Insert/Update the CPS Response timer actions

-- Revision(s)
-- 10/03/2022 - Vineet Tirodkar - To update new column caseworker comments (CIDM-5447/B-144171)
------------------------------------------------------------------------  
DECLARE
	v_cpsresponsetimeractionsid uuid;
	v_responsemessage character varying; 
	v_approvalmsg character varying;
	v_approvalsts boolean;
   	
BEGIN 
	v_responsemessage = 'CPS response timer actions saved successfully';

	IF ( LENGTH(v_data->>'cpsresponsetimeractionsid') > 1 ) THEN 
		-- Update
		v_cpsresponsetimeractionsid := (v_data->>'cpsresponsetimeractionsid')::uuid ;

		UPDATE cjams.cpsresponsetimeractions
		SET cpsresponsetimeractiontype = coalesce((v_data->>'cpsresponsetimeractiontype')::character varying, cpsresponsetimeractiontype),
			allegedvictimcontact = coalesce((v_data->>'allegedvictimcontact')::character varying, allegedvictimcontact),	
			otherchildrencontact = coalesce((v_data->>'otherchildrencontact')::character varying, otherchildrencontact),	
			initialcaregivercontact = coalesce((v_data->>'initialcaregivercontact')::character varying, initialcaregivercontact),
			cpsresponsetimerreason1 = coalesce((v_data->>'cpsresponsetimerreason1')::character varying, cpsresponsetimerreason1),
			cpsresponsetimerreason2 = coalesce((v_data->>'cpsresponsetimerreason2')::character varying, cpsresponsetimerreason2),
			cpsresponsetimerreason3 = coalesce((v_data->>'cpsresponsetimerreason3')::character varying, cpsresponsetimerreason3),
			cpsresponsetimerreason4 = coalesce((v_data->>'cpsresponsetimerreason4')::character varying, cpsresponsetimerreason4),
			cpsresponsetimerreason5 = coalesce((v_data->>'cpsresponsetimerreason5')::character varying, cpsresponsetimerreason5),
			cpsresponsetimerreason6 = coalesce((v_data->>'cpsresponsetimerreason6')::character varying, cpsresponsetimerreason6),
			cpsresponsetimerreason7 = coalesce((v_data->>'cpsresponsetimerreason7')::character varying, cpsresponsetimerreason7),
			cpsresponsetimerreason8 = coalesce((v_data->>'cpsresponsetimerreason8')::character varying, cpsresponsetimerreason8),
			cpsresponsetimerreason9 = coalesce((v_data->>'cpsresponsetimerreason9')::character varying, cpsresponsetimerreason9),
			reason = coalesce((v_data->>'reason')::character varying, reason),
			isskipped = coalesce((v_data->>'isskipped')::boolean, isskipped),	
			updatedby = (v_data->>'securityuserid')::uuid,
			updatedon = now(),
			caseworkercomments = coalesce((v_data->>'caseworkercomments')::character varying, caseworkercomments)
		WHERE cpsresponsetimeractionsid = v_cpsresponsetimeractionsid;

	ELSE
		-- Insert
		INSERT INTO cjams.cpsresponsetimeractions
			(	cpsresponsetimeractiontype,
				intakeserviceid,
				allegedvictimcontact,
				otherchildrencontact,
				initialcaregivercontact,
				cpsresponsetimerreason1,
				cpsresponsetimerreason2,
				cpsresponsetimerreason3,
				cpsresponsetimerreason4,
				cpsresponsetimerreason5,
				cpsresponsetimerreason6,
				cpsresponsetimerreason7,
				cpsresponsetimerreason8,
				cpsresponsetimerreason9,
				isskipped,
				updatedby,	
				updatedon,	
				insertedby,	
				insertedon,	
				activeflag,
				caseworkercomments,
				reason
			)
		VALUES
			(	(v_data->>'cpsresponsetimeractiontype')::character varying,
				(v_data->>'intakeserviceid')::uuid,
				(v_data->>'allegedvictimcontact')::character varying,
				(v_data->>'otherchildrencontact')::character varying,
				(v_data->>'initialcaregivercontact')::character varying,
				(v_data->>'cpsresponsetimerreason1')::character varying,
				(v_data->>'cpsresponsetimerreason2')::character varying,
				(v_data->>'cpsresponsetimerreason3')::character varying,
				(v_data->>'cpsresponsetimerreason4')::character varying,
				(v_data->>'cpsresponsetimerreason5')::character varying,
				(v_data->>'cpsresponsetimerreason6')::character varying,
				(v_data->>'cpsresponsetimerreason7')::character varying,
				(v_data->>'cpsresponsetimerreason8')::character varying,
				(v_data->>'cpsresponsetimerreason9')::character varying,
				(v_data->>'isskipped')::boolean,
				(v_data->>'securityuserid')::uuid,
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				1,
				(v_data->>'caseworkercomments')::character varying,
				(v_data->>'reason')::character varying
			) RETURNING cpsresponsetimeractionsid INTO  v_cpsresponsetimeractionsid; 
	
	
		IF lower((v_data->>'cpsresponsetimeractiontype')::character varying) = 'save' THEN
			select a.message, a.success into v_approvalmsg, v_approvalsts
				from cjams.cpsresponsetimersaveapproval(v_cpsresponsetimeractionsid, v_data::json) a;
		END IF;
		
	END IF;
	
	RETURN QUERY SELECT v_responsemessage, true;

	-- Handling exceptions
	EXCEPTION WHEN OTHERS then
	BEGIN
		RAISE NOTICE 'Internal error: %', sqlerrm;
		RETURN QUERY SELECT 'Unable to process add or update cps responbse timer actions. Please try again later.'::character varying, false;  
	END; 

END;
$function$
;

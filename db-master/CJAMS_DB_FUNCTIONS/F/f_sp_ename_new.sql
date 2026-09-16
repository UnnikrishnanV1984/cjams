-- FUNCTION: cjams.f_sp_ename_new(as_type_cd character varying, ai_key_id bigint)

-- DROP FUNCTION cjams.f_sp_ename_new(as_type_cd character varying, ai_key_id bigint);

CREATE OR REPLACE FUNCTION cjams.f_sp_ename_new(as_type_cd character varying, ai_key_id bigint)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

DECLARE	
	vi_start_screening_id 		bigint;
--	VS_CASE_HEAD_NM				VARCHAR;
	VS_PROVIDER_NM				VARCHAR;
	VS_PERSON_NM				VARCHAR;
	VS_STAFF_NM					VARCHAR;
	VS_PROVIDER_REFERRAL_NM		VARCHAR;
	VS_SCREENING_NM				VARCHAR;
	VS_REFERRAL_NM				VARCHAR;

BEGIN

     vi_start_screening_id = (SELECT (rtrim(app_pref_value_tx))::bigint
								FROM tb_application_preference 
								WHERE app_pref_id = 52);
     
	      CASE as_type_cd      
	--	      WHEN 'servicacase' THEN
	--		      	VS_CASE_HEAD_NM = SELECT caseheadname 
	--							      	FROM servicecase 
	--							      	WHERE servicecasenumber = ai_key_id 
	--							      		AND activeflag = 1;
	--	      RETURN VS_CASE_HEAD_NM;
	
		      WHEN 'provider' THEN
			      	VS_PROVIDER_NM = (SELECT
							  		CASE
									    WHEN LENGTH(RTRIM(provider_nm)) > 0 THEN 
									    	provider_nm
									    ELSE
									        coalesce(provider_first_nm || ' ','')  ||
									      	coalesce(provider_middle_nm || ' ','') ||
									      	coalesce(provider_last_nm || ' ','') ||
									      	coalesce(f_pdesc(provider_suffix_cd, 214),'')
							  		END
								     FROM  tb_provider
								     WHERE provider_id = ai_key_id 
								    	AND delete_sw = 'N');
		      RETURN VS_PROVIDER_NM;
	
		      WHEN 'person' THEN
			      	VS_PERSON_NM = (SELECT 
										coalesce(firstname || ' ','') ||
										coalesce(middlename || ' ','') ||
										coalesce(lastname || ' ','') ||
										coalesce(suffix,'')
							      	FROM person 
							      	WHERE cjamspid = ai_key_id 
							      		AND activeflag = 1);
		      RETURN VS_PERSON_NM;	     
	
		      WHEN 'staff' THEN
			      	VS_STAFF_NM = (SELECT 
										coalesce(firstname || ' ','') ||
										coalesce(middlename || ' ','') ||
										coalesce(lastname || ' ','')
							      	FROM userprofile  
							      	WHERE cjamspid = ai_key_id 
							      		AND activeflag = 1);
		      RETURN VS_STAFF_NM;	
		     
		      WHEN 'providerreferral' THEN
			      	VS_PROVIDER_REFERRAL_NM = (SELECT
							  		CASE
									    WHEN LENGTH(RTRIM(provider_referral_nm)) > 0 THEN 
									    	provider_referral_nm
									    ELSE
									        coalesce(provider_referral_first_nm || ' ','')  ||
									      	coalesce(provider_referral_middle_nm || ' ','') ||
									      	coalesce(provider_referral_last_nm || ' ','') ||
									      	coalesce(f_pdesc(provider_referral_suffix_cd, 214),'')
							  		END
								     FROM  tb_provider_referral
								     WHERE provider_referral_id = ai_key_id 
								    	AND delete_sw = 'N');
		      RETURN VS_PROVIDER_REFERRAL_NM;	     
		     
		      WHEN 'referral' THEN         
		 	      IF AI_KEY_ID <> vi_start_screening_id THEN
				      	VS_REFERRAL_NM = (SELECT referralname
								      	FROM investigation  
								      	WHERE intakeserviceid = (SELECT intakeserviceid
														      	FROM intakeservicerequest  
														      	WHERE servicerequestnumber = ai_key_id::VARCHAR
														      		AND activeflag = 1)		 
								      		AND activeflag = 1);
			      		RETURN VS_REFERRAL_NM;
			      ELSE
			 	      VS_SCREENING_NM = (SELECT title
								      	 FROM intakeservicerequest  
								      	 WHERE servicerequestnumber = ai_key_id::VARCHAR
								      		 AND activeflag = 1);
			      	  RETURN VS_SCREENING_NM;	  
		          END IF;
		         
		      WHEN 'cps' THEN
			      	VS_REFERRAL_NM = (SELECT referralname
							      	FROM investigation  
							      	WHERE intakeserviceid = (SELECT intakeserviceid
													      	FROM intakeservicerequest  
													      	WHERE servicerequestnumber = ai_key_id::VARCHAR
													      		AND activeflag = 1)		 
							      		AND activeflag = 1);
		      RETURN VS_REFERRAL_NM;	             
	
	      	 ELSE
	              return null;
	      end case;
      
END;

$function$

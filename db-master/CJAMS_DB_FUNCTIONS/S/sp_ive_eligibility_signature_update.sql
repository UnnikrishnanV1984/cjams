Drop function if exists cjams.sp_ive_eligibility_signature_update(character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.sp_ive_eligibility_signature_update(userrole character varying, username character varying,usersignature character varying,usersignaturedate timestamp without time zone, userid character varying, id int)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 

DECLARE

v_userrole character varying;
v_username character varying;
v_usersignature character varying;
v_usersignaturedate timestamp without time zone;
v_userid character varying;
v_eligibility_period_id int;
--------------------------------------------------
-- 03/04/2025 - IVE Signature issue fix CIDM-10229
--------------------------------------------------

   
BEGIN

	  	  v_userrole := userrole;
          v_username := username;
          v_usersignature := usersignature;
          v_usersignaturedate := usersignaturedate;
          v_userid := userid;
          v_eligibility_period_id := id;

	
		IF (v_userrole in ('IVESV','IVEQA','IVEADMIN')) THEN


               UPDATE tb_ive_fostercare_audit tep set supervisorname = v_username, supervisorsignature = v_usersignature, supervisorsubmissiondate = v_usersignaturedate , updatedby = v_userid, updatedon = now() where tep.eligibility_period_id = v_eligibility_period_id;  

               UPDATE tb_eligibility_period tep set supervisorname = v_username, supervisorsignature = v_usersignature, supervisorsubmissiondate = v_usersignaturedate , update_user_id = v_userid, update_ts = now() where tep.eligibility_period_id = v_eligibility_period_id ;  
		ELSE IF (v_userrole in ('IVESP', 'IVEEA')) THEN


               UPDATE tb_ive_fostercare_audit tep set specialistname = v_username, specialistsignature = v_usersignature, specialistsubmissiondate = v_usersignaturedate , updatedby = v_userid, updatedon = now() where tep.eligibility_period_id = v_eligibility_period_id ;  

               UPDATE tb_eligibility_period tep set specialistname = v_username, specialistsignature = v_usersignature, specialistsubmissiondate = v_usersignaturedate , update_user_id = v_userid, update_ts = now() where tep.eligibility_period_id = v_eligibility_period_id ;  
	
				  
		END IF;	
        end if;

RETURN  'success';
END;
	
$function$
;

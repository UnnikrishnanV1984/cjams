DROP FUNCTION IF EXISTS cjams.useroffboarding(character varying);

CREATE OR REPLACE FUNCTION cjams.useroffboarding(v_email character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Revisions
---- 03/27/2025 - Anil Dharni - CIDM-10293 - On deactivating worker from the Application, Assigned assignment should be assigned to their respective supervisor
										-- offboarding a user deletes the user data from Securityusersid, teammember, userprofile, muser, userprofileaddress, userprofilephonenumber, as_teammemberassignment, teammemberassignment tables
---- 07/29/2025 - Anil Dharni - CIDM-10293 - On deactivating worker from the Application, Assigned assignment should be assigned to their respective supervisor
------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	DECLARE v_securityusersid character varying;
	v_message character varying(100);
	input_email character varying;
	v_deactivatedusercaseassignment character varying;
	muser_id int8;

	BEGIN
	v_message:= 'Success';
	input_email:= v_email;

	Select securityusersid into v_securityusersid from userprofile where lower(email ) = lower(v_email);

    SELECT id INTO muser_id FROM cjams.muser WHERE securityusersid = v_securityusersid;
	

	IF NOT EXISTS (select * from userprofile where lower(email ) = lower(v_email) and activeflag =1 ) THEN 
		v_message:= 'User does not exist in userprofile';
		
		INSERT INTO cjams.inputfromsailpoint
			(v_email, methodname, insertedby, insertedon, updatedby, updatedon, message, response)
		VALUES(input_email, 'useroffboarding', 'direct', now(), 'useroffboarding', now(), 'User does not exist in userprofile', 'User does not exist in userprofile');
	ELSE 
			/*Update Userprofile*/
			IF (v_securityusersid !='') THEN 
				Update userprofile 
				set activeflag=0,updatedon=now(), updatedby = 'useroffboarding'
				where securityusersid=v_securityusersid;
				
				-- security users table 
				UPDATE cjams.securityusers
				SET activeflag=0, updatedby='useroffboarding', updatedon=now()
				WHERE securityusersid=v_securityusersid and activeflag=1;


				UPDATE teammember
					SET activeflag = 0,
						updatedby = 'useroffboarding',
						updatedon = now()
					WHERE teammemberid IN (
						select tm.teammemberid 
							from userprofile up 
								join teammemberassignment tma on tma.securityusersid = up.securityusersid  
								join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
							where up.securityusersid = v_securityusersid);
				
				UPDATE teammemberassignment
					SET activeflag = 0,
						updatedby = 'useroffboarding',
						updatedon = now()
					WHERE teammemberassignmentid IN (
						select tma.teammemberassignmentid 
							from userprofile up 
								join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
							where up.securityusersid = v_securityusersid);

				-- as teammemberassignment
				UPDATE cjams.as_teammemberassignment
				SET activeflag=0, updatedby='useroffboarding', updatedon=now()
				WHERE securityusersid=v_securityusersid and activeflag=1;

				-- userprofilephonenumber
				UPDATE cjams.userprofilephonenumber
				SET activeflag=0, updatedby='useroffboarding', updatedon=now()
				WHERE securityusersid=v_securityusersid and activeflag=1;
				
				-- userprofileaddress
				UPDATE cjams.userprofileaddress
				SET activeflag=0, updatedby='useroffboarding', updatedon=now()
				WHERE securityusersid=v_securityusersid and activeflag=1;

				-- muser
				Update muser 
				set activeflag=0,updatedon=now(), updatedby = 'useroffboarding'
				where securityusersid=v_securityusersid;
				
				UPDATE rolemapping 
					SET activeflag = 0, 
						updatedby = 'useroffboarding', 
						updatedon = now()
					WHERE principalid = muser_id::character varying
						and activeflag = 1; 

				UPDATE cjams.userresource
                SET activeflag=0,updatedby='useroffboarding', updatedon=now()
                WHERE userid= muser_id
				and activeflag = 1;
									
				INSERT INTO cjams.inputfromsailpoint
    				(v_email, methodname, insertedby, insertedon, updatedby, updatedon, message, response)
					VALUES(v_email, 'useroffboarding', 'direct', now(), 'useroffboarding', now(), 'User deactivated sucessfully', 'User deactivated sucessfully');

				select deactivatedusercaseassignment into v_deactivatedusercaseassignment from cjams.deactivatedusercaseassignment(v_securityusersid);		
						 
			END IF;	
			
	END IF;
	
	
	return v_message;
	 END  
	  $function$
;

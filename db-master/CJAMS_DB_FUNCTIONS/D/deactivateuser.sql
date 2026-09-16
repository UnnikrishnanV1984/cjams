CREATE OR REPLACE FUNCTION cjams.deactivateuser(v_email character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Revisions
---- 10/08/2024 - Manasa Kasula - CIDM-9543- On deactivating worker from the Application, Assigned assignment should be assigned to there respective supervisor
------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	DECLARE v_securityusersid character varying;
	v_message character varying(100);
	input_email character varying;
	v_deactivatedusercaseassignment character varying;
	 
	 
	BEGIN
	v_message:= 'Success';
	input_email:= v_email;

	Select securityusersid into v_securityusersid from userprofile where lower(email ) = lower(v_email);
	

	IF NOT EXISTS (select * from userprofile where lower(email ) = lower(v_email) and activeflag =1 ) THEN 
		v_message:= 'User does not exist in userprofile';
		
		INSERT INTO cjams.inputfromsailpoint
			(v_email, methodname, insertedby, insertedon, updatedby, updatedon, message)
		VALUES(input_email, 'deactivateuser', 'direct', now(), 'deactivateuser', now(), 'User does not exist in userprofile');
	ELSE 
			/*Update Userprofile*/
			IF (v_securityusersid !='') THEN 
				Update userprofile 
				set activeflag=0,updatedon=now(), updatedby = 'deactivateuser'
				where securityusersid=v_securityusersid;
				
				UPDATE teammember
					SET activeflag = 0,
						updatedby = 'deactivateuser',
						updatedon = now()
					WHERE teammemberid IN (
						select tm.teammemberid 
							from userprofile up 
								join teammemberassignment tma on tma.securityusersid = up.securityusersid  
								join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
							where up.securityusersid = v_securityusersid);
				
				UPDATE teammemberassignment
					SET activeflag = 0,
						updatedby = 'deactivateuser',
						updatedon = now()
					WHERE teammemberassignmentid IN (
						select tma.teammemberassignmentid 
							from userprofile up 
								join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
							where up.securityusersid = v_securityusersid);
							
				INSERT INTO cjams.inputfromsailpoint
					(v_email, methodname, insertedby, insertedon, updatedby, updatedon, message)
					VALUES(v_email, 'deactivateuser', 'direct', now(), 'deactivateuser', now(), 'User deactivated sucessfully');	

				select deactivatedusercaseassignment into v_deactivatedusercaseassignment from cjams.deactivatedusercaseassignment(v_securityusersid);		
						 
			END IF;	
			
	END IF;
	
	Select securityusersid into v_securityusersid from muser where lower(email ) = lower(v_email);	

	IF NOT EXISTS (select * from muser where lower(email ) = lower(v_email) and activeflag =1 ) THEN 
	 v_message:= 'User does not exist in muser';
	ELSE 
			/*Update muser*/
			IF (v_securityusersid !='') THEN 								
				Update muser 
				set activeflag=0,updatedon=now(), updatedby = 'deactivateuser'
				where securityusersid=v_securityusersid;
				
				UPDATE rolemapping 
					SET activeflag = 0, 
						updatedby = 'deactivateuser', 
						updatedon = now()
					WHERE principalid IN (select id::character varying 
											from muser 
											where securityusersid = v_securityusersid) 
						and activeflag = 1;	
			END IF;	
			
	END IF;
	
	
	return v_message;
	 END  
	  $function$
;

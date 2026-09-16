DROP FUNCTION IF EXISTS cjams.createmulticountyuser(character varying, character varying, character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.createmulticountyuser(i_user_email character varying, i_new_county_supervisoremail character varying,
						i_new_county_teamnumber character varying, i_defectnumber character varying)
 RETURNS character varying
 LANGUAGE plpgsql
 
AS $function$

DECLARE
		v_teamid uuid;
		v_new_county_supervisorid character varying;
		v_old_county_supervisorid character varying;
		v_teammemberid uuid;

BEGIN
		v_teammemberid := null;

		SELECT supervisorid INTO v_old_county_supervisorid
			FROM userprofile 
			WHERE email = i_user_email and activeflag = 1
			LIMIT 1;

		SELECT securityusersid INTO v_new_county_supervisorid
			FROM userprofile   
			WHERE email = i_new_county_supervisoremail and activeflag = 1
			LIMIT 1;
			
		SELECT teamid INTO v_teamid
			FROM team 
			WHERE teamnumber = i_new_county_teamnumber and activeflag = 1
			LIMIT 1; 
					
		IF (v_old_county_supervisorid IS NOT NULL and v_old_county_supervisorid != '00000000-0000-0000-00000000000000000') THEN
			
			UPDATE teammember SET supervisorid = v_old_county_supervisorid, updatedby = i_defectnumber, updatedon = now() WHERE teammemberid IN 
				(SELECT tm.teammemberid  
					FROM teammember tm
					JOIN teammemberassignment tma ON tm.teammemberid = tma.teammemberid and tma.activeflag = 1
					JOIN userprofile up on up.securityusersid = tma.securityusersid and up.activeflag = 1
					WHERE up.email = i_user_email and tm.activeflag = 1 order by tm.insertedon asc LIMIT 1);
		
		END IF;
			
		v_teammemberid = gen_random_uuid();
		INSERT INTO teammember (teammemberid, activeflag, teamid, loadnumber, roletypekey, positioncode, description, isoncall, supervisorid,
				insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", linenumber, voidedby, voidedon, voidreasonid, rtfdate, coadate, old_id, isdefaultroute)
			SELECT v_teammemberid, 1, v_teamid, tm.loadnumber, 'CWAPPEALCO', tm.positioncode, tm.description, tm.isoncall, v_new_county_supervisorid,
				i_defectnumber, now(), i_defectnumber,  now(),  now(), null, NULL, NULL , NULL, NULL, NULL,  now(), now(), NULL, 1
				FROM teammember tm
					JOIN teammemberassignment tma ON tm.teammemberid = tma.teammemberid and tma.activeflag = 1
					JOIN userprofile up on up.securityusersid = tma.securityusersid and up.activeflag = 1
					WHERE up.email = i_user_email and tm.activeflag = 1 LIMIT 1;
 
			
		INSERT INTO cjams.teammemberassignment(teammemberassignmentid, activeflag, teammemberid, securityusersid, insertedby, insertedon, updatedby, updatedon, effectivedate) 
			VALUES (gen_random_uuid(), 1, v_teammemberid, (select u.securityusersid from userprofile u  where u.email = i_user_email LIMIT 1), i_defectnumber, now(), i_defectnumber, now(), now());
			
		
		RETURN 'Success';

  END;

$function$
;

-- select * from cjams.createmulticountyuser('briank.miller@maryland.gov', 'tamra.canfield@maryland.gov','1438_AS1');
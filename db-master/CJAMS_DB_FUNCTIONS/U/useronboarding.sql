DROP function if exists cjams.useronboarding(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);
DROP FUNCTION IF EXISTS cjams.useronboarding(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.useronboarding(v_email character varying, v_firstname character varying, v_lastname character varying,	v_middlename character varying, v_fullname character varying, v_agencycode character varying, v_openamrole character varying, v_countycode character varying, v_teamcode character varying, v_teamname character varying, v_ldss character varying, 
			v_add1 character varying, v_city character varying, v_zipcode character varying, v_cell_phonenumber character varying, v_staffid character varying, v_positioncode character varying, v_positiontitle character varying, v_username character varying, v_super_id character varying, v_as_super_id character varying, v_isaddorremove character varying, v_work_phonenumber character varying DEFAULT NULL::character varying)
	
RETURNS text
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
AS $BODY$
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 6/28/2024 Manasa Kasula - CIDM- 8978- Added additional messages
-- 03/21/2025-Anil Kumar Dharni - CIDM-10293- - Created the useronboarding procedure to onboard new users by validating agency-role, inserting team and user details, assigning roles, managing inactive users, and logging actions. 
										-- Includes conditional logic for AS, CW, LDSS teams and detailed process tracking for audit and debugging
-- 03/31/2025-Manasa Kasula - CIDM-10293- Proc Readable comments are added. 
-------------------------------------------------------------------------------------------------------------
	declare v_teamid uuid ;
	v_teammemberid uuid ;
	v_securityusersid uuid ;
	v_inactive_securityusersid uuid ;
	v_sup_securityusersid uuid ;
	v_as_sup_securityusersid uuid ;
	v_roleid integer;
	v_roletypekey character varying;
	v_teamtypekey character varying;	
	v_message text;
	v_inputid character varying;
	v_updateteamassignment text;
	v_response character varying;
	v_existing_cell_phonenumber character varying;
	v_existing_work_phonenumber character varying;
	 
	BEGIN
	v_roletypekey:= NULL;
	v_message:= '';
	v_response:= '';
	-- Insert into the inputfromsailpoint table for logging the sailpoint request parameters.
	INSERT INTO cjams.inputfromsailpoint
	(inputid, v_email, v_firstname, v_lastname, v_middlename, v_fullname, v_agencycode, v_openamrole, v_countycode, v_teamcode, v_teamname, v_ldss, v_add1, v_city, v_zipcode, v_cell_phonenumber, v_work_phonenumber, v_staffid, v_positioncode, v_positiontitle, v_username, v_super_id, v_as_super_id, v_isaddorremove, insertedby, insertedon, updatedby, updatedon,methodname)
	VALUES(gen_random_uuid(), v_email, v_firstname, v_lastname, v_middlename, v_fullname, v_agencycode, v_openamrole, v_countycode, v_teamcode, v_teamname, v_ldss, v_add1, v_city, v_zipcode, v_cell_phonenumber, v_work_phonenumber, v_staffid, v_positioncode, v_positiontitle, v_username, v_super_id, v_as_super_id, v_isaddorremove, 'direct', now(), 'direct', now(),'useronboarding')
	returning inputid into v_inputid;

	v_message:= v_message || chr(10) || 'Inserted Into inputfromsailpoint is done';

	RAISE NOTICE ' ----->>>>>v_message %<<<<<-----',v_message;
	-- Fetch the securityusersid based on the email
	SELECT securityusersid INTO v_securityusersid FROM cjams.userprofile WHERE lower(email) = lower(v_email) AND activeflag = 1 LIMIT 1;
	-- If agency code is null then return an error message and no further action performed.
	IF(v_agencycode is null) THEN 
		v_message:= v_message || chr(10) || 'Error: Agency code(Program/Sub Program) is null. Unable to proceed!';
		v_response:= 'Error: Agency code(Program/Sub Program) is null. Unable to proceed: Error Code: 35001';
	ELSE 
		-- if staffid is null then set the staffid based on user firstname and lastname.
		IF (v_staffid IS NULL OR v_staffid = '' OR v_staffid = '1234') THEN
			v_staffid =  lower(v_firstname) || lower(v_lastname)::character varying ;
		END IF;
		-- Fetch the teamid based on the user teamcode 
		Select teamid into v_teamid from cjams.team where lower(teamnumber ) = lower(v_teamcode);
		-- Fetch the supervisorid based on the supervisor email
		IF (v_super_id IS NOT NULL AND v_super_id != '')  THEN
			Select securityusersid into v_sup_securityusersid from cjams.userprofile where lower(email ) = lower(v_super_id);
		END IF;
		-- Fetch the AS supervisorid based on the AS supervisor email
		IF (v_as_super_id IS NOT NULL AND v_as_super_id != '')  THEN
			Select securityusersid into v_as_sup_securityusersid from cjams.userprofile where lower(email ) = lower(v_as_super_id);
		END IF;
		-- Fetch the user role details based on the openamrole
		SELECT r.id, r.roletypekey, tr.teamtypekey INTO v_roleid, v_roletypekey, v_teamtypekey
		from cjams.role r, cjams.teammemberroletype tr where tr.roletypekey  = r.roletypekey and lower(r.openamrole) = lower(v_openamrole) and r.activeflag = 1 and tr.activeflag=1 and tr.teamtypekey = v_agencycode limit 1;
		-- If the user role is null then return the error message and no further action is performed.
		IF (v_roletypekey IS NULL) THEN 
			v_message:=  v_message || chr(10) || 'Error: Requested agency with role combination is not exist. Unable to proceed!';
			v_response:= 'Error: Requested agency with role combination is not exist. Unable to proceed!: Error Code: 35002';
		ELSE 
			/*Team Insert*/
			-- Based on teamcode fetched teamid is null then insert into team table for the teamcode
			IF (coalesce(v_teamid::character varying,'')='') THEN 
				INSERT INTO cjams.team
				(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
				VALUES(gen_random_uuid(), 1, v_teamname, v_teamcode, v_teamtypekey, v_teamname, '01:00:00', '04:00:00', (SELECT countyid FROM county WHERE statecountycode =v_countycode AND activeflag =1 LIMIT 1), 'admin', now(), 'admin', now(), now(), NULL, NULL, 0, NULL, NULL, (SELECT countyid FROM county WHERE statecountycode =v_countycode AND activeflag =1 LIMIT 1)) returning teamid into v_teamid ;
										
				v_message:= v_message || chr(10) || 'user creation process initaited--> Checks if v_teamid is null or empty -->Inserted Into team table succesfully';
			END IF;
			-- Fetch the inactive securityusersid for the email input
			Select securityusersid into v_inactive_securityusersid from cjams.userprofile where lower(email ) = lower(v_email) and activeflag = 0;
			-- If inactive user is present then updating the email in userproile and muser table.
			If (v_inactive_securityusersid IS NOT NULL) THEN
			
				update cjams.userprofile
				set email = REPLACE(v_email, 'gov', 'md.state.com'), updatedon = now(), updatedby = 'admin'
				where securityusersid = v_inactive_securityusersid :: character varying;
				
				v_message:= v_message || chr(10) || 'user creation process initaited --> If securityuserid is not null--> Updated userprofile table succesfully';
			
				update cjams.muser
				set email = REPLACE(v_email, 'gov', 'md.state.com'), updatedon = now(), updatedby = 'admin'
				where securityusersid = v_inactive_securityusersid :: character varying;
				
				v_message:= v_message || chr(10) || 'user creation process initaited-->If securityuserid is not null-->Updated muser table succesfully';
			END IF;
		
			/*User Inser*/
			-- if securityusersid is null , role is not null and flag is 'add' then user will be created 
			IF (coalesce(v_securityusersid::character varying,'')=''AND v_roletypekey IS NOT NULL AND v_isaddorremove = 'add') THEN 
				-- Insert into teammember Table.
				INSERT INTO cjams.teammember (teammemberid, activeflag, teamid, loadnumber, roletypekey, positioncode, description, isoncall,
				insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", linenumber, voidedby, voidedon, voidreasonid, rtfdate, coadate, old_id, isdefaultroute)
				VALUES (gen_random_uuid(), 1, v_teamid, v_staffid , v_roletypekey,
				v_positioncode ,v_positiontitle, true, '', now(), 'admin',  now(),  now(), null, NULL,
				NULL , NULL, NULL, NULL,  now(), now(), NULL, 1)  returning teammemberid into v_teammemberid; 

				v_message:= v_message || chr(10) || 'user creation process initaited --> securityuserid is null or empty, Roletypekey is provided and action is add -->  Inserted into teammember table succesfully';
				-- Insert into Userprofile Table.
				INSERT INTO cjams.userprofile(
					securityusersid, firstname, lastname, displayname, fullname, middlename,
					activeflag,   email,    insertedby, insertedon, updatedby, updatedon,
						teamtypekey,usertypekey,autonotification,old_id,title,primarycountycd,supervisorid,assupervisorid)
				values(gen_random_uuid(),v_firstname,v_lastname,v_firstname || v_lastname,v_fullname,v_middlename,
					1,v_email ,'admin' ,now(),'admin',now(),v_teamtypekey,'DSDS',false,v_staffid,null,v_countycode,v_sup_securityusersid,v_as_sup_securityusersid) returning securityusersid into v_securityusersid ;

				v_message:= v_message || chr(10) || 'user creation process initaited --> securityuserid is null or empty,Roletypekey is provided and action is add -->  Inserted into userprofile table succesfully';
				-- Insert into securityusers Table.
				INSERT INTO cjams.securityusers(
					securityusersid, username , activeflag, insertedby, updatedby, insertedon, updatedon,old_id)
					select securityusersid, displayname,  1,'admin','admin',now(),now(),'man' from userprofile where email= v_email;
				
				v_message:= v_message || chr(10) || 'user creation process initaited --> securityuserid is null or empty,Roletypekey is provided and action is add -->  Inserted into securityusers table succesfully';
				-- Insert into muser Table.
				INSERT INTO cjams.muser(
					password, email,  id, securityusersid,
				insertedby, updatedby, insertedon, updatedon, activeflag ,old_id,username)
				SELECT  '$2a$10$fwlp0MMCDZHj9wk7mNdQ6uf1hQkZXcDYiqlLZZVWK0Ic4PCcm0lyW',email,nextval('muser_id_seq'),securityusersid, 'admin' ,'admin',now(),now(),1, v_staffid,v_username from userprofile where email= v_email;

				v_message:= v_message || chr(10) || 'user creation process initaited --> securityuserid is null or empty,Roletypekey is provided and action is add -->  Inserted into muser table succesfully';
				-- Insert into userprofileaddress Table when address1 paremeter is not null.
				IF COALESCE(v_add1,'')<>'' THEN
					INSERT INTO cjams.userprofileaddress (securityusersid,userprofileaddresstypekey,address,zipcode,city,state,county,countyid,activeflag,insertedon, updatedon, insertedby,updatedby)
					VALUES (v_securityusersid,'P',v_add1,v_zipcode,v_city,'MD',v_ldss,(SELECT countyid FROM county WHERE statecountycode =v_countycode AND activeflag =1 LIMIT 1),1, now(),now(),'admin','admin');
					v_message:= v_message || chr(10) || 'user creation process initaited --> Address is provided and valid --> Inserted into userprofileaddress table succesfully';
				END IF;
				-- Insert into userprofilephonenumber Table when cellphonenumber paremeter is not null.
				IF COALESCE(v_cell_phonenumber,'')<>'' THEN
					INSERT INTO cjams.userprofilephonenumber (userprofilephonenumberid, securityusersid, activeflag, userprofiletypekey, phonenumber, updatedby, insertedby, updatedon, insertedon ) 
					VALUES(gen_random_uuid(), v_securityusersid, 1,'cell',v_cell_phonenumber, 'admin','admin',now(),now());

					v_message:= v_message || chr(10) || 'user creation process initaited -->Cell phone number is provided -->Inserted into userprofilephonenumber table succesfully';
				END IF;
				-- Insert into userprofilephonenumber Table when workphonenumber paremeter is not null.
				IF COALESCE(v_work_phonenumber,'')<>'' THEN
					INSERT INTO cjams.userprofilephonenumber (userprofilephonenumberid, securityusersid, activeflag, userprofiletypekey, phonenumber, updatedby, insertedby, updatedon, insertedon ) 
					VALUES(gen_random_uuid(), v_securityusersid, 1,'work',v_work_phonenumber, 'admin','admin',now(),now());

					v_message:= v_message || chr(10) || 'user creation process initaited -->Work phone number is provided -->Inserted into userprofilephonenumber table succesfully';
				END IF;
				-- if teamtypekey is 'AS' then insert into as_teammemberassignment else into teammemberassignment
				IF (v_teamtypekey = 'AS') THEN
					INSERT INTO cjams.as_teammemberassignment
						(teammemberassignmentid, activeflag, teammemberid, securityusersid, insertedby, insertedon, updatedby, updatedon, effectivedate)
					VALUES (gen_random_uuid(), 1, v_teammemberid,v_securityusersid, 'admin', now(), 'admin', now(), now());
				
					v_message:= v_message || chr(10) || 'user creation process initaited--> user has been assigned to an AS team   --> Inserted into as_teammemberassignment table succesfully';

				ELSE
					INSERT INTO cjams.teammemberassignment
					(teammemberassignmentid, activeflag, teammemberid, securityusersid, insertedby, insertedon, updatedby, updatedon, effectivedate)
					VALUES (gen_random_uuid(), 1, v_teammemberid,v_securityusersid, 'admin', now(), 'admin', now(), now());
				
					v_message:= v_message || chr(10) || 'user creation process initaited --> user has been assigned to the CW or LDSS team --> Inserted into teammemberassignment table succesfully';

				END IF; 
				-- insert into rolemapping , teamtypekey is 'CW' for 'IV-E' or 'FNS', for "LDSS" for 'PROV' or 'PVPROV' else given value
				IF (v_teamtypekey = 'IV-E' OR v_teamtypekey = 'FNS') THEN
					INSERT INTO cjams.rolemapping
					(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, teamtypekey)
					select nextval('rolemapping_id_seq'),'USER',id::character varying, v_roleid   ,1, 'admin', 'admin', now(), now(), 'CW'
					from muser where securityusersid in (select securityusersid from userprofile where email= v_email);
				
					v_message:= v_message || chr(10) || 'user creation process initaited --> for teamtypekey IV-E or FNS --> Inserted into rolemapping table with teamtypekey as CW succesfully';
			
				ELSE IF (v_teamtypekey = 'PROV' OR v_teamtypekey = 'PVPROV') THEN
					INSERT INTO cjams.rolemapping
					(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, teamtypekey)
					select nextval('rolemapping_id_seq'),'USER',id::character varying, v_roleid   ,1, 'admin', 'admin', now(), now(), 'LDSS'
					from muser where securityusersid in (select securityusersid from userprofile where email= v_email);
				
					v_message:= v_message || chr(10) || 'user creation process initaited -->for teamtypekey PROV or PVPROV --> Inserted into rolemapping table with teamtypekey as LDSS succesfully';

				ELSE
					INSERT INTO cjams.rolemapping
					(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, teamtypekey)
					select nextval('rolemapping_id_seq'),'USER',id::character varying, v_roleid   ,1, 'admin', 'admin', now(), now(), v_teamtypekey
					from muser where securityusersid in (select securityusersid from userprofile where email= v_email);		
					v_message:= v_message || chr(10) || 'user creation process initaited -->Insertion Into rolemapping table succesfully';
				END IF;
				END IF;	 
				v_message:= v_message || chr(10) || 'New User onboarded Successfully';
				v_response:= 'New User onboarded Successfully';	
				-- Ending user add functionality
			ELSE	
				-- Else when securityusersid is not null or role is null or flag is not 'add'
				-- Returning error message and no further action is performed.
				v_message := v_message || chr(10) || 'User already exists or v_isaddorremove flag not set to add';
				v_response := 'User already exists or v_isaddorremove flag not set to add';
				-- RAISE NOTICE ' ----->>>>>calling updateteamassignment <<<<<-----';
				-- SELECT * into v_updateteamassignment FROM updateteamassignment(v_email, v_teamcode, v_countycode, v_teamname, v_roletypekey,v_super_id, v_as_super_id, v_teamtypekey, v_agencycode, v_isaddorremove);
				-- v_response:= v_response || chr(10) || v_updateteamassignment;		
			END IF;
		END IF;	
	END IF;  
	-- Updating the inputfromsailpoint table with messages and response columns
	update cjams.inputfromsailpoint set message = v_message, response = v_response, updatedby = 'useronboarding' , updatedon = now() where inputid = v_inputid; 
	return v_response;
END  
$BODY$;

 


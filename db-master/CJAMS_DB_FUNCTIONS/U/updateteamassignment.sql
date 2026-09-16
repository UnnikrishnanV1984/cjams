Drop function if exists cjams.updateteamassignment(v_email character varying, v_teamnumber character varying, v_statecountycode character varying, v_teamname character varying, v_roletypekey character varying, v_supervisoremail character varying, v_assupervisoremail character varying, v_agencycode character varying, v_isaddorremove character varying);
Drop function if exists cjams.updateteamassignment(v_email character varying, v_teamnumber character varying, v_statecountycode character varying, v_teamname character varying, v_roletypekey character varying, v_supervisoremail character varying, v_assupervisoremail character varying, v_teamtypekey character varying, v_agencycode character varying, v_isaddorremove character varying);
CREATE OR REPLACE FUNCTION cjams.updateteamassignment(v_email character varying, v_teamnumber character varying, v_statecountycode character varying, v_teamname character varying, v_roletypekey character varying, v_supervisoremail character varying, v_assupervisoremail character varying, v_teamtypekey character varying, v_agencycode character varying, v_isaddorremove character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
----------------------------------------------------------------------------------------------
-- Author          : Chandra Ramasamy
-- Date            : 02/28/2023
-- Description     : Stored Procedure to update the user team and roles. Deactivate the users.
-- Revision:
-- 02/28/2023 Chandra Ramasamy - CIDM-6820 - Adding the logics for FTDM roles to handle as secondary roles
-- 6/28/2024  Triveni Bala - CIDM- 8978- Added additional messages
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface
-- 06/12/2025 Manasa Kasula - CIDM-10550 SP Fix - To fix the logic to add the beacon allow access role
------------------------------------------------------------------------------------------------
DECLARE
	v_teamid uuid;
	v_countyid uuid;
	v_positioncode character varying;
	v_securityusersid character varying;
	v_teammemberid uuid;
	v_loadnumber character varying;
	v_teammemberassignmentid uuid;
	v_principalid bigint;
	v_roleid integer;
	v_rolelevel integer;
	v_finalroletypekey character varying;
	v_permissiongroupid character varying;
	v_existingrolelevel integer;
	v_existingroleid integer;
	v_nextroleid integer;
	v_supervisorid uuid;
	v_assupervisorid uuid;
	v_message text;
    rec RECORD;
	rec2 RECORD;
	l_SPCount bigint;  
	l_RoleExistCount bigint;
	v_inputid character varying; 
	v_teamkey  character varying;
	v_ftdmroleexist integer;
	v_response character varying;
BEGIN
	v_teamid := null;
	v_positioncode := v_statecountycode;
	v_securityusersid := null;
	v_teammemberid := null;
	v_teammemberassignmentid := null;
	v_principalid := null;
	v_roleid := null;
	v_rolelevel := null;
	v_finalroletypekey := v_roletypekey;
	v_existingrolelevel := null;
	v_nextroleid := null;
	v_supervisorid := null;
	v_assupervisorid := null;
	rec := null;   
	v_ftdmroleexist := 0;
	v_message:= '';
	v_response:= '';


	INSERT INTO cjams.inputfromsailpoint
	(inputid, v_email, v_countycode, v_teamcode, v_teamname, v_super_id, v_as_super_id, v_isaddorremove, v_roletypekey, v_teamtypekey, v_agencycode, methodname, insertedby, insertedon, updatedby, updatedon)
	VALUES(gen_random_uuid(),v_email, v_statecountycode, v_teamnumber, v_teamname, v_supervisoremail, v_assupervisoremail,v_isaddorremove, v_roletypekey, v_teamtypekey, v_agencycode, 'updateteamassignment', 'direct', now(), 'direct', now())
	returning inputid into v_inputid;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

	SELECT securityusersid, 
	       lower(firstname) || lower(lastname)::character varying
		   INTO v_securityusersid, v_loadnumber
			FROM cjams.userprofile 
			WHERE lower(email) = lower(v_email)
			AND activeflag = 1
			LIMIT 1;
			
	IF (v_securityusersid IS NULL) THEN
		v_message:= v_message || chr(10) || 'Error: New user, please set isaddorremove flag as add';
		v_response:= 'Error: New user, please set isaddorremove flag as add: Error Code: 35003';
	ELSE	  
	   SELECT id INTO v_principalid FROM cjams.muser where securityusersid = v_securityusersid and activeflag=1 LIMIT 1;
	   SELECT r.id, tmrt.rolelevel  INTO  v_roleid, v_rolelevel FROM cjams.role r, cjams.teammemberroletype tmrt WHERE r.roletypekey = tmrt.roletypekey AND r.roletypekey = v_roletypekey AND r.activeflag=1 
       AND tmrt.activeflag=1 LIMIT 1;
	   IF (v_supervisoremail IS NOT NULL AND v_supervisoremail != '')  THEN
	   	SELECT securityusersid INTO v_supervisorid FROM cjams.userprofile where lower(email) = lower(v_supervisoremail) and activeflag = 1 LIMIT 1;
	   END IF;
	   IF (v_assupervisoremail IS NOT NULL AND v_assupervisoremail != '')  THEN
	   	SELECT securityusersid INTO v_assupervisorid FROM cjams.userprofile where lower(email) = lower(v_assupervisoremail) and activeflag = 1 LIMIT 1;
	   END IF;
	   --to identify the existing FTDM ROLES
	   select coalesce(count(*),0) into v_ftdmroleexist from cjams.rolemapping where roleid in (5987,5988,5989) and teamtypekey='CW' and activeflag=1
		and principalid=v_principalid::character varying;
	   IF (v_roleid IS NOT NULL) THEN  	   
		RAISE NOTICE ' ----->>>>>v_agencycode %<<<<<-----',v_agencycode;
		--added Becon role
		if(v_roletypekey in ('CWDOLAA'))  then
			raise notice '>>>>>Inside >>>>> if(v_roletypekey in (CWDOLAA)';

			SELECT count(*) INTO l_RoleExistCount FROM cjams.rolemapping rm, cjams.role r 
			WHERE rm.roleid = r.id AND rm.activeflag=1  AND rm.principalid = v_principalid::character varying
			AND rm.teamtypekey in  ('IV-E', 'FNS', 'CW') AND r.activeflag = 1;

			IF(l_RoleExistCount > 0) THEN  

				select permissiongroupid ::character varying into v_permissiongroupid from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS' and activeflag=1;
			
				INSERT INTO cjams.userresource
				( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
				VALUES( v_principalid, v_permissiongroupid::uuid, v_roleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
				v_message:= v_message || chr(10) || 'Inserted Into userresource table successfully from updateteamassignment';

				IF (v_agencycode = 'IV-E' OR v_agencycode = 'FNS') THEN
					v_teamkey = 'CW';
				ELSIF (v_agencycode = 'PROV' OR v_agencycode = 'PVPROV') THEN
					v_teamkey = 'LDSS';
				ELSE 
					v_teamkey = v_agencycode;
				END IF;
				SELECT r.roletypekey INTO v_finalroletypekey FROM cjams.rolemapping rm, cjams.role r 
				WHERE rm.roleid = r.id AND rm.activeflag=1 AND rm.teamtypekey = v_teamkey AND rm.principalid = v_principalid::character varying AND r.activeflag = 1;
				
				v_message:=  v_message || chr(10) || 'Role added Sucessfully.';

				v_response:= 'Role added Sucessfully.';		
			Else 
				v_message:= v_message || chr(10) || 'Please add any CW, Finance or IV-E role prior to assigning this role.';
				v_response:= 'Error: Please add any CW, Finance or IV-E role prior to assigning this role: Error Code: 35005.';
			END IF;
		--added Finance Director above 1K approval role
		elsif(v_roletypekey in ('ASDIR1KAPR', 'CWDIR1KAPR','CWPM', 'CWSSAPMR'))  then
		
			raise notice '>>>>>Inside >>>>> if(v_roletypekey in (ASDIR1KAPR, CWDIR1KAPR,CWPM, CWSSAPMR))  then';
		
			SELECT count(*) INTO l_SPCount FROM cjams.rolemapping rm, cjams.role r 
			WHERE rm.roleid = r.id AND rm.activeflag=1  AND rm.principalid = v_principalid::character varying
			AND CASE  WHEN v_agencycode= 'AS' then r.roletypekey='ASSP'  WHEN v_agencycode in  ('IV-E', 'FNS', 'CW') then r.roletypekey='CWSP' ELSE false END      
			AND r.activeflag = 1;
		
			IF(l_SPCount > 0) THEN  

				if(v_roletypekey = 'CWSSAPMR') then
					v_permissiongroupid ='7e53df93-9632-4dcb-9e35-c580f1d5680e';
				end if;
				if(v_roletypekey = 'CWPM') then
					v_permissiongroupid ='5c760141-a1ff-4ae2-bbc8-5692391e3dc1';
				end if;
				if(v_roletypekey in ('ASDIR1KAPR', 'CWDIR1KAPR')) then
					v_permissiongroupid = '57a390b8-3387-428a-97a8-0b8559fd1f1e';
				end if;

				INSERT INTO cjams.userresource
				( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
				VALUES( v_principalid, v_permissiongroupid::uuid, v_roleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
				v_message:= v_message || chr(10) || 'Inserted Into userresource table successfully from updateteamassignment';

				IF (v_agencycode = 'IV-E' OR v_agencycode = 'FNS') THEN
					v_teamkey = 'CW';
				ELSIF (v_agencycode = 'PROV' OR v_agencycode = 'PVPROV') THEN
					v_teamkey = 'LDSS';
				ELSE 
					v_teamkey = v_agencycode;
				END IF;
				SELECT r.roletypekey INTO v_finalroletypekey FROM cjams.rolemapping rm, cjams.role r 
				WHERE rm.roleid = r.id AND rm.activeflag=1 AND rm.teamtypekey = v_teamkey AND rm.principalid = v_principalid::character varying AND r.activeflag = 1;
				
				v_message:=  v_message || chr(10) || 'Role added Sucessfully.';

				v_response:= 'Role added Sucessfully.';
		
			else 
				v_message:= v_message || chr(10) || 'Please add Supervisor role prior to assigning this role.';
				v_response:= 'Error: Please add Supervisor role prior to assigning this role: Error Code: 35004.';
			END IF;     
		
		/* FTDM new roles onboarding */
		elsif (v_roletypekey in ('FTDMFW','QUINW','FTDMQIS'))  then
		
			raise notice '>>>>> Inside >>>>>>> elsif (v_roletypekey in (FTDMFW,QUINW,FTDMQIS))  then>>>v_ftdmroleexist %',v_ftdmroleexist;
			if (v_ftdmroleexist = 0) then 
				raise notice '>>>>>>Inside 			if (v_ftdmroleexist = 0) then ';
				-- no any primary role
				if(v_roletypekey = 'FTDMFW') then
					v_permissiongroupid ='90ed1d47-e282-48df-a54a-a2151bde847f';
				end if;
				if(v_roletypekey = 'QUINW') then
					v_permissiongroupid ='4ba216d8-5eb2-4164-b01b-e19452425387';
				end if;
				if(v_roletypekey in ('FTDMQIS')) then
					v_permissiongroupid = '2105ed26-fdaf-41d5-aca8-19b334f78daa';
				end if;
			
				-- first soft delete the existing permission for the same permission
				UPDATE cjams.userresource SET activeflag =0,updatedon = now(), updatedby = 'ADMIN'
				WHERE userid = v_principalid AND permissiongroupid = v_permissiongroupid::uuid AND activeflag = 1;
				
				v_message:= v_message || chr(10) || 'Update on userresource table is done sucessfully';

				-- then insert the permission
				
				INSERT INTO cjams.userresource
				( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
				VALUES( v_principalid, v_permissiongroupid::uuid, v_roleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
				v_message:= v_message || chr(10) || 'Inserted Into userresource table sucessfully';
			
			else 
				--PRIMARY role is exist	
				raise notice '>>>>>>Inside 	>>> else >>>>	if (v_ftdmroleexist = 0) then ';

				SELECT tr.rolelevel,r.id INTO v_existingrolelevel,v_existingroleid FROM cjams.rolemapping rm, cjams.role r, cjams.teammemberroletype tr			 
				WHERE rm.roleid = r.id and r.roletypekey = tr.roletypekey and rm.principalid = v_principalid::character varying AND rm.teamtypekey = 'CW' and rm.activeflag = 1 and r.activeflag=1 and tr.activeflag=1 limit 1;
				RAISE NOTICE ' ----->>>>>v_existingrolelevel %<<<<<-----',v_existingrolelevel;
				RAISE NOTICE ' ----->>>>>v_rolelevel %<<<<<-----',v_rolelevel;
				RAISE NOTICE ' ----->>>>>v_roleid %<<<<<-----',v_roleid;
				RAISE NOTICE ' ----->>>>>v_existingroleid %<<<<<-----',v_existingroleid;
				BEGIN
					FOR rec IN (SELECT * FROM cjams.role_resource WHERE activeflag=1 AND roleid = v_roleid)
						
					LOOP
					--	 IF rec IS NOT NULL THEN
						UPDATE cjams.userresource 
						SET activeflag =0, isallowed = false, isvisible = false, isenabled = false, updatedon = now(), updatedby = 'ADMIN'
						WHERE userid = v_principalid AND permissiongroupid = rec.resourceid AND activeflag = 1;
										
						v_message:= v_message || chr(10) || 'Update on userresource table is done sucessfully';

						IF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel < v_rolelevel)) THEN
							RAISE NOTICE ' ----->>>>>inserting to userresource .... for %<<<<<-----',v_roleid;
										
							INSERT INTO cjams.userresource
							( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
							VALUES( v_principalid, rec.resourceid, v_roleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
							v_message:= v_message || chr(10) || 'Inserted Into userresource table sucessfully';

						ELSIF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel > v_rolelevel)) THEN
							BEGIN
							FOR rec2 IN (SELECT * FROM cjams.role_resource WHERE activeflag=1 AND roleid = v_existingroleid)
							LOOP
								UPDATE cjams.userresource 
								SET activeflag =0, isallowed = false, isvisible = false, isenabled = false, updatedon = now(), updatedby = 'ADMIN'
								WHERE userid = v_principalid AND permissiongroupid = rec2.resourceid AND activeflag = 1;

								v_message:= v_message || chr(10) || 'Updated userresource table sucessfully';
												
								RAISE NOTICE ' ----->>>>>inserting to userresource .... for existing role %<<<<<-----',v_existingroleid;
								INSERT INTO cjams.userresource
								( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
								VALUES( v_principalid, rec2.resourceid, v_existingroleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
								v_message:= v_message || chr(10) || 'Inserted Into userresource table sucessfully';

							END LOOP;
							END;
						END IF;
						--	 END IF;	  
					END LOOP;
						
				END;
						
				IF (v_existingrolelevel IS NULL OR v_existingrolelevel >= v_rolelevel) THEN
					UPDATE cjams.rolemapping 
					SET activeflag=0, updatedon = now(), updatedby = 'ADMIN'
					WHERE principalid = v_principalid::character varying AND teamtypekey = 'CW' and activeflag = 1;
						
					v_message:= v_message || chr(10) || 'Updated rolemapping table sucessfully';

					IF (v_isaddorremove = 'add') THEN
						
						INSERT INTO cjams.rolemapping (principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey) 
						values ('USER', v_principalid::character varying, v_roleid, 1, 'ADMIN','ADMIN', now(), now(),'','CW');	
						v_message:= 'Role added Sucessfully';
						v_message:= v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';

					ELSE IF (v_isaddorremove = 'remove') THEN
						
						SELECT DISTINCT ur.roleid INTO v_nextroleid FROM cjams.userresource ur, cjams.role r, cjams.teammemberroletype tr 
						WHERE ur.userid = v_principalid AND ur.activeflag=1 AND ur.isallowed = true AND ur.isvisible = true AND ur.isenabled = true
						AND ur.roleid = r.id AND r.roletypekey = tr.roletypekey AND r.activeflag=1 AND tr.activeflag=1 and tr.teamtypekey IN ('CW','IV-E','FNS')
						ORDER BY tr.rolelevel LIMIT 1;                      
							
						IF v_nextroleid IS NOT NULL THEN
							
							INSERT INTO cjams.rolemapping (principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey) 
							values ('USER', v_principalid::character varying, v_nextroleid, 1, 'ADMIN','ADMIN', now(), now(),'','CW');	
							v_message:= 'Role Removed Sucessfully';
							v_message:= v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';

						END IF;	  
					END IF;
				END IF; 
			END IF;
					
			SELECT r.roletypekey INTO v_finalroletypekey FROM cjams.rolemapping rm, cjams.role r 
			WHERE rm.roleid = r.id AND rm.activeflag=1 AND rm.teamtypekey = 'CW' AND rm.principalid = v_principalid::character varying AND r.activeflag = 1;

		end if;
		
	   else
		-- changes end here
	   raise notice '>>>>>> inside else part';
	   
			IF (v_agencycode = 'IV-E' OR v_agencycode = 'FNS') THEN
				SELECT tr.rolelevel,r.id INTO v_existingrolelevel,v_existingroleid FROM cjams.rolemapping rm, cjams.role r, cjams.teammemberroletype tr			 
				WHERE rm.roleid = r.id and r.roletypekey = tr.roletypekey and rm.principalid = v_principalid::character varying AND rm.teamtypekey = 'CW' and rm.activeflag = 1 and r.activeflag=1 and tr.activeflag=1 limit 1;
				RAISE NOTICE ' ----->>>>>v_existingrolelevel %<<<<<-----',v_existingrolelevel;
				RAISE NOTICE ' ----->>>>>v_rolelevel %<<<<<-----',v_rolelevel;
				RAISE NOTICE ' ----->>>>>v_roleid %<<<<<-----',v_roleid;
				RAISE NOTICE ' ----->>>>>v_existingroleid %<<<<<-----',v_existingroleid;
				BEGIN
				FOR rec IN (SELECT * FROM cjams.role_resource WHERE activeflag=1 AND roleid = v_roleid)		
				LOOP
					--	 IF rec IS NOT NULL THEN
					UPDATE cjams.userresource 
					SET activeflag =0, isallowed = false, isvisible = false, isenabled = false, updatedon = now(), updatedby = 'ADMIN'
					WHERE userid = v_principalid AND permissiongroupid = rec.resourceid AND activeflag = 1;
           
					v_message:= v_message || chr(10) || 'Updated userresource table sucessfully';

					IF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel < v_rolelevel)) THEN
						RAISE NOTICE ' ----->>>>>inserting to userresource .... for %<<<<<-----',v_roleid;
									 
						INSERT INTO cjams.userresource
						( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
						VALUES( v_principalid, rec.resourceid, v_roleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
						v_message:= v_message || chr(10) || 'Inserted into userresource table sucessfully';
										  
					ELSIF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel > v_rolelevel)) THEN
						BEGIN
						FOR rec2 IN (SELECT * FROM cjams.role_resource WHERE activeflag=1 AND roleid = v_existingroleid)
						LOOP
							UPDATE cjams.userresource 
							SET activeflag =0, isallowed = false, isvisible = false, isenabled = false, updatedon = now(), updatedby = 'ADMIN'
							WHERE userid = v_principalid AND permissiongroupid = rec2.resourceid AND activeflag = 1;

							v_message:= v_message || chr(10) || 'Updated userresource table sucessfully';
							
							RAISE NOTICE ' ----->>>>>inserting to userresource .... for existing role %<<<<<-----',v_existingroleid;
							INSERT INTO cjams.userresource
							( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
							VALUES( v_principalid, rec2.resourceid, v_existingroleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
								v_message:= v_message || chr(10) || 'Inserted Into userresource table sucessfully';

						END LOOP;
						END;
					END IF;
							--	 END IF;	  
				END LOOP;
						
				END;						
			      
				IF (v_existingrolelevel IS NULL OR v_existingrolelevel >= v_rolelevel) THEN
					UPDATE cjams.rolemapping 
					SET activeflag=0, updatedon = now(), updatedby = 'ADMIN'
					WHERE principalid = v_principalid::character varying AND teamtypekey = 'CW' and activeflag = 1;
					
					v_message:= v_message || chr(10) || 'Updated rolemapping table sucessfully';

					IF (v_isaddorremove = 'add') THEN
					  
						INSERT INTO cjams.rolemapping (principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey) 
						values ('USER', v_principalid::character varying, v_roleid, 1, 'ADMIN','ADMIN', now(), now(),'','CW');	
						v_message:=  v_message || chr(10) || 'Role added Sucessfully';
						v_response:= v_response || chr(10) || 'Role added Sucessfully';
						v_message:= v_message || chr(10) || 'Inserted into rolemapping table sucessfully';

					ELSE IF (v_isaddorremove = 'remove') THEN
					  
						SELECT DISTINCT ur.roleid INTO v_nextroleid FROM cjams.userresource ur, cjams.role r, cjams.teammemberroletype tr 
						WHERE ur.userid = v_principalid AND ur.activeflag=1 AND ur.isallowed = true AND ur.isvisible = true AND ur.isenabled = true
						AND ur.roleid = r.id AND r.roletypekey = tr.roletypekey AND r.activeflag=1 AND tr.activeflag=1 and tr.teamtypekey IN ('CW','IV-E','FNS')
						ORDER BY tr.rolelevel LIMIT 1;                      
					     
						IF v_nextroleid IS NOT NULL THEN
						 
							INSERT INTO cjams.rolemapping (principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey) 
							values ('USER', v_principalid::character varying, v_nextroleid, 1, 'ADMIN','ADMIN', now(), now(),'','CW');	
							v_message:= v_message || chr(10) || 'Role Removed Sucessfully';
							v_response:= v_response || chr(10) || 'Role Removed Sucessfully';
							v_message:= v_message || chr(10) || 'Inserted into rolemapping table sucessfully';
						END IF;
						  
					END IF;
					END IF; 
				END IF;
				  
				SELECT r.roletypekey INTO v_finalroletypekey FROM cjams.rolemapping rm, cjams.role r 
				WHERE rm.roleid = r.id AND rm.activeflag=1 AND rm.teamtypekey = 'CW' AND rm.principalid = v_principalid::character varying AND r.activeflag = 1;
				  
			ELSE IF (v_agencycode = 'PROV' OR v_agencycode = 'PVPROV') THEN
				SELECT tr.rolelevel,r.id INTO v_existingrolelevel,v_existingroleid FROM cjams.rolemapping rm, cjams.role r, cjams.teammemberroletype tr			 
				WHERE rm.roleid = r.id and r.roletypekey = tr.roletypekey and rm.principalid = v_principalid::character varying AND rm.teamtypekey = 'LDSS' and rm.activeflag = 1 and r.activeflag=1 and tr.activeflag=1 limit 1;
				RAISE NOTICE ' ----->>>>>v_existingrolelevel %<<<<<-----',v_existingrolelevel;
				RAISE NOTICE ' ----->>>>>v_rolelevel %<<<<<-----',v_rolelevel;
				RAISE NOTICE ' ----->>>>>v_roleid %<<<<<-----',v_roleid;
				RAISE NOTICE ' ----->>>>>v_existingroleid %<<<<<-----',v_existingroleid;
				BEGIN
				FOR rec IN (SELECT * FROM cjams.role_resource WHERE activeflag=1 AND roleid = v_roleid)
						
				LOOP
				--		 IF rec IS NOT NULL THEN
					UPDATE cjams.userresource 
					SET activeflag =0, isallowed = false, isvisible = false, isenabled = false, updatedon = now(), updatedby = 'ADMIN'
					WHERE userid = v_principalid AND permissiongroupid = rec.resourceid AND activeflag = 1;

					v_message:= v_message || chr(10) || 'Updated userresource table sucessfully';

					IF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel < v_rolelevel)) THEN
					RAISE NOTICE ' ----->>>>>inserting to userresource .... for %<<<<<-----',v_roleid;
					
						INSERT INTO cjams.userresource
						( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
						VALUES( v_principalid, rec.resourceid, v_roleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
						v_message:= v_message || chr(10) || 'Inserted into userresource table sucessfully';

					ELSIF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel > v_rolelevel)) THEN
						BEGIN
						FOR rec2 IN (SELECT * FROM cjams.role_resource WHERE activeflag=1 AND roleid = v_existingroleid)
						LOOP
							UPDATE cjams.userresource 
							SET activeflag =0, isallowed = false, isvisible = false, isenabled = false, updatedon = now(), updatedby = 'ADMIN'
							WHERE userid = v_principalid AND permissiongroupid = rec2.resourceid AND activeflag = 1;

							v_message:= v_message || chr(10) || 'Updated cjams.userresource is done';
							RAISE NOTICE ' ----->>>>>inserting to userresource .... for existing role %<<<<<-----',v_existingroleid;
							INSERT INTO cjams.userresource
							( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
							VALUES( v_principalid, rec2.resourceid, v_existingroleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
							v_message:= v_message || chr(10) || 'Inserted into userresource table sucessfully';
						END LOOP;
						END;
					END IF;
				--	 END IF;
				END LOOP;
					
				END;
						
			      
				IF (v_existingrolelevel IS NULL OR v_existingrolelevel >= v_rolelevel) THEN
					UPDATE cjams.rolemapping 
					SET activeflag=0, updatedon = now(), updatedby = 'ADMIN'
					WHERE principalid = v_principalid::character varying AND teamtypekey = 'LDSS' and activeflag = 1;
					  
					v_message:= v_message || chr(10) || 'Updated rolemapping table sucessfully';

					IF (v_isaddorremove = 'add') THEN
					
						INSERT INTO cjams.rolemapping (principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey) 
						values ('USER', v_principalid::character varying, v_roleid, 1, 'ADMIN','ADMIN', now(), now(),'','LDSS');	
						v_message:= v_message || chr(10) || 'Role added Sucessfully';
						v_response:= v_response || chr(10) || 'Role added Sucessfully';
						v_message:= v_message || chr(10) || 'Inserted into rolemapping table sucessfully';
					ELSE IF (v_isaddorremove = 'remove') THEN
					  
						SELECT DISTINCT ur.roleid INTO v_nextroleid FROM cjams.userresource ur, cjams.role r, cjams.teammemberroletype tr 
						WHERE ur.userid = v_principalid AND ur.activeflag=1 AND ur.isallowed = true AND ur.isvisible = true AND ur.isenabled = true
						AND ur.roleid = r.id AND r.roletypekey = tr.roletypekey AND r.activeflag=1 AND tr.activeflag=1 and tr.teamtypekey = 'LDSS'
						ORDER BY tr.rolelevel LIMIT 1;                      
						
						IF v_nextroleid IS NOT NULL THEN
						 
							INSERT INTO cjams.rolemapping (principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey) 
							values ('USER', v_principalid::character varying, v_nextroleid, 1, 'ADMIN','ADMIN', now(), now(),'','LDSS');	
							v_message:= v_message || chr(10) || 'Role Removed Sucessfully';
							v_response:= v_response || chr(10) || 'Role Removed Sucessfully';
							v_message:= v_message || chr(10) || 'Inserted Into rolemapping table ';
						END IF;
						  
					END IF;
					END IF; 
				END IF;
				  
				SELECT r.roletypekey INTO v_finalroletypekey FROM cjams.rolemapping rm, cjams.role r 
				WHERE rm.roleid = r.id AND rm.activeflag=1 AND rm.teamtypekey = 'LDSS' AND rm.principalid = v_principalid::character varying AND r.activeflag = 1;
				  
			ELSE
			    if (v_agencycode = 'OLM' and v_roletypekey in ('OLMSSALC','OLMSSAPM')) then
					v_teamtypekey = 'OLMSSA';
				end if;
			  	SELECT tr.rolelevel,r.id INTO v_existingrolelevel,v_existingroleid FROM cjams.rolemapping rm, cjams.role r, cjams.teammemberroletype tr			 
				WHERE rm.roleid = r.id and r.roletypekey = tr.roletypekey and rm.principalid = v_principalid::character varying AND rm.teamtypekey = v_teamtypekey and rm.activeflag = 1 and r.activeflag=1 and tr.activeflag=1 limit 1;
				RAISE NOTICE ' ----->>>>>v_existingrolelevel %<<<<<-----',v_existingrolelevel;
				RAISE NOTICE ' ----->>>>>v_rolelevel %<<<<<-----',v_rolelevel;
				RAISE NOTICE ' ----->>>>>v_roleid %<<<<<-----',v_roleid;
				RAISE NOTICE ' ----->>>>>v_existingroleid %<<<<<-----',v_existingroleid;
				BEGIN
				FOR rec IN (SELECT * FROM cjams.role_resource WHERE activeflag=1 AND roleid = v_roleid)
						
				LOOP
						--		 IF rec IS NOT NULL THEN
					UPDATE cjams.userresource 
					SET activeflag =0, isallowed = false, isvisible = false, isenabled = false, updatedon = now(), updatedby = 'ADMIN'
					WHERE userid = v_principalid AND permissiongroupid = rec.resourceid AND activeflag = 1;

					v_message:= v_message || chr(10) || 'Updated userresource table sucessfully';

					IF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel < v_rolelevel)) THEN
						RAISE NOTICE ' ----->>>>>inserting to userresource .... for %<<<<<-----',v_roleid;
						INSERT INTO cjams.userresource
						( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
						VALUES( v_principalid, rec.resourceid, v_roleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
						v_message:= v_message || chr(10) || 'Inserted into userresource table sucessfully';

					ELSIF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel > v_rolelevel)) THEN
						BEGIN
						FOR rec2 IN (SELECT * FROM cjams.role_resource WHERE activeflag=1 AND roleid = v_existingroleid)
						LOOP
							UPDATE cjams.userresource 
							SET activeflag =0, isallowed = false, isvisible = false, isenabled = false, updatedon = now(), updatedby = 'ADMIN'
							WHERE userid = v_principalid AND permissiongroupid = rec2.resourceid AND activeflag = 1;
                                                
							v_message:= v_message || chr(10) || 'Updated userresource table sucessfully';

							RAISE NOTICE ' ----->>>>>inserting to userresource .... for existing role %<<<<<-----',v_existingroleid;
							INSERT INTO cjams.userresource
							( userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
							VALUES( v_principalid, rec2.resourceid, v_existingroleid, NULL, 1, true, true, true, NULL, 'ADMIN', now(), 'ADMIN', now());
							v_message:= v_message || chr(10) || 'Inserted into userresource table sucessfully';

						END LOOP;
						END;
					END IF;
				--	 END IF;
				END LOOP;
			
				END;
						
			      
				IF (v_existingrolelevel IS NULL OR v_existingrolelevel >= v_rolelevel) THEN
					UPDATE cjams.rolemapping 
					SET activeflag=0, updatedon = now(), updatedby = 'ADMIN'
					WHERE principalid = v_principalid::character varying AND teamtypekey = v_teamtypekey and activeflag = 1;
					
					v_message:= v_message || chr(10) || 'Updated rolemapping table sucessfully';
							 
					IF (v_isaddorremove = 'add') THEN
						RAISE NOTICE ' ----->>>>>inserting to rolemapping .... for %<<<<<-----',v_roleid;
						INSERT INTO cjams.rolemapping (principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey) 
						values ('USER', v_principalid::character varying, v_roleid, 1, 'ADMIN','ADMIN', now(), now(),'',v_teamtypekey);	
						v_message:=  v_message || chr(10) || 'Role added Sucessfully';
						v_response:= v_response || chr(10) || 'Role added Sucessfully';
						v_message:= v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';

					ELSE IF (v_isaddorremove = 'remove') THEN
					  
						SELECT DISTINCT ur.roleid INTO v_nextroleid FROM cjams.userresource ur, cjams.role r, cjams.teammemberroletype tr 
						WHERE ur.userid = v_principalid AND ur.activeflag=1 AND ur.isallowed = true AND ur.isvisible = true AND ur.isenabled = true
						AND ur.roleid = r.id AND r.roletypekey = tr.roletypekey AND r.activeflag=1 AND tr.activeflag=1 and tr.teamtypekey = v_agencycode
						ORDER BY tr.rolelevel LIMIT 1;                      
						
						IF v_nextroleid IS NOT NULL THEN
						
							INSERT INTO cjams.rolemapping (principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey) 
							values ('USER', v_principalid::character varying, v_nextroleid, 1, 'ADMIN','ADMIN', now(), now(),'',v_teamtypekey);	
							v_message:=  v_message || chr(10) || 'Role Removed Sucessfully';
							v_response:= v_response || chr(10) || 'Role Removed Sucessfully';
							v_message:= v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';
						
						END IF;
						  
					END IF;
					END IF; 
				END IF;
				 
				SELECT r.roletypekey INTO v_finalroletypekey FROM cjams.rolemapping rm, cjams.role r 
				WHERE rm.roleid = r.id AND rm.activeflag=1 AND rm.teamtypekey = v_teamtypekey AND rm.principalid = v_principalid::character varying AND r.activeflag = 1;
				  
			END IF; 
		    END IF;		
			 
		end if;
		   
	END IF;
		
	IF (v_supervisorid IS NOT NULL) THEN
			UPDATE cjams.userprofile
			SET supervisorid = v_supervisorid, primarycountycd = v_statecountycode, updatedon = now(), updatedby = 'ADMIN'
			WHERE securityusersid = v_securityusersid and activeflag=1;
			v_message:= v_message || chr(10) || 'Supervisor Updated Sucessfully';
			v_response:= v_response || chr(10) || 'Supervisor Updated Sucessfully';
			v_message:= v_message || chr(10) || 'Updated userprofile table sucessfully';
	END IF;
		  
	IF (v_agencycode = 'AS' AND v_assupervisorid IS NOT NULL) THEN
			UPDATE cjams.userprofile
			SET assupervisorid = v_assupervisorid, primarycountycd = v_statecountycode, updatedon = now(), updatedby = 'ADMIN'
			WHERE securityusersid = v_securityusersid and activeflag=1;
			v_message:= v_message || chr(10) || 'AS Supervisor Updated Sucessfully';
			v_response:= v_response || chr(10) || 'AS Supervisor Updated Sucessfully';
			v_message:= v_message || chr(10) || 'Updated userprofile table sucessfully';

	END IF;
	   
	 RAISE NOTICE ' ----->>>>>v_finalroletypekey %<<<<<-----',v_finalroletypekey;
	IF (v_finalroletypekey IS NOT NULL AND v_finalroletypekey != '' AND v_agencycode IS NOT NULL AND v_agencycode IN ('CW','AS','FNS','IV-E','LDSS','PVPROV','PROV','OLM')) THEN 
	  	
		SELECT teamid  INTO v_teamid FROM cjams.team WHERE teamnumber = v_teamnumber AND activeflag = 1	LIMIT 1;
	   
		IF (v_teamid IS NULL) THEN
			
			SELECT countyid INTO v_countyid 
			FROM cjams.county  WHERE statecountycode = v_statecountycode and activeflag = 1;
				
			INSERT INTO cjams.team(teamid,
			activeflag, teamname, teamnumber, teamtypekey, description, 
			officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, 
			updatedon, effectivedate,  region, regionid, countyid, supervisorid)
			VALUES (gen_random_uuid(),
			1, v_teamname, v_teamnumber, v_agencycode, v_teamname, 
			'08:00:00'::time without time zone, '16:00:00'::time without time zone, v_countyid::character varying, 'ADMIN', now(), 'ADMIN', 
			now(), now(), 0, null, v_countyid::character varying, null) returning teamid into v_teamid;
			v_message:= v_message || chr(10) || 'Inserted Into team table sucessfully';
					
		END IF;
		IF (v_agencycode IN ('CW','FNS','IV-E','AS')) then
			INSERT INTO cjams.teammember (teammemberid, activeflag, teamid, loadnumber, roletypekey, 
			positioncode, description, isoncall, insertedby, insertedon, 
			updatedby, updatedon, effectivedate, rtfdate, coadate, isdefaultroute)
			VALUES (gen_random_uuid(), 1, v_teamid, v_loadnumber, v_finalroletypekey ,
			v_positioncode, '', true, '', now(), 
			'ADMIN',  now(),  now(), now(), now(), 1)  returning teammemberid into v_teammemberid; 
			v_message:= v_message || chr(10) || 'Inserted Into teammember table sucessfully';
				
			IF (v_agencycode = 'AS') THEN			
				SELECT teammemberassignmentid INTO v_teammemberassignmentid FROM cjams.as_teammemberassignment where securityusersid = v_securityusersid and activeflag=1;
				RAISE NOTICE ' ----->>>>>v_teammemberassignmentid %<<<<<-----',v_teammemberassignmentid;
				IF (v_teammemberassignmentid IS NOT NULL) THEN
			
					UPDATE cjams.as_teammemberassignment 
					SET teammemberid = v_teammemberid, activeflag = 1, updatedon=now(), updatedby='ADMIN'
					WHERE teammemberassignmentid = v_teammemberassignmentid;
					
					v_message:= v_message || chr(10) || 'Updated as_teammemberassignment table sucessfully';
					
				ELSE 
			
					INSERT INTO cjams.as_teammemberassignment(teammemberassignmentid, activeflag, teammemberid, securityusersid, insertedby, insertedon, updatedby, updatedon, effectivedate) 
					VALUES (gen_random_uuid(), 1, v_teammemberid, v_securityusersid, 'ADMIN', now(), 'ADMIN', now(), now());
					v_message:= v_message || chr(10) || 'Inserted Into as_teammemberassignment table sucessfully';

				END IF;	
			ELSE 
				SELECT teammemberassignmentid INTO v_teammemberassignmentid FROM cjams.teammemberassignment where securityusersid = v_securityusersid and activeflag=1;
				RAISE NOTICE ' ----->>>>>v_teammemberassignmentid %<<<<<-----',v_teammemberassignmentid;
				IF (v_teammemberassignmentid IS NOT NULL) THEN
					if (v_roletypekey not in ('FTDMFW','QUINW','FTDMQIS') ) then
						raise notice '>>>>>> Inside if (v_roletypekey not in (FTDMFW,QUINW,FTDMQIS) and v_ftdmroleexist > 0) then';
						UPDATE cjams.teammemberassignment 
						SET teammemberid = v_teammemberid, activeflag = 1, updatedon=now(), updatedby='ADMIN'
						WHERE teammemberassignmentid = v_teammemberassignmentid;
					
						v_message:= v_message || chr(10) || 'Updated teammemberassignment table sucessfully';
					end if;	
				ELSE 
			
					INSERT INTO cjams.teammemberassignment(teammemberassignmentid, activeflag, teammemberid, securityusersid, insertedby, insertedon, updatedby, updatedon, effectivedate) 
					VALUES (gen_random_uuid(), 1, v_teammemberid, v_securityusersid, 'ADMIN', now(), 'ADMIN', now(), now());
					v_message:= v_message || chr(10) || 'Inserted Into teammemberassignment table sucessfully';

				END IF;	
			END IF;  
		END IF;			  
		v_message:= v_message || chr(10) || 'Team updated successfully';
		v_response:= v_response || chr(10) || 'Team updated successfully';
	END IF;
	END IF;
	update cjams.inputfromsailpoint set message = v_message, response = v_response, updatedby = 'updateteamassignment' , updatedon = now() where inputid = v_inputid;
	return v_response;
END;

$function$
;
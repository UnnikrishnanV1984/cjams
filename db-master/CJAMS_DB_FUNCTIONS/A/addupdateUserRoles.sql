DROP FUNCTION IF EXISTS cjams.addupdateUserRoles(character varying, character varying, character varying[], character varying[]);
DROP FUNCTION IF EXISTS cjams.addupdateUserRoles(character varying, character varying, _text, _text);

CREATE OR REPLACE FUNCTION cjams.addupdateUserRoles(v_email character varying, v_agencycode character varying, v_addroles character varying[], v_removeroles character varying[])
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 3/21/2025 - Anil Kumar Dharni - CIDM-10293 - Created stored procedure to update user details. SP checks valid user, agencycode checks and updates team details by calling a updateteamassignment SP.
-- 03/31/2025-Manasa Kasula - CIDM-10293- Proc Readable comments are added. 
-- 06/12/2025 Manasa Kasula - CIDM-10550 SP Fix - To fix the logic to add the beacon allow access role
-------------------------------------------------------------------------------------------------------------

DECLARE 
v_teamid uuid;
v_teammemberid uuid;
v_securityusersid uuid;
v_roleid integer;
v_loadnumber character varying;
v_principalid bigint;
rec RECORD;
rec2 RECORD;
v_teammemberassignmentid uuid;
v_rolelevel integer;
v_finalroletypekey character varying;
v_existingrolelevel integer;
v_existingroleid integer;
v_nextroleid integer;
v_nextrolelevel integer;
v_countyid uuid;
v_roletypekey character varying;
v_permissiongroupid character varying;
v_teamkey character varying;
v_teamtypekey character varying;
v_ftdmroleexist integer;
v_message text;
l_SPCount bigint;
v_inputid character varying;
v_response character varying;
v_openamrole character varying;
v_isaddorremove character varying;
v_positioncode character varying;
l_RoleExistCount bigint;


BEGIN 
v_roletypekey := NULL;
v_message := '';
v_response := '';
-- Insert into the inputfromsailpoint table for logging the sailpoint request parameters.
INSERT INTO cjams.inputfromsailpoint (inputid,v_email,v_agencycode, insertedby,insertedon,updatedby,updatedon,methodname, v_addroles, v_removeroles)
VALUES (gen_random_uuid(),v_email,v_agencycode, 'direct',now(),'direct',now(),'addupdateUserRoles',  v_addroles, v_removeroles)
RETURNING inputid INTO v_inputid;

v_message := v_message || chr(10) || 'Inserted Into inputfromsailpoint is done';
RAISE NOTICE ' ----->>>>>v_message %<<<<<-----', v_message;
	-- Fetch the securityusersid based on the email
SELECT securityusersid, lower(firstname) || lower(lastname)::character varying INTO v_securityusersid, v_loadnumber
FROM cjams.userprofile
WHERE lower(email) = lower(v_email) AND activeflag = 1 LIMIT 1;

 -- Fetch the principal id based on user deatils
SELECT id INTO v_principalid
FROM cjams.muser
where securityusersid::uuid = v_securityusersid::uuid and activeflag = 1 LIMIT 1;

-- Fetch the teamid based on the user securityuserid
-- If agencycode is AS perform joins on as_teammemberassignment table else on teammemberassignment table
IF LOWER(v_agencycode) = 'as' THEN        
    SELECT tm.teamid, tm.positioncode INTO v_teamid, v_positioncode
    FROM cjams.as_teammemberassignment tma
    INNER JOIN teammember tm ON tma.teammemberid = tm.teammemberid AND tm.activeflag = 1
    INNER JOIN team t ON t.teamid = tm.teamid AND tm.activeflag = 1
    WHERE tma.securityusersid::uuid = v_securityusersid::uuid 
    AND tma.activeflag = 1;
ELSE        
    SELECT tm.teamid, tm.positioncode INTO v_teamid, v_positioncode
    FROM cjams.teammemberassignment tma
    INNER JOIN teammember tm ON tma.teammemberid = tm.teammemberid AND tm.activeflag = 1
    INNER JOIN team t ON t.teamid = tm.teamid AND tm.activeflag = 1
    WHERE tma.securityusersid::uuid = v_securityusersid::uuid 
    AND tma.activeflag = 1;

END IF;

-- If agency code is null then return an error message and no further action performed.
IF v_agencycode IS NULL THEN
    v_message := v_message || chr(10) || 'Error: Agency code(Program/Sub Program) is null. Unable to proceed!';
    v_response := 'Error: Agency code(Program/Sub Program) is null. Unable to proceed: Error Code: 35001';

ELSIF coalesce(v_securityusersid::character varying, '') = '' THEN
    v_message := v_message || chr(10) || 'Error: New user, please add user before adding roles';
    v_response := 'Error: New user, please add user before adding roles: Error Code: 35002';

ELSIF coalesce(v_teamid::character varying, '') = '' THEN
    v_message := v_message || chr(10) || 'Error: No Team exist for the user. Unable to proceed!';
    v_response := 'Error: No Team exist for the user. Unable to proceed!: Error Code: 35003';
END IF;



If(v_agencycode is not null and coalesce(v_securityusersid::character varying, '') != '' and coalesce(v_teamid::character varying, '') != '') THEN    
    -- Loop for each new role that needs to be added
    FOREACH v_openamrole IN ARRAY v_addroles 
    LOOP
        v_isaddorremove = 'add';
        SELECT r.id, r.roletypekey, tr.teamtypekey INTO v_roleid, v_roletypekey, v_teamtypekey
        from cjams.role r,
            cjams.teammemberroletype tr
        where tr.roletypekey = r.roletypekey
            and lower(r.openamrole) = lower(v_openamrole)
            and r.activeflag = 1
            and tr.activeflag = 1
            and tr.teamtypekey = v_agencycode
        limit 1;
        -- If the user role is null then return the error message and no further action is performed.
        IF (v_roletypekey IS NULL) THEN 
            v_message := v_message || chr(10) || 'Error: Requested agency with role combination is not exist. Unable to proceed!';
            v_response := 'Error: Requested agency with role combination is not exist. Unable to proceed!: Error Code: 35002';
        ELSE               
            -- Fetch the user role
            SELECT r.id, tmrt.rolelevel INTO v_roleid, v_rolelevel
            FROM cjams.role r,
                cjams.teammemberroletype tmrt
            WHERE r.roletypekey = tmrt.roletypekey
                AND r.roletypekey = v_roletypekey
                AND r.activeflag = 1
                AND tmrt.activeflag = 1 LIMIT 1;
        
            --to identify the existing FTDM ROLES
            select coalesce(count(*), 0) into v_ftdmroleexist
            from cjams.rolemapping
            where roleid in (5987, 5988, 5989) and teamtypekey = 'CW' and activeflag = 1 and principalid = v_principalid::character varying;
            -- If roleid is not null then determining the finalrole based on role level and inserting into userresource table
            IF (v_roleid IS NOT NULL) THEN 
                RAISE NOTICE ' ----->>>>>v_agencycode %<<<<<-----',v_agencycode;
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
                elsif(v_roletypekey in ('ASDIR1KAPR','CWDIR1KAPR','CWPM','CWSSAPMR')) then 
                    raise notice '>>>>>Inside >>>>> if(v_roletypekey in (ASDIR1KAPR, CWDIR1KAPR,CWPM, CWSSAPMR))  then';
                    -- Fetch Supervisor count
                    SELECT count(*) INTO l_SPCount
                    FROM cjams.rolemapping rm,
                        cjams.role r
                    WHERE rm.roleid = r.id
                    AND rm.activeflag = 1
                    AND rm.principalid = v_principalid::character varying --and r.roletypekey='ASSP'
                    AND CASE
                        WHEN v_agencycode = 'AS' then r.roletypekey = 'ASSP'
                        WHEN v_agencycode in ('IV-E', 'FNS', 'CW') then r.roletypekey = 'CWSP'
                        ELSE false
                    END
                    AND r.activeflag = 1;
                    -- If user is a supervisor then we can add the finance director approval roles
                    IF(l_SPCount > 0) THEN 
                        if(v_roletypekey = 'CWSSAPMR') then 
                            v_permissiongroupid = '7e53df93-9632-4dcb-9e35-c580f1d5680e';
                        end if;
                        if(v_roletypekey = 'CWPM') then 
                            v_permissiongroupid = '5c760141-a1ff-4ae2-bbc8-5692391e3dc1';
                        end if;
                        if(v_roletypekey in ('ASDIR1KAPR', 'CWDIR1KAPR')) then 
                            v_permissiongroupid = '57a390b8-3387-428a-97a8-0b8559fd1f1e';
                        end if;

                        INSERT INTO cjams.userresource (userid,permissiongroupid,roleid,resourceid, activeflag, isallowed, isvisible, isenabled, old_id, insertedby,insertedon, updatedby, updatedon)
                        VALUES (v_principalid, v_permissiongroupid::uuid, v_roleid, NULL,1, true, true, true, NULL,'ADMIN', now(),'ADMIN', now());
                        v_message := v_message || chr(10) || 'Inserted Into userresource table successfully from updateteamassignment';
                        IF (v_agencycode = 'IV-E' OR v_agencycode = 'FNS') THEN 
                            v_teamkey = 'CW';
                        ELSIF (v_agencycode = 'PROV' OR v_agencycode = 'PVPROV') THEN
                            v_teamkey = 'LDSS';
                        ELSE 
                            v_teamkey = v_agencycode;
                        END IF;

                        SELECT r.roletypekey INTO v_finalroletypekey
                        FROM cjams.rolemapping rm,
                            cjams.role r
                        WHERE rm.roleid = r.id AND rm.activeflag = 1
                            AND rm.teamtypekey = v_teamkey AND rm.principalid = v_principalid::character varying AND r.activeflag = 1;

                        v_message := v_message || chr(10) || 'Role added Sucessfully.';
                        v_response := 'Role added Sucessfully.';
                    ELSE 
                        v_message := v_message || chr(10) || 'Please add Supervisor role prior to assigning this role.';
                        v_response := 'Error: Please add Supervisor role prior to assigning this role: Error Code: 35004.';
                    END IF;
                    -- Ending if for user is a supervisor then we can add the finance director approval roles  
                -- Ending Finance director approval roles 
                /* FTDM new roles onboarding */
                elsif (v_roletypekey in ('FTDMFW', 'QUINW', 'FTDMQIS')) then 
                    raise notice '>>>>> Inside >>>>>>> elsif (v_roletypekey in (FTDMFW,QUINW,FTDMQIS)) then>>>v_ftdmroleexist %',v_ftdmroleexist;
                    -- if ftdm role doesnt exist insert into userresource table.
                    if (v_ftdmroleexist = 0) then 
                        raise notice '>>>>>>Inside if (v_ftdmroleexist = 0) then ';
                        -- no any primary role
                        if(v_roletypekey = 'FTDMFW') then 
                            v_permissiongroupid = '90ed1d47-e282-48df-a54a-a2151bde847f';
                        end if;
                        if(v_roletypekey = 'QUINW') then 
                            v_permissiongroupid = '4ba216d8-5eb2-4164-b01b-e19452425387';
                        end if;
                        if(v_roletypekey in ('FTDMQIS')) then 
                            v_permissiongroupid = '2105ed26-fdaf-41d5-aca8-19b334f78daa';
                        end if;
                        -- first soft delete the existing permission for the same permission
                        UPDATE cjams.userresource
                        SET activeflag = 0,
                            updatedon = now(),
                            updatedby = 'ADMIN'
                        WHERE userid = v_principalid
                            AND permissiongroupid = v_permissiongroupid::uuid
                            AND activeflag = 1;
                        v_message := v_message || chr(10) || 'Update on userresource table is done sucessfully';
                        v_response := v_response || chr(10) || 'Update on userresource table is done sucessfully';
                        -- then insert the permission
                        INSERT INTO cjams.userresource (
                                userid,
                                permissiongroupid,
                                roleid,
                                resourceid,
                                activeflag,
                                isallowed,
                                isvisible,
                                isenabled,
                                old_id,
                                insertedby,
                                insertedon,
                                updatedby,
                                updatedon
                            )
                        VALUES (
                                v_principalid,
                                v_permissiongroupid::uuid,
                                v_roleid,
                                NULL,
                                1,
                                true,
                                true,
                                true,
                                NULL,
                                'ADMIN',
                                now(),
                                'ADMIN',
                                now()
                            );
                        v_message := v_message || chr(10) || 'Inserted Into userresource table sucessfully';
                    -- if ftdm role exist then based on the role prefrence entry is made into userresource table
                        v_response := v_response || chr(10) || 'Inserted Into userresource table sucessfully';
                    else --PRIMARY role is exist	
                        raise notice '>>>>>>Inside 	>>> else >>>>	if (v_ftdmroleexist = 0) then ';
                        SELECT tr.rolelevel,
                            r.id INTO v_existingrolelevel,
                            v_existingroleid
                        FROM cjams.rolemapping rm,
                            cjams.role r,
                            cjams.teammemberroletype tr
                        WHERE rm.roleid = r.id
                            and r.roletypekey = tr.roletypekey
                            and rm.principalid = v_principalid::character varying
                            AND rm.teamtypekey = 'CW'
                            and rm.activeflag = 1
                            and r.activeflag = 1
                            and tr.activeflag = 1
                        limit 1;
                        RAISE NOTICE ' ----->>>>>v_existingrolelevel %<<<<<-----', v_existingrolelevel;
                        RAISE NOTICE ' ----->>>>>v_rolelevel %<<<<<-----', v_rolelevel;
                        RAISE NOTICE ' ----->>>>>v_roleid %<<<<<-----', v_roleid;
                        RAISE NOTICE ' ----->>>>>v_existingroleid %<<<<<-----', v_existingroleid;
                        IF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel < v_rolelevel)) THEN 
                            BEGIN FOR rec IN (
                                SELECT *
                                FROM cjams.role_resource
                                WHERE activeflag = 1
                                    AND roleid = v_roleid
                            ) LOOP 
                                UPDATE cjams.userresource
                                SET activeflag = 0,
                                    isallowed = false,
                                    isvisible = false,
                                    isenabled = false,
                                    updatedon = now(),
                                    updatedby = 'ADMIN'
                                WHERE userid = v_principalid
                                AND permissiongroupid = rec.resourceid
                                AND activeflag = 1;
                                v_message := v_message || chr(10) || 'Update on userresource table is done sucessfully';                            
                                RAISE NOTICE ' ----->>>>>inserting to userresource .... for %<<<<<-----', v_roleid;
                                INSERT INTO cjams.userresource (
                                        userid,
                                        permissiongroupid,
                                        roleid,
                                        resourceid,
                                        activeflag,
                                        isallowed,
                                        isvisible,
                                        isenabled,
                                        old_id,
                                        insertedby,
                                        insertedon,
                                        updatedby,
                                        updatedon
                                    )
                                VALUES (
                                        v_principalid,
                                        rec.resourceid,
                                        v_roleid,
                                        NULL,
                                        1,
                                        true,
                                        true,
                                        true,
                                        NULL,
                                        'ADMIN',
                                        now(),
                                        'ADMIN',
                                        now()
                                    );
                                    v_message := v_message || chr(10) || 'Inserted Into userresource table sucessfully';
                            END LOOP;
                            END;
                        ELSIF (v_isaddorremove = 'add'and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel > v_rolelevel)) THEN 
                            BEGIN FOR rec2 IN (
                                SELECT *
                                FROM cjams.role_resource
                                WHERE activeflag = 1
                                    AND roleid = v_existingroleid
                            ) LOOP
                                UPDATE cjams.userresource
                                SET activeflag = 0,
                                    isallowed = false,
                                    isvisible = false,
                                    isenabled = false,
                                    updatedon = now(),
                                    updatedby = 'ADMIN'
                                WHERE userid = v_principalid
                                    AND permissiongroupid = rec2.resourceid
                                    AND activeflag = 1;
                                v_message := v_message || chr(10) || 'Updated userresource table sucessfully';
                                RAISE NOTICE ' ----->>>>>inserting to userresource .... for existing role %<<<<<-----',
                                v_existingroleid;
                                INSERT INTO cjams.userresource (
                                        userid,
                                        permissiongroupid,
                                        roleid,
                                        resourceid,
                                        activeflag,
                                        isallowed,
                                        isvisible,
                                        isenabled,
                                        old_id,
                                        insertedby,
                                        insertedon,
                                        updatedby,
                                        updatedon
                                    )
                                VALUES (
                                        v_principalid,
                                        rec2.resourceid,
                                        v_existingroleid,
                                        NULL,
                                        1,
                                        true,
                                        true,
                                        true,
                                        NULL,
                                        'ADMIN',
                                        now(),
                                        'ADMIN',
                                        now()
                                    );
                                v_message := v_message || chr(10) || 'Inserted Into userresource table sucessfully';
                            END LOOP;
                            END;
                        END IF;	   
                        IF (v_existingrolelevel IS NULL OR v_existingrolelevel >= v_rolelevel) THEN
                            UPDATE cjams.rolemapping
                            SET activeflag = 0,
                                updatedon = now(),
                                updatedby = 'ADMIN'
                            WHERE principalid = v_principalid::character varying
                                AND teamtypekey = 'CW'
                                and activeflag = 1;
                            v_message := v_message || chr(10) || 'Updated rolemapping table sucessfully';
                            IF (v_isaddorremove = 'add') THEN
                                INSERT INTO cjams.rolemapping (
                                        principaltype,
                                        principalid,
                                        roleid,
                                        activeflag,
                                        insertedby,
                                        updatedby,
                                        insertedon,
                                        updatedon,
                                        old_id,
                                        teamtypekey
                                    )
                                values (
                                        'USER',
                                        v_principalid::character varying,
                                        v_roleid,
                                        1,
                                        'ADMIN',
                                        'ADMIN',
                                        now(),
                                        now(),
                                        '',
                                        'CW'
                                    );
                                v_message := 'Role added Sucessfully';
                                v_response := 'Role added Sucessfully';
                                v_message := v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';
                            ELSE 
                                IF (v_isaddorremove = 'remove') THEN
                                    SELECT DISTINCT ur.roleid, tr.rolelevel INTO v_nextroleid , v_nextrolelevel
                                    FROM cjams.userresource ur,
                                        cjams.role r,
                                        cjams.teammemberroletype tr
                                    WHERE ur.userid = v_principalid
                                        AND ur.activeflag = 1
                                        AND ur.isallowed = true
                                        AND ur.isvisible = true
                                        AND ur.isenabled = true
                                        AND ur.roleid = r.id
                                        AND r.roletypekey = tr.roletypekey
                                        AND r.activeflag = 1
                                        AND tr.activeflag = 1
                                        and tr.teamtypekey IN ('CW', 'IV-E', 'FNS')
                                    ORDER BY tr.rolelevel
                                    LIMIT 1;
                                    IF v_nextroleid IS NOT NULL THEN
                                        INSERT INTO cjams.rolemapping (         
                                                principaltype,
                                                principalid,
                                                roleid,
                                                activeflag,
                                                insertedby,
                                                updatedby,
                                                insertedon,
                                                updatedon,
                                                old_id,
                                                teamtypekey
                                            )
                                        values (
                                                'USER',
                                                v_principalid::character varying,
                                                v_nextroleid,
                                                1,
                                                'ADMIN',
                                                'ADMIN',
                                                now(),
                                                now(),
                                                '',
                                                'CW'
                                            );
                                        v_message := 'Role Removed Sucessfully';
                                        v_message := v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                        SELECT r.roletypekey INTO v_finalroletypekey
                        FROM cjams.rolemapping rm,
                            cjams.role r
                        WHERE rm.roleid = r.id
                            AND rm.activeflag = 1
                            AND rm.teamtypekey = 'CW'
                            AND rm.principalid = v_principalid::character varying
                            AND r.activeflag = 1;
                    end if;
                -- end of ftdm role addition
                else -- changes end here
                    raise notice '>>>>>> inside else part';
                    IF (v_agencycode = 'IV-E' OR v_agencycode = 'FNS') THEN
                        SELECT tr.rolelevel,
                            r.id INTO v_existingrolelevel,
                            v_existingroleid
                        FROM cjams.rolemapping rm,
                            cjams.role r,
                            cjams.teammemberroletype tr
                        WHERE rm.roleid = r.id
                            and r.roletypekey = tr.roletypekey
                            and rm.principalid = v_principalid::character varying
                            AND rm.teamtypekey = 'CW'
                            and rm.activeflag = 1
                            and r.activeflag = 1
                            and tr.activeflag = 1
                        limit 1;
                        RAISE NOTICE ' ----->>>>>v_existingrolelevel %<<<<<-----', v_existingrolelevel;
                        RAISE NOTICE ' ----->>>>>v_rolelevel %<<<<<-----', v_rolelevel;
                        RAISE NOTICE ' ----->>>>>v_roleid %<<<<<-----', v_roleid;
                        RAISE NOTICE ' ----->>>>>v_existingroleid %<<<<<-----', v_existingroleid;
                        IF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel < v_rolelevel)) THEN 
                            BEGIN FOR rec IN (
                                SELECT *
                                FROM cjams.role_resource
                                WHERE activeflag = 1
                                    AND roleid = v_roleid
                            ) LOOP --	 IF rec IS NOT NULL THEN
                                UPDATE cjams.userresource
                                SET activeflag = 0,
                                    isallowed = false,
                                    isvisible = false,
                                    isenabled = false,
                                    updatedon = now(),
                                    updatedby = 'ADMIN'
                                WHERE userid = v_principalid
                                    AND permissiongroupid = rec.resourceid
                                    AND activeflag = 1;
                                v_message := v_message || chr(10) || 'Updated userresource table sucessfully';                            
                                RAISE NOTICE ' ----->>>>>inserting to userresource .... for %<<<<<-----',v_roleid;
                                INSERT INTO cjams.userresource (
                                        userid,
                                        permissiongroupid,
                                        roleid,
                                        resourceid,
                                        activeflag,
                                        isallowed,
                                        isvisible,
                                        isenabled,
                                        old_id,
                                        insertedby,
                                        insertedon,
                                        updatedby,
                                        updatedon
                                    )
                                VALUES (
                                        v_principalid,
                                        rec.resourceid,
                                        v_roleid,
                                        NULL,
                                        1,
                                        true,
                                        true,
                                        true,
                                        NULL,
                                        'ADMIN',
                                        now(),
                                        'ADMIN',
                                        now()
                                    );
                                v_message := v_message || chr(10) || 'Inserted into userresource table sucessfully';
                            END LOOP;
                            END;
                        ELSIF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel > v_rolelevel)) THEN 
                            BEGIN FOR rec2 IN (
                                SELECT *
                                FROM cjams.role_resource
                                WHERE activeflag = 1
                                    AND roleid = v_existingroleid
                            ) LOOP
                                UPDATE cjams.userresource
                                SET activeflag = 0,
                                    isallowed = false,
                                    isvisible = false,
                                    isenabled = false,
                                    updatedon = now(),
                                    updatedby = 'ADMIN'
                                WHERE userid = v_principalid
                                    AND permissiongroupid = rec2.resourceid
                                    AND activeflag = 1;
                                v_message := v_message || chr(10) || 'Updated userresource table sucessfully';
                                RAISE NOTICE ' ----->>>>>inserting to userresource .... for existing role %<<<<<-----',v_existingroleid;
                                INSERT INTO cjams.userresource (
                                        userid,
                                        permissiongroupid,
                                        roleid,
                                        resourceid,
                                        activeflag,
                                        isallowed,
                                        isvisible,
                                        isenabled,
                                        old_id,
                                        insertedby,
                                        insertedon,
                                        updatedby,
                                        updatedon
                                    )
                                VALUES (
                                        v_principalid,
                                        rec2.resourceid,
                                        v_existingroleid,
                                        NULL,
                                        1,
                                        true,
                                        true,
                                        true,
                                        NULL,
                                        'ADMIN',
                                        now(),
                                        'ADMIN',
                                        now()
                                    );
                                v_message := v_message || chr(10) || 'Inserted Into userresource table sucessfully';
                            END LOOP;
                            END;
                        END IF;
                        IF (v_existingrolelevel IS NULL OR v_existingrolelevel >= v_rolelevel) THEN
                            UPDATE cjams.rolemapping
                            SET activeflag = 0,
                                updatedon = now(),
                                updatedby = 'ADMIN'
                            WHERE principalid = v_principalid::character varying
                                AND teamtypekey = 'CW'
                                and activeflag = 1;
                            v_message := v_message || chr(10) || 'Updated rolemapping table sucessfully';
                            IF (v_isaddorremove = 'add') THEN
                                INSERT INTO cjams.rolemapping (
                                        principaltype,
                                        principalid,
                                        roleid,
                                        activeflag,
                                        insertedby,
                                        updatedby,
                                        insertedon,
                                        updatedon,
                                        old_id,
                                        teamtypekey
                                    )
                                values (
                                        'USER',
                                        v_principalid::character varying,
                                        v_roleid,
                                        1,
                                        'ADMIN',
                                        'ADMIN',
                                        now(),
                                        now(),
                                        '',
                                        'CW'
                                    );
                                v_message := v_message || chr(10) || 'Role added Sucessfully';
                                v_response := v_response || chr(10) || 'Role added Sucessfully';
                                v_message := v_message || chr(10) || 'Inserted into rolemapping table sucessfully';
                            ELSE 
                                IF (v_isaddorremove = 'remove') THEN
                                    SELECT DISTINCT ur.roleid, tr.rolelevel INTO v_nextroleid , v_nextrolelevel
                                    FROM cjams.userresource ur,
                                        cjams.role r,
                                        cjams.teammemberroletype tr
                                    WHERE ur.userid = v_principalid
                                        AND ur.activeflag = 1
                                        AND ur.isallowed = true
                                        AND ur.isvisible = true
                                        AND ur.isenabled = true
                                        AND ur.roleid = r.id
                                        AND r.roletypekey = tr.roletypekey
                                        AND r.activeflag = 1
                                        AND tr.activeflag = 1
                                        and tr.teamtypekey IN ('CW', 'IV-E', 'FNS')
                                    ORDER BY tr.rolelevel
                                    LIMIT 1;
                                    IF v_nextroleid IS NOT NULL THEN
                                        INSERT INTO cjams.rolemapping (
                                                principaltype,
                                                principalid,
                                                roleid,
                                                activeflag,
                                                insertedby,
                                                updatedby,
                                                insertedon,
                                                updatedon,
                                                old_id,
                                                teamtypekey
                                            )
                                        values (
                                                'USER',
                                                v_principalid::character varying,
                                                v_nextroleid,
                                                1,
                                                'ADMIN',
                                                'ADMIN',
                                                now(),
                                                now(),
                                                '',
                                                'CW'
                                            );
                                        v_message := v_message || chr(10) || 'Role Removed Sucessfully';
                                        v_response := v_response || chr(10) || 'Role Removed Sucessfully';
                                        v_message := v_message || chr(10) || 'Inserted into rolemapping table sucessfully';
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                        SELECT r.roletypekey INTO v_finalroletypekey
                        FROM cjams.rolemapping rm,
                            cjams.role r
                        WHERE rm.roleid = r.id
                            AND rm.activeflag = 1
                            AND rm.teamtypekey = 'CW'
                            AND rm.principalid = v_principalid::character varying
                            AND r.activeflag = 1;
                    ELSE 
                        -- Role Setup for Prov and PVProv agency code
                        IF (v_agencycode = 'PROV' OR v_agencycode = 'PVPROV') THEN
                            SELECT tr.rolelevel,
                                r.id INTO v_existingrolelevel,
                                v_existingroleid
                            FROM cjams.rolemapping rm,
                                cjams.role r,
                                cjams.teammemberroletype tr
                            WHERE rm.roleid = r.id
                                and r.roletypekey = tr.roletypekey
                                and rm.principalid = v_principalid::character varying
                                AND rm.teamtypekey = 'LDSS'
                                and rm.activeflag = 1
                                and r.activeflag = 1
                                and tr.activeflag = 1
                            limit 1;
                            RAISE NOTICE ' ----->>>>>v_existingrolelevel %<<<<<-----', v_existingrolelevel;
                            RAISE NOTICE ' ----->>>>>v_rolelevel %<<<<<-----', v_rolelevel;
                            RAISE NOTICE ' ----->>>>>v_roleid %<<<<<-----', v_roleid;
                            RAISE NOTICE ' ----->>>>>v_existingroleid %<<<<<-----', v_existingroleid;
                            IF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel < v_rolelevel)) THEN 
                                BEGIN FOR rec IN (
                                    SELECT *
                                    FROM cjams.role_resource
                                    WHERE activeflag = 1
                                        AND roleid = v_roleid
                                ) LOOP
                                    UPDATE cjams.userresource
                                    SET activeflag = 0,
                                        isallowed = false,
                                        isvisible = false,
                                        isenabled = false,
                                        updatedon = now(),
                                        updatedby = 'ADMIN'
                                    WHERE userid = v_principalid
                                        AND permissiongroupid = rec.resourceid
                                        AND activeflag = 1;
                                    v_message := v_message || chr(10) || 'Updated userresource table sucessfully';                                
                                    RAISE NOTICE ' ----->>>>>inserting to userresource .... for %<<<<<-----',v_roleid;
                                    INSERT INTO cjams.userresource (
                                            userid,
                                            permissiongroupid,
                                            roleid,
                                            resourceid,
                                            activeflag,
                                            isallowed,
                                            isvisible,
                                            isenabled,
                                            old_id,
                                            insertedby,
                                            insertedon,
                                            updatedby,
                                            updatedon
                                        )
                                    VALUES (
                                            v_principalid,
                                            rec.resourceid,
                                            v_roleid,
                                            NULL,
                                            1,
                                            true,
                                            true,
                                            true,
                                            NULL,
                                            'ADMIN',
                                            now(),
                                            'ADMIN',
                                            now()
                                        );
                                    v_message := v_message || chr(10) || 'Inserted into userresource table sucessfully';
                                END LOOP;
                                END;
                            ELSIF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel > v_rolelevel)) THEN 
                                BEGIN FOR rec2 IN (
                                    SELECT *
                                    FROM cjams.role_resource
                                    WHERE activeflag = 1
                                        AND roleid = v_existingroleid
                                ) LOOP
                                    UPDATE cjams.userresource
                                    SET activeflag = 0,
                                        isallowed = false,
                                        isvisible = false,
                                        isenabled = false,
                                        updatedon = now(),
                                        updatedby = 'ADMIN'
                                    WHERE userid = v_principalid
                                        AND permissiongroupid = rec2.resourceid
                                        AND activeflag = 1;
                                    v_message := v_message || chr(10) || 'Updated cjams.userresource is done';
                                    RAISE NOTICE ' ----->>>>>inserting to userresource .... for existing role %<<<<<-----',v_existingroleid;
                                    INSERT INTO cjams.userresource (
                                            userid,
                                            permissiongroupid,
                                            roleid,
                                            resourceid,
                                            activeflag,
                                            isallowed,
                                            isvisible,
                                            isenabled,
                                            old_id,
                                            insertedby,
                                            insertedon,
                                            updatedby,
                                            updatedon
                                        )
                                    VALUES (
                                            v_principalid,
                                            rec2.resourceid,
                                            v_existingroleid,
                                            NULL,
                                            1,
                                            true,
                                            true,
                                            true,
                                            NULL,
                                            'ADMIN',
                                            now(),
                                            'ADMIN',
                                            now()
                                        );
                                    v_message := v_message || chr(10) || 'Inserted into userresource table sucessfully';
                                END LOOP;
                                END;
                            END IF;
                            IF (v_existingrolelevel IS NULL OR v_existingrolelevel >= v_rolelevel) THEN
                                UPDATE cjams.rolemapping
                                SET activeflag = 0,
                                    updatedon = now(),
                                    updatedby = 'ADMIN'
                                WHERE principalid = v_principalid::character varying
                                    AND teamtypekey = 'LDSS'
                                    and activeflag = 1;
                                v_message := v_message || chr(10) || 'Updated rolemapping table sucessfully';
                                IF (v_isaddorremove = 'add') THEN
                                    INSERT INTO cjams.rolemapping (
                                            principaltype,
                                            principalid,
                                            roleid,
                                            activeflag,
                                            insertedby,
                                            updatedby,
                                            insertedon,
                                            updatedon,
                                            old_id,
                                            teamtypekey
                                        )
                                    values (
                                            'USER',
                                            v_principalid::character varying,
                                            v_roleid,
                                            1,
                                            'ADMIN',
                                            'ADMIN',
                                            now(),
                                            now(),
                                            '',
                                            'LDSS'
                                        );
                                    v_message := v_message || chr(10) || 'Role added Sucessfully';
                                    v_response := v_response || chr(10) || 'Role added Sucessfully';
                                    v_message := v_message || chr(10) || 'Inserted into rolemapping table sucessfully';
                                ELSE 
                                    IF (v_isaddorremove = 'remove') THEN
                                        SELECT DISTINCT ur.roleid, tr.rolelevel INTO v_nextroleid , v_nextrolelevel
                                        FROM cjams.userresource ur,
                                            cjams.role r,
                                            cjams.teammemberroletype tr
                                        WHERE ur.userid = v_principalid
                                            AND ur.activeflag = 1
                                            AND ur.isallowed = true
                                            AND ur.isvisible = true
                                            AND ur.isenabled = true
                                            AND ur.roleid = r.id
                                            AND r.roletypekey = tr.roletypekey
                                            AND r.activeflag = 1
                                            AND tr.activeflag = 1
                                            and tr.teamtypekey = 'LDSS'
                                        ORDER BY tr.rolelevel
                                        LIMIT 1;
                                        IF v_nextroleid IS NOT NULL THEN
                                            INSERT INTO cjams.rolemapping (
                                                    principaltype,
                                                    principalid,
                                                    roleid,
                                                    activeflag,
                                                    insertedby,
                                                    updatedby,
                                                    insertedon,
                                                    updatedon,
                                                    old_id,
                                                    teamtypekey
                                                )
                                            values (
                                                    'USER',
                                                    v_principalid::character varying,
                                                    v_nextroleid,
                                                    1,
                                                    'ADMIN',
                                                    'ADMIN',
                                                    now(),
                                                    now(),
                                                    '',
                                                    'LDSS'
                                                );
                                            v_message := v_message || chr(10) || 'Role Removed Sucessfully';
                                            v_response := v_response || chr(10) || 'Role Removed Sucessfully';
                                            v_message := v_message || chr(10) || 'Inserted Into rolemapping table ';        
                                        END IF;
                                    END IF;
                                END IF;
                            END IF;
                            -- End of Role Setup for Prov and PVProv agency code
                            SELECT r.roletypekey INTO v_finalroletypekey
                            FROM cjams.rolemapping rm,
                                cjams.role r
                            WHERE rm.roleid = r.id
                                AND rm.activeflag = 1
                                AND rm.teamtypekey = 'LDSS'
                                AND rm.principalid = v_principalid::character varying
                                AND r.activeflag = 1;
                            -- End for Role Setup for Prov and PVProv agency code                      
                        ELSE 
                            -- Role Setup for OLM agency and role 'OLMSSALC', 'OLMSSAPM'
                            if (v_agencycode = 'OLM' and v_roletypekey in ('OLMSSALC', 'OLMSSAPM')) then 
                                v_teamtypekey = 'OLMSSA';
                            end if;
                            SELECT tr.rolelevel,
                                r.id INTO v_existingrolelevel,
                                v_existingroleid
                            FROM cjams.rolemapping rm,
                                cjams.role r,
                                cjams.teammemberroletype tr
                            WHERE rm.roleid = r.id
                                and r.roletypekey = tr.roletypekey
                                and rm.principalid = v_principalid::character varying
                                AND rm.teamtypekey = v_teamtypekey
                                and rm.activeflag = 1
                                and r.activeflag = 1
                                and tr.activeflag = 1
                            limit 1;
                            RAISE NOTICE ' ----->>>>>v_existingrolelevel %<<<<<-----', v_existingrolelevel;
                            RAISE NOTICE ' ----->>>>>v_rolelevel %<<<<<-----', v_rolelevel;
                            RAISE NOTICE ' ----->>>>>v_roleid %<<<<<-----', v_roleid;
                            RAISE NOTICE ' ----->>>>>v_existingroleid %<<<<<-----', v_existingroleid;                            
                            IF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel < v_rolelevel)) THEN 
                                RAISE NOTICE ' ----->>>>>inserting to userresource .... for %<<<<<-----',v_roleid;
                                BEGIN FOR rec IN (
                                SELECT *
                                FROM cjams.role_resource
                                WHERE activeflag = 1
                                    AND roleid = v_roleid
                                ) LOOP 
                                    UPDATE cjams.userresource
                                    SET activeflag = 0,
                                        isallowed = false,
                                        isvisible = false,
                                        isenabled = false,
                                        updatedon = now(),
                                        updatedby = 'ADMIN'
                                    WHERE userid = v_principalid
                                        AND permissiongroupid = rec.resourceid
                                        AND activeflag = 1;
                                    v_message := v_message || chr(10) || 'Updated userresource table sucessfully';
                                    INSERT INTO cjams.userresource (
                                            userid,
                                            permissiongroupid,
                                            roleid,
                                            resourceid,
                                            activeflag,
                                            isallowed,
                                            isvisible,
                                            isenabled,
                                            old_id,
                                            insertedby,
                                            insertedon,
                                            updatedby,
                                            updatedon
                                        )
                                    VALUES (
                                            v_principalid,
                                            rec.resourceid,
                                            v_roleid,
                                            NULL,
                                            1,
                                            true,
                                            true,
                                            true,
                                            NULL,
                                            'ADMIN',
                                            now(),
                                            'ADMIN',
                                            now()
                                        );
                                    v_message := v_message || chr(10) || 'Inserted into userresource table sucessfully';
                                END LOOP;
                                END;
                            ELSIF (v_isaddorremove = 'add' and (v_existingrolelevel IS NOT NULL AND v_existingrolelevel > v_rolelevel)) THEN 
                                BEGIN FOR rec2 IN (
                                    SELECT *
                                    FROM cjams.role_resource
                                    WHERE activeflag = 1
                                        AND roleid = v_existingroleid
                                ) LOOP
                                    UPDATE cjams.userresource
                                    SET activeflag = 0,
                                        isallowed = false,
                                        isvisible = false,
                                        isenabled = false,
                                        updatedon = now(),
                                        updatedby = 'ADMIN'
                                    WHERE userid = v_principalid
                                        AND permissiongroupid = rec2.resourceid
                                        AND activeflag = 1;
                                    v_message := v_message || chr(10) || 'Updated userresource table sucessfully';
                                    RAISE NOTICE ' ----->>>>>inserting to userresource .... for existing role %<<<<<-----', v_existingroleid;
                                    INSERT INTO cjams.userresource (
                                            userid,
                                            permissiongroupid,
                                            roleid,
                                            resourceid,
                                            activeflag,
                                            isallowed,
                                            isvisible,
                                            isenabled,
                                            old_id,
                                            insertedby,
                                            insertedon,
                                            updatedby,
                                            updatedon
                                        )
                                    VALUES (
                                            v_principalid,
                                            rec2.resourceid,
                                            v_existingroleid,
                                            NULL,
                                            1,
                                            true,
                                            true,
                                            true,
                                            NULL,
                                            'ADMIN',
                                            now(),
                                            'ADMIN',
                                            now()
                                        );
                                    v_message := v_message || chr(10) || 'Inserted into userresource table sucessfully';
                                END LOOP;
                                END;
                            END IF;
                            IF (v_existingrolelevel IS NULL OR v_existingrolelevel >= v_rolelevel) THEN
                                UPDATE cjams.rolemapping
                                SET activeflag = 0,
                                    updatedon = now(),
                                    updatedby = 'ADMIN'
                                WHERE principalid = v_principalid::character varying
                                    AND teamtypekey = v_teamtypekey
                                    and activeflag = 1;
                                v_message := v_message || chr(10) || 'Updated rolemapping table sucessfully';
                                IF (v_isaddorremove = 'add') THEN 
                                    RAISE NOTICE ' ----->>>>>inserting to rolemapping .... for %<<<<<-----',v_roleid;
                                    INSERT INTO cjams.rolemapping (
                                            principaltype,
                                            principalid,
                                            roleid,
                                            activeflag,
                                            insertedby,
                                            updatedby,
                                            insertedon,
                                            updatedon,
                                            old_id,
                                            teamtypekey
                                        )
                                    values (
                                            'USER',
                                            v_principalid::character varying,
                                            v_roleid,
                                            1,
                                            'ADMIN',
                                            'ADMIN',
                                            now(),
                                            now(),
                                            '',
                                            v_teamtypekey
                                        );
                                    v_message := v_message || chr(10) || 'Role added Sucessfully';
                                    v_response := v_response || chr(10) || 'Role added Sucessfully';
                                    v_message := v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';
                                ELSE 
                                    IF (v_isaddorremove = 'remove') THEN
                                        SELECT DISTINCT ur.roleid, tr.rolelevel INTO v_nextroleid , v_nextrolelevel
                                        FROM cjams.userresource ur,
                                            cjams.role r,
                                            cjams.teammemberroletype tr
                                        WHERE ur.userid = v_principalid
                                            AND ur.activeflag = 1
                                            AND ur.isallowed = true
                                            AND ur.isvisible = true
                                            AND ur.isenabled = true
                                            AND ur.roleid = r.id
                                            AND r.roletypekey = tr.roletypekey
                                            AND r.activeflag = 1
                                            AND tr.activeflag = 1
                                            and tr.teamtypekey = v_agencycode
                                        ORDER BY tr.rolelevel
                                        LIMIT 1;
                                        IF v_nextroleid IS NOT NULL THEN
                                            INSERT INTO cjams.rolemapping (
                                                    principaltype,
                                                    principalid,
                                                    roleid,
                                                    activeflag,
                                                    insertedby,
                                                    updatedby,
                                                    insertedon,
                                                    updatedon,
                                                    old_id,
                                                    teamtypekey
                                                )
                                            values (
                                                    'USER',
                                                    v_principalid::character varying,
                                                    v_nextroleid,
                                                    1,
                                                    'ADMIN',
                                                    'ADMIN',
                                                    now(),
                                                    now(),
                                                    '',
                                                    v_teamtypekey
                                                );
                                            v_message := v_message || chr(10) || 'Role Removed Sucessfully';
                                            v_response := v_response || chr(10) || 'Role Removed Sucessfully';
                                            v_message := v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';
                                        END IF;
                                    END IF;
                                END IF;
                            END IF;
                            SELECT r.roletypekey INTO v_finalroletypekey
                            FROM cjams.rolemapping rm,
                                cjams.role r
                            WHERE rm.roleid = r.id
                                AND rm.activeflag = 1
                                AND rm.teamtypekey = v_teamtypekey
                                AND rm.principalid = v_principalid::character varying
                                AND r.activeflag = 1;
                        END IF;
                    END IF;
                end if;
            ELSE 
                v_message := v_message || chr(10) || 'Error: Requested roleid does not exist. Unable to proceed!';
                v_response := 'Error: Requested roleid does not exist. Unable to proceed!: Error Code: 35005';
            END IF;
            -- End for roleid is not null then determining the finalrole based on role level and inserting into userresource table
            RAISE NOTICE ' ----->>>>>v_finalroletypekey %<<<<<-----',v_finalroletypekey;
            -- Inserting the finalrole into teammeber table and teammeyerassignment table for As into as_teammemberassignment table
            IF (v_finalroletypekey IS NOT NULL AND v_finalroletypekey != '' AND v_agencycode IS NOT NULL AND v_agencycode IN ('CW','AS','FNS','IV-E','LDSS','PVPROV','PROV','OLM')) THEN

                IF (v_agencycode IN ('CW', 'FNS', 'IV-E', 'AS')) then
                    INSERT INTO cjams.teammember (
                            teammemberid,
                            activeflag,
                            teamid,
                            loadnumber,
                            roletypekey,
                            positioncode,
                            description,
                            isoncall,
                            insertedby,
                            insertedon,
                            updatedby,
                            updatedon,
                            effectivedate,
                            rtfdate,
                            coadate,
                            isdefaultroute
                        )
                    VALUES (
                            gen_random_uuid(),
                            1,
                            v_teamid,
                            v_loadnumber,
                            v_finalroletypekey,
                            v_positioncode,
                            '',
                            true,
                            '',
                            now(),
                            'ADMIN',
                            now(),
                            now(),
                            now(),
                            now(),
                            1
                        )returning teammemberid into v_teammemberid;
                    v_message := v_message || chr(10) || 'Inserted Into teammember table sucessfully';
                    IF (v_agencycode = 'AS') THEN
                        SELECT teammemberassignmentid INTO v_teammemberassignmentid
                        FROM cjams.as_teammemberassignment
                        where securityusersid = v_securityusersid::varchar
                            and activeflag = 1;
                        RAISE NOTICE ' ----->>>>>v_teammemberassignmentid %<<<<<-----', v_teammemberassignmentid;
                        IF (v_teammemberassignmentid IS NOT NULL) THEN
                            UPDATE cjams.as_teammemberassignment
                            SET teammemberid = v_teammemberid,
                                activeflag = 1,
                                updatedon = now(),
                                updatedby = 'ADMIN'
                            WHERE teammemberassignmentid = v_teammemberassignmentid;
                            v_message := v_message || chr(10) || 'Updated as_teammemberassignment table sucessfully';
                        ELSE
                            INSERT INTO cjams.as_teammemberassignment(
                                    teammemberassignmentid,
                                    activeflag,
                                    teammemberid,
                                    securityusersid,
                                    insertedby,
                                    insertedon,
                                    updatedby,
                                    updatedon,
                                    effectivedate
                                )
                            VALUES (
                                    gen_random_uuid(),
                                    1,
                                    v_teammemberid,
                                    v_securityusersid,
                                    'ADMIN',
                                    now(),
                                    'ADMIN',
                                    now(),
                                    now()
                                );
                            v_message := v_message || chr(10) || 'Inserted Into as_teammemberassignment table sucessfully';
                        END IF;
                    ELSE
                        SELECT teammemberassignmentid INTO v_teammemberassignmentid
                        FROM cjams.teammemberassignment
                        where securityusersid = v_securityusersid::varchar
                            and activeflag = 1;
                        RAISE NOTICE ' ----->>>>>v_teammemberassignmentid %<<<<<-----',
                        v_teammemberassignmentid;
                        IF (v_teammemberassignmentid IS NOT NULL) THEN 
                            if (v_roletypekey not in ('FTDMFW', 'QUINW', 'FTDMQIS')) then 
                                raise notice '>>>>>> Inside if (v_roletypekey not in (FTDMFW,QUINW,FTDMQIS) and v_ftdmroleexist > 0) then';
                                UPDATE cjams.teammemberassignment
                                SET teammemberid = v_teammemberid,
                                    activeflag = 1,
                                    updatedon = now(),
                                    updatedby = 'ADMIN'
                                WHERE teammemberassignmentid = v_teammemberassignmentid;
                                v_message := v_message || chr(10) || 'Updated teammemberassignment table sucessfully';
                            end if;
                        ELSE
                            INSERT INTO cjams.teammemberassignment(
                                    teammemberassignmentid,
                                    activeflag,
                                    teammemberid,
                                    securityusersid,
                                    insertedby,
                                    insertedon,
                                    updatedby,
                                    updatedon,
                                    effectivedate
                                )
                            VALUES (
                                    gen_random_uuid(),
                                    1,
                                    v_teammemberid,
                                    v_securityusersid,
                                    'ADMIN',
                                    now(),
                                    'ADMIN',
                                    now(),
                                    now()
                                );
                            v_message := v_message || chr(10) || 'Inserted Into teammemberassignment table sucessfully';
                        END IF;
                    END IF;
                END IF;
                v_message := v_message || chr(10) || 'Team updated successfully';
                v_response := v_response || chr(10) || 'Team updated successfully';
            END IF;
            -- End of Inserting the finalrole into teammeber table and teammeberassignment table for As into as_teammemberassignment table  
        END IF;
        -- End for If the user role is null then return the error message and no further action is performed.
    END LOOP;
    --END Loop for each new role that needs to be added
    -- Loop for each role that needs to be removed
    FOREACH v_openamrole IN ARRAY v_removeroles
    LOOP
        SELECT r.id, r.roletypekey, tr.teamtypekey, tr.teamtypekey INTO v_roleid, v_roletypekey, v_teamtypekey, v_agencycode
        from cjams.role r,
            cjams.teammemberroletype tr
        where tr.roletypekey = r.roletypekey
        and lower(r.openamrole) = lower(v_openamrole)
        and r.activeflag = 1
        and tr.activeflag = 1
        -- and tr.teamtypekey = v_agencycode
        limit 1;
        -- If the user role is null then return the error message and no further action is performed.
        IF (v_roletypekey IS NULL) THEN
            v_message := v_message || chr(10) || 'Error: Requested role does not exist. Unable to proceed!';
            v_response := 'Error: Requested role does not exist. Unable to proceed!: Error Code: 35010';
        ELSE
            if (v_agencycode = 'IV-E' OR v_agencycode = 'FNS') then
                v_teamtypekey = 'CW';
            ELSIF(v_agencycode = 'PROV' OR v_agencycode = 'PVPROV') then
                v_teamtypekey = 'LDSS';
            ELSIF(v_agencycode = 'OLM' and v_roletypekey in ('OLMSSALC', 'OLMSSAPM')) then
                v_teamtypekey = 'OLMSSA';
            ELSE
                v_teamtypekey = v_agencycode;
            END IF;
            -- Fetch the user role
            SELECT r.id, tmrt.rolelevel INTO v_roleid, v_rolelevel
            FROM cjams.role r,
                cjams.teammemberroletype tmrt
            WHERE r.roletypekey = tmrt.roletypekey
            AND r.roletypekey = v_roletypekey
            AND r.activeflag = 1
            AND tmrt.activeflag = 1 LIMIT 1;

            SELECT r.roletypekey INTO v_finalroletypekey
            FROM cjams.rolemapping rm,
                cjams.role r
            WHERE rm.roleid = r.id AND rm.activeflag = 1
            AND rm.teamtypekey = v_teamtypekey AND rm.principalid = v_principalid::character varying
            AND r.activeflag = 1;

            if (v_roletypekey != v_finalroletypekey) then
                BEGIN FOR rec IN (
                    SELECT *
                    FROM cjams.role_resource
                    WHERE activeflag = 1
                    AND roleid = v_roleid
                    ) LOOP --	 IF rec IS NOT NULL THEN
                        UPDATE cjams.userresource
                        SET activeflag = 0,
                            isallowed = false,
                            isvisible = false,
                            isenabled = false,
                            updatedon = now(),
                            updatedby = 'ADMIN'
                        WHERE userid = v_principalid
                        AND permissiongroupid = rec.resourceid
                        AND activeflag = 1;
                    END LOOP;
                END;
                v_message := v_message || chr(10) || 'Successfully removed permissions for role: ' || v_openamrole;
                v_response := 'Role ' || v_openamrole || ' and its permissions were successfully removed.';

            Else
                UPDATE cjams.rolemapping
                SET activeflag = 0,
                    updatedon = now(),
                    updatedby = 'ADMIN'
                WHERE principalid = v_principalid::character varying
                AND teamtypekey = v_teamtypekey
                and activeflag = 1;
                v_message := v_message || chr(10) || 'Updated rolemapping table sucessfully';

                SELECT DISTINCT ur.roleid, tr.rolelevel INTO v_nextroleid , v_nextrolelevel
                FROM cjams.userresource ur,
                    cjams.role r,
                    cjams.teammemberroletype tr
                WHERE ur.userid = v_principalid
                AND ur.activeflag = 1
                AND ur.isallowed = true
                AND ur.isvisible = true
                AND ur.isenabled = true
                AND ur.roleid = r.id
                AND r.roletypekey = tr.roletypekey
                AND r.activeflag = 1
                AND tr.activeflag = 1
                and (case when v_teamtypekey = 'CW' then tr.teamtypekey IN ('CW', 'IV-E', 'FNS') else tr.teamtypekey = v_teamtypekey end)
                ORDER BY tr.rolelevel
                LIMIT 1;
                IF v_nextroleid IS NOT NULL THEN
                    INSERT INTO cjams.rolemapping (         
                            principaltype,
                            principalid,
                            roleid,
                            activeflag,
                            insertedby,
                            updatedby,
                            insertedon,
                            updatedon,
                            old_id,
                            teamtypekey
                        )
                    values (
                            'USER',
                            v_principalid::character varying,
                            v_nextroleid,
                            1,
                            'ADMIN',
                            'ADMIN',
                            now(),
                            now(),
                            '',
                           v_teamtypekey
                        );
                    BEGIN FOR rec IN (
                        SELECT *
                        FROM cjams.role_resource
                        WHERE activeflag = 1
                            AND roleid = v_nextroleid
                        ) LOOP 
                            UPDATE cjams.userresource
                            SET activeflag = 0,
                                isallowed = false,
                                isvisible = false,
                                isenabled = false,
                                updatedon = now(),
                                updatedby = 'ADMIN'
                            WHERE userid = v_principalid
                                AND permissiongroupid = rec.resourceid
                                AND activeflag = 1;
                        END LOOP;
                    END;
                    v_message := 'Role Removed Sucessfully';
                    v_message := v_message || chr(10) || 'Inserted Into rolemapping table sucessfully';
                ELSE
                    v_message := v_message || chr(10) || 'Primary role removed. No other active role found to assign as the new primary.';
                    v_response := 'Primary role successfully removed.';
                END IF;
            END IF;
            SELECT r.roletypekey INTO v_finalroletypekey
            FROM cjams.rolemapping rm,
                cjams.role r
            WHERE rm.roleid = r.id
            AND rm.activeflag = 1
            AND rm.teamtypekey = v_teamtypekey
            AND rm.principalid = v_principalid::character varying
            AND r.activeflag = 1;
            -- End for roleid is not null then determining the finalrole based on role level and inserting into userresource table
            RAISE NOTICE ' ----->>>>>v_finalroletypekey %<<<<<-----',v_finalroletypekey;
            -- Inserting the finalrole into teammeber table and teammeberassignment table for As into as_teammemberassignment table
            IF (v_finalroletypekey IS NOT NULL AND v_finalroletypekey != '' AND v_agencycode IS NOT NULL AND v_agencycode IN ('CW','AS','FNS','IV-E','LDSS','PVPROV','PROV','OLM')) THEN


                IF (v_agencycode IN ('CW', 'FNS', 'IV-E', 'AS')) then
                    INSERT INTO cjams.teammember (
                            teammemberid,
                            activeflag,
                            teamid,
                            loadnumber,
                            roletypekey,
                            positioncode,
                            description,
                            isoncall,
                            insertedby,
                            insertedon,
                            updatedby,
                            updatedon,
                            effectivedate,
                            rtfdate,
                            coadate,
                            isdefaultroute
                        )
                    VALUES (
                            gen_random_uuid(),
                            1,
                            v_teamid,
                            v_loadnumber,
                            v_finalroletypekey,
                            v_positioncode,
                            '',
                            true,
                            '',
                            now(),
                            'ADMIN',
                            now(),
                            now(),
                            now(),
                            now(),
                            1
                        )returning teammemberid into v_teammemberid;
                    v_message := v_message || chr(10) || 'Inserted Into teammember table sucessfully';
                    IF (v_agencycode = 'AS') THEN
                        SELECT teammemberassignmentid INTO v_teammemberassignmentid
                        FROM cjams.as_teammemberassignment
                        where securityusersid = v_securityusersid::varchar
                        and activeflag = 1;
                        RAISE NOTICE ' ----->>>>>v_teammemberassignmentid %<<<<<-----', v_teammemberassignmentid;
                        IF (v_teammemberassignmentid IS NOT NULL) THEN
                            UPDATE cjams.as_teammemberassignment
                            SET teammemberid = v_teammemberid,
                                activeflag = 1,
                                updatedon = now(),
                                updatedby = 'ADMIN'
                            WHERE teammemberassignmentid = v_teammemberassignmentid;
                            v_message := v_message || chr(10) || 'Updated as_teammemberassignment table successfully.';
                        ELSE
                            INSERT INTO cjams.as_teammemberassignment(
                                    teammemberassignmentid,
                                    activeflag,
                                    teammemberid,
                                    securityusersid,
                                    insertedby,
                                    insertedon,
                                    updatedby,
                                    updatedon,
                                    effectivedate
                                )
                            VALUES (
                                    gen_random_uuid(),
                                    1,
                                    v_teammemberid,
                                    v_securityusersid,
                                    'ADMIN',
                                    now(),
                                    'ADMIN',
                                    now(),
                                    now()
                                );
                            v_message := v_message || chr(10) || 'Inserted Into as_teammemberassignment table sucessfully';
                        END IF;
                    ELSE
                        SELECT teammemberassignmentid INTO v_teammemberassignmentid
                        FROM cjams.teammemberassignment
                        where securityusersid = v_securityusersid::varchar
                        and activeflag = 1;
                        RAISE NOTICE ' ----->>>>>v_teammemberassignmentid %<<<<<-----', v_teammemberassignmentid;
                        IF (v_teammemberassignmentid IS NOT NULL) THEN
                            if (v_roletypekey not in ('FTDMFW', 'QUINW', 'FTDMQIS')) then
                                UPDATE cjams.teammemberassignment
                                SET teammemberid = v_teammemberid,
                                    activeflag = 1,
                                    updatedon = now(),
                                    updatedby = 'ADMIN'
                                WHERE teammemberassignmentid = v_teammemberassignmentid;
                                v_message := v_message || chr(10) || 'Updated teammemberassignment table successfully.';
                            end if;
                        ELSE
                            INSERT INTO cjams.teammemberassignment(
                                    teammemberassignmentid,
                                    activeflag,
                                    teammemberid,
                                    securityusersid,
                                    insertedby,
                                    insertedon,
                                    updatedby,
                                    updatedon,
                                    effectivedate
                                )
                            VALUES (
                                    gen_random_uuid(),
                                    1,
                                    v_teammemberid,
                                    v_securityusersid,
                                    'ADMIN',
                                    now(),
                                    'ADMIN',
                                    now(),
                                    now()
                                );
                            v_message := v_message || chr(10) || 'Inserted into teammemberassignment table successfully.';
                        END IF;
                    END IF;
                END IF;
                v_message := v_message || chr(10) || 'User roles and team assignments have been successfully updated.';
                v_response := 'User roles and team assignments have been successfully updated.';
            END IF;
            -- End of Inserting the finalrole into teammeber table and teammeberassignment table for As into as_teammemberassignment table           
        END IF;
        -- End for If the user role is null then return the error message and no further action is performed.
    END LOOP;
    --END Loop for each delete role that needs to be removed
END IF;
--End for If agency code is null or securityusersid is empty and team is empty then return an error message and no further action performed.
-- Updating the inputfromsailpoint table with response and message
update cjams.inputfromsailpoint
set message = v_message, response = v_response, updatedby = 'addupdateUserRoles', updatedon = now()
where inputid = v_inputid;
return v_response;
END 
$function$
;

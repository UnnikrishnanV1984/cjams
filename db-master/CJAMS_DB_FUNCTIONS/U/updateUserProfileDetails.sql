DROP FUNCTION IF EXISTS cjams.updateUserProfileDetails(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);
DROP FUNCTION IF EXISTS cjams.updateUserProfileDetails(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);
DROP FUNCTION IF EXISTS cjams.updateUserProfileDetails(
    character varying, character varying, character varying, character varying,
    character varying, character varying, character varying, character varying,
    character varying, character varying, character varying, character varying,
    character varying, character varying
);
CREATE OR REPLACE FUNCTION cjams.updateUserProfileDetails(v_email character varying, v_agencycode character varying, v_countycode character varying, v_teamcode character varying, v_teamname character varying, v_ldss character varying, v_add1 character varying,
v_city character varying, v_zipcode character varying, v_cell_phonenumber character varying, v_positioncode character varying, v_super_id character varying, v_as_super_id character varying, v_work_phonenumber character varying DEFAULT NULL::character varying)
RETURNS text LANGUAGE plpgsql AS $function$
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 03/21/2025 - Anil Kumar Dharni - CIDM-10293 - Created stored procedure to update user details. SP checks valid user, agencycode checks and updates team details by calling a updateteamassignment SP.
-- 03/31/2025 - Manasa Kasula     - CIDM-10293 - Proc Readable comments are added.
-- 03/21/2025 - Anil Kumar Dharni - CIDM-10293 - removing v_firstname,v_lastname, v_middlename, v_staffid and v_fullname.
-- 07/17/2025 - Anil Kumar Dharni - CIDM-10293 - Standardized response messages to be more specific and consistent.
-------------------------------------------------------------------------------------------------------------

DECLARE
    v_teamid uuid;
    v_teammemberid uuid;
    v_securityusersid uuid;
    v_roleid integer;
    v_loadnumber character varying;
    v_principalid bigint;
    v_teammemberassignmentid uuid;
    v_finalroletypekey character varying;
    v_countyid uuid;
    v_teamtypekey character varying;
    v_supervisorid uuid;
    v_assupervisorid uuid;
    v_ftdmroleexist integer;
    v_message text;
    v_inputid character varying;
    v_response text;
    v_existing_cell_phonenumber character varying;
    v_existing_work_phonenumber character varying;
    v_existing_address character varying;
    v_existing_city character varying;
    v_existing_zipcode character varying;
    v_current_supervisorid uuid;
    v_existing_userprofileaddressid uuid;
    v_actions_performed TEXT[] := ARRAY[]::TEXT[];
BEGIN
    v_message := '';
    
    IF (v_agencycode = 'IV-E' OR v_agencycode = 'FNS') THEN --cw
        v_teamtypekey := 'CW';
    ELSEIF (v_agencycode = 'PROV' OR v_agencycode = 'PVPROV') THEN -- ldss
        v_teamtypekey := 'LDSS';
    ELSE
        v_teamtypekey := v_agencycode;
    END IF;
    INSERT INTO cjams.inputfromsailpoint (
        inputid, v_email, v_agencycode, v_countycode, v_teamcode, v_teamname, 
        v_ldss, v_add1, v_city, v_zipcode, v_cell_phonenumber, v_work_phonenumber, v_positioncode, 
        v_super_id, v_as_super_id, insertedby, insertedon, updatedby, updatedon, methodname)
    VALUES (
        gen_random_uuid(), v_email, v_agencycode, v_countycode, v_teamcode, v_teamname, 
        v_ldss, v_add1, v_city, v_zipcode, v_cell_phonenumber, v_work_phonenumber, v_positioncode, 
        v_super_id, v_as_super_id, 'direct', now(), 'direct', now(), 'updateUserProfileDetails')
    RETURNING inputid INTO v_inputid;

    v_message := v_message || chr(10) || 'Inserted Into inputfromsailpoint is done';

    -- Fetch user
    SELECT securityusersid, lower(firstname) || lower(lastname)::character varying 
    INTO v_securityusersid, v_loadnumber
    FROM cjams.userprofile
    WHERE lower(email) = lower(v_email) AND activeflag = 1 
    LIMIT 1;

    IF v_securityusersid IS NOT NULL THEN

        -- Phone update
        SELECT phonenumber INTO v_existing_cell_phonenumber
        FROM cjams.userprofilephonenumber
        WHERE securityusersid = v_securityusersid::varchar AND activeflag = 1 AND userprofiletypekey = 'cell'
        ORDER BY insertedon DESC LIMIT 1;

        SELECT phonenumber INTO v_existing_work_phonenumber
        FROM cjams.userprofilephonenumber
        WHERE securityusersid = v_securityusersid::varchar AND activeflag = 1 AND userprofiletypekey = 'work'
        ORDER BY insertedon DESC LIMIT 1;

        IF COALESCE(v_cell_phonenumber, '') <> '' 
           AND (COALESCE(v_existing_cell_phonenumber, '') = '' 
           OR COALESCE(v_existing_cell_phonenumber, '') <> COALESCE(v_cell_phonenumber, '')) THEN

            UPDATE cjams.userprofilephonenumber
            SET activeflag = 0, updatedon = now(), updatedby = 'admin'
            WHERE securityusersid = v_securityusersid::varchar AND activeflag = 1 AND userprofiletypekey = 'cell';

            INSERT INTO cjams.userprofilephonenumber (userprofilephonenumberid, securityusersid, activeflag, userprofiletypekey, phonenumber, updatedby, insertedby, updatedon, insertedon)
            VALUES (gen_random_uuid(), v_securityusersid::varchar, 1, 'cell', v_cell_phonenumber, 'admin', 'admin', now(), now());

            v_message := v_message || chr(10) || 'User Mobile Phonenumber updated successfully';
            v_actions_performed := array_append(v_actions_performed, 'Cell phone updated');
        END IF;

        IF COALESCE(v_work_phonenumber, '') <> '' 
           AND (COALESCE(v_existing_work_phonenumber, '') = '' 
           OR COALESCE(v_existing_work_phonenumber, '') <> COALESCE(v_work_phonenumber, '')) THEN

            UPDATE cjams.userprofilephonenumber
            SET activeflag = 0, updatedon = now(), updatedby = 'admin'
            WHERE securityusersid = v_securityusersid::varchar AND activeflag = 1 AND userprofiletypekey = 'work';

            INSERT INTO cjams.userprofilephonenumber (userprofilephonenumberid, securityusersid, activeflag, userprofiletypekey, phonenumber, updatedby, insertedby, updatedon, insertedon)
            VALUES (gen_random_uuid(), v_securityusersid::varchar, 1, 'work', v_work_phonenumber, 'admin', 'admin', now(), now());

            v_message := v_message || chr(10) || 'User Work Phonenumber updated successfully';
            v_actions_performed := array_append(v_actions_performed, 'Work phone updated');
        END IF;

        SELECT supervisorid INTO v_current_supervisorid
        FROM cjams.userprofile
        WHERE securityusersid::uuid = v_securityusersid::uuid AND activeflag = 1;


        -- Supervisor update
        IF v_super_id IS NOT NULL AND v_super_id <> '' THEN
            SELECT securityusersid INTO v_supervisorid
            FROM cjams.userprofile
            WHERE lower(email) = lower(v_super_id) AND activeflag = 1 LIMIT 1;

            IF v_supervisorid IS NOT NULL AND v_current_supervisorid IS DISTINCT FROM v_supervisorid THEN
                UPDATE cjams.userprofile
                SET supervisorid = v_supervisorid,
                    primarycountycd = v_countycode,
                    updatedon = now(),
                    updatedby = 'ADMIN'
                WHERE securityusersid::uuid = v_securityusersid::uuid AND activeflag = 1;

                v_message := v_message || chr(10) || 'Supervisor Updated Successfully';
                v_actions_performed := array_append(v_actions_performed, 'Supervisor updated');
            END IF;
        END IF;

        -- AS Supervisor update
        IF v_agencycode = 'AS' AND v_as_super_id IS NOT NULL AND v_as_super_id <> '' THEN
            SELECT securityusersid INTO v_assupervisorid
            FROM cjams.userprofile
            WHERE lower(email) = lower(v_as_super_id) AND activeflag = 1 LIMIT 1;

            IF v_assupervisorid IS NOT NULL THEN
                UPDATE cjams.userprofile
                SET assupervisorid = v_assupervisorid,
                    primarycountycd = v_countycode,
                    updatedon = now(),
                    updatedby = 'ADMIN'
                WHERE securityusersid = v_securityusersid::varchar AND activeflag = 1;

                v_message := v_message || chr(10) || 'AS Supervisor Updated Successfully';
                v_actions_performed := array_append(v_actions_performed, 'AS Supervisor updated');
            END IF;
        END IF;

        -- Address update
        SELECT userprofileaddressid, address, city, zipcode
        INTO v_existing_userprofileaddressid, v_existing_address, v_existing_city, v_existing_zipcode
        FROM cjams.userprofileaddress
        WHERE securityusersid::uuid = v_securityusersid AND activeflag = 1
        ORDER BY insertedon DESC
        LIMIT 1;

        IF COALESCE(v_add1, '') <> COALESCE(v_existing_address, '')
        OR COALESCE(v_city, '') <> COALESCE(v_existing_city, '')
        OR COALESCE(v_zipcode, '') <> COALESCE(v_existing_zipcode, '') THEN
            UPDATE cjams.userprofileaddress
            SET activeflag = 0, updatedon = now(), updatedby = 'admin'
            WHERE userprofileaddressid = v_existing_userprofileaddressid AND activeflag = 1;

            INSERT INTO cjams.userprofileaddress (
                securityusersid, userprofileaddresstypekey, address, zipcode, city, state, county, countyid, activeflag, insertedon, updatedon, insertedby, updatedby
            )
            VALUES (
                v_securityusersid, 'P', v_add1, v_zipcode, v_city, 'MD', v_ldss, 
                (SELECT countyid FROM county WHERE statecountycode = v_countycode AND activeflag = 1 LIMIT 1),
                1, now(), now(), 'admin', 'admin'
            );

            v_message := v_message || chr(10) || 'User creation process initiated --> Address is provided and valid --> Inserted into userprofileaddress table successfully';
            v_actions_performed := array_append(v_actions_performed, 'Address updated');
        END IF;

        SELECT id INTO v_principalid
        FROM cjams.muser 
        where securityusersid::uuid = v_securityusersid::uuid and activeflag = 1 LIMIT 1;


        SELECT r.roletypekey INTO v_finalroletypekey
        FROM cjams.rolemapping rm,
             cjams.role r
        WHERE rm.roleid = r.id
        AND rm.activeflag = 1
        AND rm.teamtypekey = v_teamtypekey
        AND rm.principalid = v_principalid::character varying
        AND r.activeflag = 1;

        -- If no roletypekey is found, default to the 'SPWL' placeholder role.
        -- This acts as a fallback for scenarios when an agency code change from 'cw' to 'as'.
        IF v_finalroletypekey IS NULL THEN
            v_finalroletypekey := 'SPWL';
        END IF;

        IF (v_finalroletypekey IS NOT NULL AND v_finalroletypekey != '' AND v_agencycode IS NOT NULL AND v_agencycode IN ('CW','AS','FNS','IV-E','LDSS','PVPROV','PROV','OLM')) THEN
            SELECT teamid INTO v_teamid
            FROM cjams.team
            WHERE teamnumber = v_teamcode
                AND activeflag = 1
            LIMIT 1;
            IF (v_teamid IS NULL) THEN
                SELECT countyid INTO v_countyid
                FROM cjams.county
                WHERE statecountycode = v_countycode
                    and activeflag = 1;
                    INSERT INTO cjams.team(
                            teamid,
                            activeflag,
                            teamname,
                            teamnumber,
                            teamtypekey,
                            description,
                            officetimingfrom,
                            officetimingto,
                            parentteamid,
                            insertedby,
                            insertedon,
                            updatedby,
                            updatedon,
                            effectivedate,
                            region,
                            regionid,
                            countyid,
                            supervisorid
                        )
                    VALUES (
                            gen_random_uuid(),
                            1,
                            v_teamname,
                            v_teamcode,
                            v_agencycode,
                            v_teamname,
                            '08:00:00'::time without time zone,
                            '16:00:00'::time without time zone,
                            v_countyid::character varying,
                            'ADMIN',
                            now(),
                            'ADMIN',
                            now(),
                            now(),
                            0,
                            null,
                            v_countyid::character varying,
                            null
                        )returning teamid into v_teamid;
                v_message := v_message || chr(10) || 'Inserted Into team table sucessfully';
            END IF;
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
                            if (v_finalroletypekey not in ('FTDMFW', 'QUINW', 'FTDMQIS')) then 
                                raise notice '>>>>>> Inside if (v_finalroletypekey not in (FTDMFW,QUINW,FTDMQIS) and v_ftdmroleexist > 0) then';
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
        END IF;

        IF array_length(v_actions_performed, 1) > 0 THEN
            v_response := 'User profile updated successfully: ' || array_to_string(v_actions_performed, ', ');
        ELSE
            v_response := 'User profile details are already up-to-date. No changes were made.';
        END IF;

    ELSE
        v_message := v_message || chr(10) || 'Error: New user, please add user before updating user profile details';
        v_response := 'Error: New user, please add user before updating user profile details: Error Code: 36001';
    END IF;

    -- Update the inputfromsailpoint with full log
    UPDATE cjams.inputfromsailpoint 
    SET message = v_message, response = v_response, updatedby = 'updateUserProfileDetails', updatedon = now()
    WHERE inputid = v_inputid;

    RETURN v_response;
END
$function$;
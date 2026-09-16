DROP FUNCTION IF EXISTS cjams.getCreateNewUsersInputParams(character varying);
CREATE OR REPLACE FUNCTION cjams.getCreateNewUsersInputParams(p_email character varying)
RETURNS text
LANGUAGE plpgsql
STABLE 
AS $BODY$

-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 6/11/2025 Anil Kumar Dharni - CIDM-10293-- Retrieves user information from database to populate parameters for cjams.useronboarding procedure based on email
-------------------------------------------------------------------------------------------------------------
DECLARE
    v_result text;
    v_user_exists boolean := false;
    v_firstname character varying;
    v_lastname character varying;
    v_email character varying;
    v_middlename character varying;
    v_fullname character varying;
    v_agencycode character varying;
    v_countycode character varying;
    v_staffid character varying;
    v_supervisorid character varying;
    v_assupervisorid character varying;
    v_securityusersid character varying;
    v_supervisor_email character varying;
    v_as_supervisor_email character varying;
    v_username character varying;
    v_cell_phone character varying;
    v_work_phone character varying;
    v_address character varying;
    v_city character varying;
    v_zipcode character varying;
    v_teamcode character varying;
    v_teamname character varying;
    v_positioncode character varying;
    v_positiontitle character varying;
    v_openamrole character varying;
    v_ldss character varying;
    v_roletypekey character varying;

BEGIN
SELECT 
        firstname,
        lastname,
        email,
        middlename,
        fullname,
        teamtypekey,
        primarycountycd,
        old_id,
        supervisorid,
        assupervisorid,
        securityusersid
    INTO 
        v_firstname,
        v_lastname,
        v_email,
        v_middlename,
        v_fullname,
        v_agencycode,
        v_countycode,
        v_staffid,
        v_supervisorid,
        v_assupervisorid,
        v_securityusersid
    FROM cjams.userprofile 
    WHERE LOWER(email) = LOWER(p_email) 
    LIMIT 1;
    
    IF v_firstname IS NOT NULL THEN
        v_user_exists := true;
        
        -- Get supervisor email if supervisorid exists
        IF v_supervisorid IS NOT NULL THEN
            SELECT email INTO v_supervisor_email
            FROM cjams.userprofile 
            WHERE securityusersid::uuid = v_supervisorid::uuid 
            AND activeflag = 1;
        END IF;
        
        -- Get AS supervisor email if assupervisorid exists
        IF v_assupervisorid IS NOT NULL THEN
            SELECT email INTO v_as_supervisor_email
            FROM cjams.userprofile 
            WHERE securityusersid::uuid = v_assupervisorid::uuid 
            AND activeflag = 1;
        END IF;
        
        -- Get username from securityusers
        SELECT username INTO v_username
        FROM cjams.securityusers 
        WHERE securityusersid::uuid = v_securityusersid::uuid 
        AND activeflag = 1;
        
        -- Get cell phone number
        SELECT phonenumber INTO v_cell_phone
        FROM cjams.userprofilephonenumber 
        WHERE securityusersid::uuid = v_securityusersid::uuid 
        AND LOWER(userprofiletypekey) = 'cell' 
        AND activeflag = 1 
        LIMIT 1;
        
        -- Get work phone number
        SELECT phonenumber INTO v_work_phone
        FROM cjams.userprofilephonenumber 
        WHERE securityusersid::uuid = v_securityusersid::uuid 
        AND LOWER(userprofiletypekey) = 'work' 
        AND activeflag = 1 
        LIMIT 1;
        
        -- Get address information
        SELECT address, city, zipcode 
        INTO v_address, v_city, v_zipcode
        FROM cjams.userprofileaddress 
        WHERE securityusersid::uuid = v_securityusersid::uuid 
        AND activeflag = 1 
        LIMIT 1;
        
        -- Get team information - checking regular teams first
        SELECT 
            t.teamnumber,
            t.teamname,
            tm.positioncode,
            tm.description,
            tm.roletypekey
        INTO 
            v_teamcode,
            v_teamname,
            v_positioncode,
            v_positiontitle,
            v_roletypekey
        FROM cjams.teammemberassignment tma
        JOIN cjams.teammember tm ON tma.teammemberid = tm.teammemberid
        JOIN cjams.team t ON tm.teamid = t.teamid
        WHERE tma.securityusersid::uuid = v_securityusersid::uuid 
        AND tma.activeflag = 1 
        AND tm.activeflag = 1 
        AND t.activeflag = 1
        LIMIT 1;
        
        -- If no regular team found and agencycode is AS, check AS teams
        IF v_teamcode IS NULL AND v_agencycode = 'AS' THEN
            SELECT 
                t.teamnumber,
                t.teamname,
                tm.positioncode,
                tm.description,
                tm.roletypekey
            INTO 
                v_teamcode,
                v_teamname,
                v_positioncode,
                v_positiontitle,
                v_roletypekey
            FROM cjams.as_teammemberassignment tma
            JOIN cjams.teammember tm ON tma.teammemberid = tm.teammemberid
            JOIN cjams.team t ON tm.teamid = t.teamid
            WHERE tma.securityusersid::uuid = v_securityusersid::uuid 
            AND tma.activeflag = 1 
            AND tm.activeflag = 1 
            AND t.activeflag = 1
            LIMIT 1;
        END IF;
        
        -- Get role information if roletypekey found
        IF v_roletypekey IS NOT NULL THEN
            SELECT openamrole INTO v_openamrole
            FROM cjams.role 
            WHERE roletypekey = v_roletypekey 
            AND activeflag = 1
            LIMIT 1;
        END IF;
        
        -- Get county name for LDSS
        IF v_countycode IS NOT NULL THEN
            SELECT countyname INTO v_ldss
            FROM cjams.county 
            WHERE statecountycode = v_countycode 
            AND activeflag = 1;
        END IF;
    END IF;

    IF v_user_exists THEN
        v_result := '(' ||
            quote_nullable(p_email) || ',' ||
            quote_nullable(v_firstname) || ',' ||
            quote_nullable(v_lastname) || ',' ||
            quote_nullable(v_middlename) || ',' ||
            quote_nullable(v_fullname) || ',' ||
            quote_nullable(v_agencycode) || ',' ||
            quote_nullable(v_openamrole) || ',' ||
            quote_nullable(v_countycode) || ',' ||
            quote_nullable(v_teamcode) || ',' ||
            quote_nullable(v_teamname) || ',' ||
            quote_nullable(v_ldss) || ',' ||
            quote_nullable(v_address) || ',' ||
            quote_nullable(v_city) || ',' ||
            quote_nullable(v_zipcode) || ',' ||
            quote_nullable(v_cell_phone) || ',' ||
            quote_nullable(v_staffid) || ',' ||
            quote_nullable(v_positioncode) || ',' ||
            quote_nullable(v_positiontitle) || ',' ||
            quote_nullable(v_username) || ',' ||
            quote_nullable(v_supervisor_email) || ',' ||
            quote_nullable(v_as_supervisor_email) || ',' ||
            quote_nullable('add') || ',' ||
            quote_nullable(v_work_phone) || ')';
    ELSE
        v_result := '()'; 
    END IF;

    RETURN v_result;

EXCEPTION
    WHEN OTHERS THEN
        RETURN 'ERROR: ' || SQLERRM;
END;
$BODY$;
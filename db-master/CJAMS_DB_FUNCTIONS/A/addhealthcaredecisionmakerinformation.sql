-- Drop the function if it already exists

--------------------------------------------------------------------------------------------------
-- 05/07/2025 prasanna sai kommineni - CIDM-10469 healthcare decision-maker record
-----------------------------------------------------------------------------------------------------
-- Create or replace the function to add a new healthcare decision-maker record
DROP FUNCTION IF EXISTS cjams.addhealthcaredecisionmakerinformation(
  v_records JSONB,
  v_securityuserid VARCHAR
);

CREATE OR REPLACE FUNCTION cjams.addhealthcaredecisionmakerinformation(
  v_records JSONB, -- Accept JSONB object
  v_securityuserid VARCHAR
) RETURNS SETOF UUID
LANGUAGE plpgsql
AS $function$
DECLARE
  record JSONB;
  flag record;
  v_healthcaredecisionmakerinformationid UUID;
BEGIN
  -- Loop through each JSONB object inside the "data" array
  FOR record IN SELECT * FROM jsonb_array_elements(v_records->'data') LOOP
    -- Check if healthcaredecisionmakerinformationid exists
    IF record->>'healthcaredecisionmakerinformationid' IS NOT NULL THEN
      -- Perform an update if ID exists
      UPDATE cjams.healthcaredecisionmakerinformation
      SET
        objecttype = record->>'objecttype',
        -- objectid = record->>'objectid',
        personid = record->>'personid',
        healthcaredecisionmaker = record->>'healthcaredecisionmaker',
        otherhcdm = record->>'otherhcdm',
        name = record->>'name',
        authorizedhcdm = record->>'authorizedhcdm',
        email = record->>'email',
        phonenumber = record->>'phonenumber',
        addressline1 = record->>'addressline1',
        addressline2 = record->>'addressline2',
        city = record->>'city',
        state = record->>'state',
        zip = record->>'zip',
        hcdmflag = record->>'hcdmflag',
        courtorderid = record->>'courtorderid',
        activeflag = 1, -- Default active flag
        updatedby = v_securityuserid,
        updatedon = NOW()
      WHERE healthcaredecisionmakerinformationid = (record->>'healthcaredecisionmakerinformationid')::UUID
      RETURNING healthcaredecisionmakerinformationid INTO v_healthcaredecisionmakerinformationid;
    ELSE
      -- Perform an insert if ID is missing
      INSERT INTO cjams.healthcaredecisionmakerinformation (
        objecttype, objectid, personid, healthcaredecisionmaker, otherhcdm, name,  
        authorizedhcdm, email, phonenumber, addressline1, addressline2,  
        city, state, zip, hcdmflag, activeflag,courtorderid, updatedby, updatedon, insertedby, insertedon
      )  
      VALUES (
        record->>'objecttype', record->>'objectid', record->>'personid',  
        record->>'healthcaredecisionmaker', record->>'otherhcdm', record->>'name',  
        record->>'authorizedhcdm', record->>'email', record->>'phonenumber',  
        record->>'addressline1', record->>'addressline2', record->>'city',  
        record->>'state', record->>'zip', record->>'hcdmflag', 1, -- Default active flag
       record->>'courtorderid', v_securityuserid, NOW(), v_securityuserid, NOW()
      )  
      RETURNING healthcaredecisionmakerinformationid INTO v_healthcaredecisionmakerinformationid;
      
    END IF;
select * into flag from cjams.generate_audit_data('healthcaredecisionmakerinformation',v_healthcaredecisionmakerinformationid::uuid);
    -- Return each processed ID
    RETURN NEXT v_healthcaredecisionmakerinformationid;
  END LOOP;
END;
$function$;
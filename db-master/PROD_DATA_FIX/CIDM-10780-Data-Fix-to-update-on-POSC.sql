/*
-- Issue Description: 
  Please do a data fix to change the value from Yes to No for "Has a Maltreatment Report been made CPS screening? "
  Case - 3307858  
-- Category/ Module: Services - plan of safe care 
-- Root cause: User Request
-- Fix Provided: datafix done to update the value from Yes to for  "Has a Maltreatment Report been made CPS screening? "
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE safecareplan
SET
    signatures = jsonb_set(
        signatures::jsonb, 
        '{showcourtvalue}', 
        '"no"'::jsonb      
    )::json,        
    updatedon = now() --updatedby is UUID type
WHERE
    safecareplanid = '90a3d8e4-413e-4b5d-b5f3-52913a123ff2'
    AND activeflag = 1;

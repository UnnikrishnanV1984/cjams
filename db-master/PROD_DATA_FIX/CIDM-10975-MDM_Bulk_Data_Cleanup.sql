/*
    Issue Description: CIDM-10975 MDM Load for Person Search Data Cleanup
    Category/Module: Person Module (Person Search Data Cleanup)
    Root cause: Data inconsistency/Poor Data quality in provider Users cannot be loaded in MDM Rules.
    Fix provided: Update default DOB as '1900-01-01' for provider users with null dob, and gender as 'U' (Reference Type from gendertypekey table).
    Data/Code fix ticket#: CIDM-10975
    Regression Impacts: N/A
    Is Code fix Required?: No
    Code fix ticket#: N/A
    Reason why no related code fix: Data fix only
*/

-- Updating DOB to '1900-01-01' where DOB is NULL and no active MDM_ID exists
UPDATE person p
SET dob = '1900-01-01',
    updatedon = now(),
    updatedby = 'CIDM-10975'
WHERE p.activeflag = 1
  AND NOT EXISTS (
        SELECT 1
          FROM cjams.personidentifier p2
         WHERE p2.personid = p.personid
           AND p2.personidentifiertypekey = 'MDM_ID'
           AND p2.activeflag = 1
  )
  AND dob is null;


-- Updating gendertype to 'U' where gendertype is NULL and no active MDM_ID exists
UPDATE person p
SET gendertypekey = 'U', -- Unknown gender 
    updatedby = 'CIDM-10975',
    updatedon = now()
WHERE p.activeflag = 1
  AND NOT EXISTS (
        SELECT 1
          FROM cjams.personidentifier p2
         WHERE p2.personid = p.personid
           AND p2.personidentifiertypekey = 'MDM_ID'
           AND p2.activeflag = 1
  )
  AND gendertypekey is null;


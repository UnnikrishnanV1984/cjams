/*
Issue Description: CIDM-10594 Legal Custody data issue
Category/Module: Legal Custody
Root cause: Person id is missing in some records for the legal custody table and we migh need to fix them as bulk data fix in this ticket.
            Tried multiple iterations to replicate this issue but it was not reproducible in stage-3 and local environment.
Fix provided: Bulk data fix has been done to insert personid into the legalcustody table as the part of this ticket.
Data/Code fix ticket#:CIDM-10594
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: TBD
Reason why no related code fix: We will closely monitor this scenario and raise a bulk data fix if needed.
*/


UPDATE legalcustody lc
SET personid = a.personid,
    updatedby = 'CIDM-10594',
    updatedon = now()
FROM intakeservicerequestactor isr
JOIN actor a ON isr.actorid = a.actorid
WHERE lc.personid IS NULL
  AND lc.intakeservicerequestactorid = isr.intakeservicerequestactorid
  AND lc.activeflag = 1
  AND a.personid IS NOT NULL;
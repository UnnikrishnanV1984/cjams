/*
   Issue Description: CDM-39363
   Category/ Module : Case Assignment and dashboard
   Root cause: Duplicate assignment 
   Fix Provided: Did data fix to remove duplicate family assignment

*/
UPDATE cjams.caseassignment
SET updatedby='CDM-39363', updatedon=now(), activeflag=0
WHERE caseassignmentid='9587dfd9-8892-4b5d-8cb2-123545062989' and objectid='16868616-4ef3-4c7d-baa4-9ef518851247';

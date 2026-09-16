
/*
-- Issue Description: 
	CDM-29904-intake-approval
	 Category/ Module: 
     -- Root cause: case close
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

UPDATE
  routing
SET
  routingstatustypeid = (
  SELECT
    sequencenumber
  FROM
    routingstatustype
  WHERE
    routingstatustypekey = 'Closed'
    AND activeflag = 1),
    updatedby = 'CDM-29904'
WHERE
  objectid = 'I221010227575';



update intakeservicerequestactor set activeflag = 0 , updatedby = 'CDM-29904' where 
intakeservicerequestactorid = 'aa490cc9-a246-4280-8b32-8c8ce493c097';
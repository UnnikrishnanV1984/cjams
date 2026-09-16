/*
-- Issue Description: 
	CDM-30392-intake-approval
	 Category/ Module: 
     -- Root cause: status not changed
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
    routingstatustypekey = 'Accepted'
    AND activeflag = 1),
    updatedby = 'CDM-30392'
WHERE
  objectid = 'I231010558734';
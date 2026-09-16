/*
 Issue Description: CDM-43168
-- Category/ Module: Assessment
-- Root cause: The rejected assessment cannot be deleted.
-- Fix Provided: Datafix has been promoted to update the record.
-- Pull request# N/A
-- Reason why no related code fix: Issue not reproduced in local and stage3
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE assessmentsubmission 
SET activeflag = 0,updatedby = 'CDM-43168',updatedon = now() 
WHERE assessmentid = '7ad4acec-4ecf-4ab5-9893-e4e676f1f70f';

UPDATE assessmentcomments 
SET activeflag = 0,updatedby = 'CDM-43168',updatedon = now() 
WHERE assessmentid = '7ad4acec-4ecf-4ab5-9893-e4e676f1f70f';

UPDATE assessment 
SET activeflag = 0,updatedby = 'CDM-43168',updatedon = now()
WHERE assessmentid = '7ad4acec-4ecf-4ab5-9893-e4e676f1f70f';

update routing 
set activeflag = 0, updatedby = 'CDM-43168',updatedon = now() 
where eventcode = 'ASST' and routingstatustypeid = 15 and activeflag = 1 
and objectid = '7ad4acec-4ecf-4ab5-9893-e4e676f1f70f' :: character varying;

update cjams.usernotification 
set activeflag = 0, updatedby = 'CDM-43168',updatedon = now() 
where objectid = '7ad4acec-4ecf-4ab5-9893-e4e676f1f70f' :: character varying and activeflag = 1;


/*
-- CDM-37794 - Francis Nnoruom is no longer able to select Case Workers on the Placement Validation screen.
-- Root cause: User roletypekey is 'LDSSRW' where as to select the caseworker he should be either 'CWCW' or 'CWSP'
-- Fix Provided: Datafix has been done by updating roletypekey to 'CWSP'.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select roletypekey,teammemberid,updatedby,updatedon  from teammember tm where teamid = '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6' and 
tm.teammemberid = '1b5bf06d-7490-4594-8eac-222203ace293' AND tm.activeflag = 1;

--UPDATE cjams.teammember
--SET roletypekey='LDSSRW', updatedby='ADMIN', updatedon='2024-03-21 16:04:54.475'
--WHERE teammemberid='1b5bf06d-7490-4594-8eac-222203ace293'::uuid;


update teammember set roletypekey='CWSP',updatedby = 'CDM-37794', updatedon = now() 
where teamid = '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6' 
and teammemberid = '1b5bf06d-7490-4594-8eac-222203ace293' AND activeflag = 1;
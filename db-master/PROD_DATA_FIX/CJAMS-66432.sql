/*
 Issue Description: CJAMS-66432
-- Category/ Module: CJAMS-66432
-- Root cause: The case had program assignent end dated as the case has been closed earlier , user has requested for reopening the  case as part of CJAMS-61787 ,To close the case the alleged victim should be in houseofhold tab and mfira for alleged victim should be approved then we will be able to close the case
-- Fix Provided: Datafix has been promoted to remove end date for program assignent.
-- Pull request# N/A
-- Reason why no related code fix: User Error
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update personprogramarea
set enddate =null,
updatedby='CJAMS-66432',
updatedon=now()
where personprogramid='b8d62242-c2db-4ed7-8569-6bc2309753c0' and activeflag=1;
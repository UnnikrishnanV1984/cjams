-- CDM-28425 -  Removal Issue
/*
-- Issue Description: 
  221030017644:The Child removal is done in CPS case which is not passed on to the service case due to the known issue at that time so users are not able to do placement in the service case.

-- Category/ Module: Child Removal
-- Root cause: Known issue
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Code fix has been done previously.
*/

update intakeservreqchildremoval 
set servicecaseid ='ae35aa50-257c-43c2-bac3-d1f37a5be381', updatedby ='CDM-28425', updatedon = now()
where intakeservreqchildremovalid = '37c13c9f-655b-4c4d-8325-12fefe02658e' and personid = '9da61ae7-d292-46ed-a4b6-6d0f8de88827';

UPDATE cjams.intakeservicerequestactor
SET servicecaseid='ae35aa50-257c-43c2-bac3-d1f37a5be381', updatedby='CDM-28425', updatedon=now()
WHERE intakeservicerequestactorid='975f56d2-25ea-46a1-948b-3543bc859089' and personid='9da61ae7-d292-46ed-a4b6-6d0f8de88827';


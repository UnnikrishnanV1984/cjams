
/*
-- Issue Description: 
   3293269:Unable to add a new placement, void current placement, or edit current placement. The placement is in rejected status from supervisor. Placement can not be edited due to not vacancy error showing when attempting to edit.
-- Category/ Module: Placement (Case Management) 
-- Root cause: User Error, requested for data fix to remove the placement
-- Fix provided: Datafix has been promoted to remove the duplicate placement 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

 update placement set activeflag = 0,updatedby ='CJAMS-65605', updatedon = now()
where placementid  = 'b5704c1b-3bd6-4f46-864f-acde552a9208';

update placementrevision set activeflag = 0,updatedby ='CJAMS-65605', updatedon = now()
where placementid  = 'b5704c1b-3bd6-4f46-864f-acde552a9208' and activeflag =1;

update routing set activeflag  =0, updatedby ='CJAMS-65605', updatedon = now()
where eventcode ='PLTR' and objectid = 'b5704c1b-3bd6-4f46-864f-acde552a9208' and activeflag = 1;

update livingarrangement set activeflag = 0,updatedby ='CJAMS-65605', updatedon = now()
where placementid  = 'b5704c1b-3bd6-4f46-864f-acde552a9208' and activeflag =1;
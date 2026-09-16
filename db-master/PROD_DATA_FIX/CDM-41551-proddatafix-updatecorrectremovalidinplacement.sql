/*
  Issue Description:  CDM-41551
   Category/ Module  :  placemenet
   Root cause: Placement is having incorrect removal id
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


-- 518e2708-9b0e-4d4c-bd10-4dd080ab9022
update placement set intakeservreqchildremovalid = '11cbbeb8-fd4e-4871-830f-82631f0d6549', updatedby = 'CDM-41551', updatedon = now()
where placementid = '71d84f79-27a9-49ba-9161-f69a9c590d6b';

-- f1cfa750-13df-4faf-a6da-7a99e2473be4
update placement set intakeservreqchildremovalid = '9a2b2357-bdbf-4353-8b09-8f9ac07866ba', updatedby = 'CDM-41551', updatedon = now()
where placementid = '4d4a8625-4151-4fb3-b02f-c49a991f9c86';
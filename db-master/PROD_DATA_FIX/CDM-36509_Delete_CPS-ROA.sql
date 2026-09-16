/*
   Issue Description: CDM-36509
   Category/ Module  : CPS ROA Case
   Case#: 231020532254
   Root cause: Delete this CPS ROA case as requested by user.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 

-- Remove the CPS AR Case # 231020532254 from CJAMS

select * from intakeservicerequest i where servicerequestnumber = '231020532254' and activeflag = 1;
-- Intakeserviceid - 373de408-cadf-473e-b81e-b7b348c0d644
-- servicecaseid - null
 
UPDATE intakeservicerequest  
SET  activeflag = 0, 
updatedby = 'CDM-36509', updatedon = now() 
WHERE intakeserviceid = '373de408-cadf-473e-b81e-b7b348c0d644' AND activeflag = 1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-36509', updatedon = now() 
where objectid = '373de408-cadf-473e-b81e-b7b348c0d644';

update routing
set activeflag = 0, updatedby = 'CDM-36509', updatedon = now() 
where objectid = '373de408-cadf-473e-b81e-b7b348c0d644' and activeflag = 1;

-- No records
select * from personprogramarea  WHERE objectid = '373de408-cadf-473e-b81e-b7b348c0d644' AND activeflag =1;
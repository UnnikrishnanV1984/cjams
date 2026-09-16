/*
-- CDM-21412 - 

-- Issue Description: 
 Reopen Case and GAP PA
  
-- Customer Email ID: kathryn.morton@maryland.gov

-- Root cause: Data fix to Reopen Case and GAP PA
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Closed        Closed        2021-09-01 22:03:21
UPDATE servicecase SET statustypekey = 'Open', 
                dispositioncode = 'Open', 
                enddate = null, 
                updatedby = 'CDM-21412',
                updatedon = now()
where servicecaseid = 'f52e1bab-274e-46f4-8f9a-0539cb413629';

UPDATE servicecasedisposition 
        SET activeflag = 0, 
                updatedby = 'CDM-21412',
                updatedon = now() 
WHERE servicecasedispositionid = '307c5624-e213-4e5c-ac0d-d563e965a164';

update personprogramarea
set enddate = null,
updatedby = 'CDM-21412',
updatedon = now() 
where personprogramid in ('6b40c901-bfee-4a32-b4ba-7754fc12cba8','ed9463db-a191-47bb-a81f-71b01fe55348','08076fc7-cdf4-4ea6-a736-85b789983b12');
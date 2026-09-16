-- CDM-36628- Entry to be deleted
/* 
-- Category/ Module: Permanency Plan
-- Root cause: User want to delete that future 1/24/2024 record #231030136438
-- Fix Provided: Datafix has been provided to remove/delete record
-- Pull request# N/A
*/

select * from permanencyplan where permanencyplanid='16c2e3ab-6296-42cc-a988-cf20d572dec0' and activeflag = 1;
-- Update
update permanencyplan set activeflag = 0, updatedby = 'CDM-36628', updatedon = now() where 
permanencyplanid='16c2e3ab-6296-42cc-a988-cf20d572dec0' and activeflag=1;


select * from permanencyplan_history where permanencyplanid='16c2e3ab-6296-42cc-a988-cf20d572dec0' and activeflag = 1;
-- Update
update permanencyplan_history set activeflag=0, updatedby = 'CDM-36628', updatedon = now() where
permanencyplanid='16c2e3ab-6296-42cc-a988-cf20d572dec0' and activeflag=1;


select * from routing where objectid ='16c2e3ab-6296-42cc-a988-cf20d572dec0';
-- Update
update routing set activeflag=0, updatedby = 'CDM-36628', updatedon = now() where
objectid ='16c2e3ab-6296-42cc-a988-cf20d572dec0' and activeflag=1;

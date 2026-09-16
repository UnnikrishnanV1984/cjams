-- CDM-36221- Two Unnecessary Open Service Cases
/* 
-- Issue Description: 
   User request to delete a dummy service case 
      
-- Case ID: 241030251544 - 7ae2cd72-3d80-446d-8005-64a505e2ecb0

-- Category/ Module: Case Deletion

-- Root cause: user created duplicate case by mistake
-- Fix Provided: Deleted record from servicecase, servicecasedisposition & routing. No record found in caseassginment
-- Pull request# N/A
*/


select * from servicecase where servicecasenumber = '241030251544';

update servicecase set activeflag = 0, updatedby = 'CDM-36221', updatedon = now()
where servicecaseid = '58de010a-2b18-43a4-82ec-f2cda35c31a0';

update servicecasedisposition set activeflag = 0, updatedon = now(), updatedby = 'CDM-36221' 
where servicecaseid = '58de010a-2b18-43a4-82ec-f2cda35c31a0' and servicecasedispositionid = '3e4da1d7-6c94-4f37-b9fe-feab097d9f69';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-36221' 
where routingid ='9ade7d43-fb8f-4a52-bf17-8a13b16961be' and objectid = '58de010a-2b18-43a4-82ec-f2cda35c31a0';

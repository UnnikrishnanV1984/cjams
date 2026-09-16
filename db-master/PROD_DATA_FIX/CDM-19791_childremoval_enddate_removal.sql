/*
   Issue Description: CDM-19791
   Category/ Module  : Child remvoal
   Root cause: user requeseted to remove the enddate for removal
*/

UPDATE Intakeservreqchildremoval
SET exitdate = null, updatedby = 'CDM-19791', updatedon = now() 
WHERE intakeservreqchildremovalid in  ('7baac211-3f49-40c7-b2ae-ef617d14148c', '64e6aeb0-87dc-4a0b-a87c-35c41a9145b0', '60042ce8-e823-49c9-9aa2-90bdde004ffc');

update personprogramarea 
set enddate = null, updatedby = 'CDM-19791', updatedon = now() 
where personprogramid in ('8d116030-de86-40d3-adab-b4f789dd192b', '1d9229d1-23ef-47df-868d-41828d3fce8e', 'a6989920-1056-44a2-89b3-ed6707be923a');


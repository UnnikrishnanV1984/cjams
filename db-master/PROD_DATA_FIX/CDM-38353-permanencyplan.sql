/*
   Issue Description: CDM-38353
   Issue: the permanencyplan table is table is having inactive intakeservicerequestactorid 
   Category/ Module  :Permanency Plan
   Root cause: update intakeservicerequestactorid for the child in  permanencyplan table     
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- Baltimore City      3118087                 2128963     
UPDATE cjams.permanencyplan
SET intakeservicerequestactorid='bc1a5672-fdbb-43d3-b921-d627c41b2ce2'::uuid, updatedon=now(), updatedby='CDM-38353'
WHERE permanencyplanid in ('9e16391c-6a75-4b8b-b54d-9ce2be0cd220', '6105a722-b773-4be0-b585-74b71eb2df16',
'c974d269-c4cb-4dc4-996e-7812883a40c7', '1edf3ab8-f53e-4263-8c63-51f52c40ebe4');
-- Baltimore City      3258861                 3394025 
UPDATE cjams.permanencyplan
SET intakeservicerequestactorid='00233f8a-7e77-4af5-8119-bb74dc0ffc09'::uuid, updatedon=now(), updatedby='CDM-38353'
WHERE permanencyplanid in ('36c4e2f9-7c7c-48fd-bcb0-3b51f51859bc','4c5b3691-12bb-4594-8ac0-cc8843494f89','0f77ebc4-e20d-452c-9f24-0bb0e36547bc',
'910ef0e7-bcc2-40d8-96aa-73fa4c24da76','2417669a-ef16-4234-9181-835c3f957610');

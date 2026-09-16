/*
   Issue Description: CDM-22509
   Category/ Module  : Prod data fix To remove Safe-C assessments
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 89b8a123-0f97-4a11-976e-b2e20e5fe461 -- April Jordan-Graham
update assessment set updatedby = '119b12f5-998a-4b78-8d07-1784a0d94906' where assessmentid = '434fe42b-76b1-4049-ab54-5f9678fc2f59';

-- Removing the Empty Record
-- aea0f4fb-b422-42aa-a957-c7c33769dbb6
update assessment set servicecaseid = '00000000-0000-0000-0000-000000000000', updatedby = 'CDM-22509', updatedon = now() where assessmentid = '23891ef7-7241-491f-815c-fa87dfc278ba';

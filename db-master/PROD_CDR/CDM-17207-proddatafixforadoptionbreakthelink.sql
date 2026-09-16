 /*
  Issue Description: CDM-17207
   Category/ Module  :  Permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update adoptionagreement set activeflag = 0, updatedby ='CDM-17207', updatedon = now() where adoptionagreementid in ('96b11078-d84d-4267-9a13-d67053f4f59a',
'6a5e71c3-0fab-4bb3-888d-001ab37b6a4c');
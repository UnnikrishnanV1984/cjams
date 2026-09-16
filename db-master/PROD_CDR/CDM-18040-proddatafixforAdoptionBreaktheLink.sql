 /*
  Issue Description: CDM-18040
   Category/ Module  :  Permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update adoptionagreement set activeflag = 0, updatedby ='CDM-18040', updatedon = now() where adoptionagreementid = '73055fe4-d4f0-46e8-8520-41f3f69b7f70';
